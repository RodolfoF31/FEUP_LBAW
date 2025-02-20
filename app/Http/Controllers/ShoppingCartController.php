<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\ShoppingCart;
use App\Models\ShoppingCartProduct;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Gate;


class ShoppingCartController extends Controller
{
    public function index(){
        $shoppingCartProducts = [];

        if (Auth::check()) {
            $user = Auth::id();
            $shoppingCart = ShoppingCart::where('id_authenticated_user', $user)->first();
            if ($shoppingCart) {
                $shoppingCartProducts = $shoppingCart->shoppingCartProducts;
            }
        } else {
            $cart = json_decode(Cookie::get('cart', '[]'), true);
            foreach ($cart as $product_id) {
                $product = Product::find($product_id);
                if ($product) {
                    $shoppingCartProducts[] = $product;
                }
            }
        }

        return view('pages/shoppingCart', compact('shoppingCartProducts'));
    }

    public function removeProduct(Request $request){
        try {
            if(Auth::check()) {
                $user = Auth::id();
                $shoppingCart = ShoppingCart::where('id_authenticated_user', $user)->first();
                
                if ($shoppingCart) {
                    $shopping_cart_product_id = $request->input('id');

                    $shoppingCartProduct = ShoppingCartProduct::where('id_shopping_cart', $shoppingCart->id)
                                                            ->where('id', $shopping_cart_product_id)
                                                            ->first();

                    if ($shoppingCartProduct) {
                        $shoppingCartProduct->delete();
                        return response()->json(['success' => true, 'message' => 'Product removed from cart']);
                    }
                }
            } else {
                $product_id = $request->input('id');
                $cart = json_decode(Cookie::get('cart', '[]'), true);
                $cart = array_filter($cart, function($item) use ($product_id) {
                    return $item !== $product_id; // Remove product with matching ID
                });
                Cookie::queue('cart', json_encode($cart), 64*24*30);
            }

            return response()->json(['success' => true, 'message' => 'Product removed']);
        } catch (\Exception $e){
            return response()->json(['success' => false, 'message' => 'Product not found in cart'], 404);
        }
    }

    public function addProduct(Request $request){
        try {
            $product_id = $request->input('product_id');
            $product = Product::find($product_id);
            if (!$product) {
                return response()->json(['success' => false, 'message' => 'Product not found'], 404);
            }

            if(Gate::allows('accessAdminDashboard', Auth::user())) {
                return response()->json(['success' => false, 'message' => 'Admins cannot add products to the cart'], 403);
            }

            if (Auth::check()) {
                $user = Auth::id();
                $shoppingCart = ShoppingCart::firstOrCreate(['id_authenticated_user' => $user]);
                $shoppingCartProduct = new ShoppingCartProduct([
                'id_shopping_cart' => $shoppingCart->id,
                'id_product' => $product_id
                ]);
                $shoppingCartProduct->save();
            } else {
                $cart = json_decode(Cookie::get('cart', '[]'), true);
                $cart[] = $product_id;
                Cookie::queue('cart', json_encode($cart), 60*24*30); // Store for 30 days
            }
            
            return response()->json(['success' => true, 'message' => 'Product added to cart']);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => 'Error adding product to cart'], 500);
        }
    }

    public function getItemCount() {
        $user = Auth::user();
        $itemCount = 0;

        if($user) {
            $itemCount = $user->shoppingCart->getItemCount();
        } else {
            $cart = json_decode(Cookie::get('cart', '[]'), true);
            $itemCount = count($cart);
        }

        return response()->json(['itemCount' => $itemCount]);
    }

    public function getSubtotal() {
        $user = Auth::user();
        $subtotal = 0;

        if($user) {
            $subtotal = $user->shoppingCart->getValue();
        } else {
            $cart = json_decode(Cookie::get('cart', '[]'), true);
            foreach ($cart as $product_id) {
                $product = Product::find($product_id);
                if ($product) $subtotal += $product->price;
            }
        }

        return response()->json(['subtotal' => round($subtotal, 2)]);
    }
}