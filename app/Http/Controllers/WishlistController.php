<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Wishlist;
use App\Models\WishlistProduct;

class WishlistController extends Controller
{
    public function addProduct(Request $request)
    {
        $user = auth()->user();
        $wishlist = $user->wishlist;

        if (!$wishlist) {
            $wishlist = Wishlist::create(['id_authenticated_user' => $user->id]);
        }

        $product_id = $request->input('product_id');

        // Check if the product is already in the wishlist
        if ($wishlist->WishlistProduct()->where('id_product', $product_id)->exists()) {
            return response()->json(['success' => false, 'message' => 'Product is already in the wishlist']);
        }

        WishlistProduct::create([
            'id_wishlist' => $wishlist->id,
            'id_product' => $product_id,
        ]);

        return response()->json(['success' => true, 'message' => 'Product added to wishlist successfully']);
    }

    public function removeProduct(Request $request)
    {
        $user = auth()->user();
        $wishlist = $user->wishlist;

        if (!$wishlist) {
            return response()->json(['success' => false, 'message' => 'Wishlist not found']);
        }

        $product_id = $request->input('product_id');

        $wishlistProduct = $wishlist->WishlistProduct()->where('id_product', $product_id)->first();

        if (!$wishlistProduct) {
            return response()->json(['success' => false, 'message' => 'Product not found in wishlist']);
        }

        $wishlistProduct->delete();

        return response()->json(['success' => true, 'message' => 'Product removed from wishlist successfully']);
    }


}
