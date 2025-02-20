<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Category;
use App\Models\ReviewProduct;
use App\Models\Author;
use App\Models\WishlistProduct;
use App\Models\ShoppingCartProduct;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Events\WishlistProductAvailable;
use App\Events\ProductCartPriceChanged;


class ProductController extends Controller
{
    public function index()
    {
        $products = Product::all();
        $categories = Category::all();

        return view('pages.mainpage', compact('categories', 'products'));
    }

    public function show($id)
    {
        $product = Product::with('author')->findOrFail($id);
        $reviews = ReviewProduct::where('id_product', $id)
            ->with('user')
            ->orderBy('date', 'desc')
            ->get();
        return view('pages.productpage', compact('product', 'reviews'));
    }



    public function showAddProductForm()
    {
        $categories = Category::all();
        $authors = Author::all();

        return view('admin.addProduct', compact('categories', 'authors'));
    }

    public function addProduct(Request $request)
    {
        $request->validate([
            'book_image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'book_title' => 'required|string|max:255',
            'book_description' => 'required|string',
            'book_price' => 'required|numeric|min:0',
            'book_stock' => 'required|integer|min:1',
            'book_category' => 'required|exists:category,categoryname',
            'book_author' => 'required|exists:author,name',
        ]);


        $imageName = $request->file('book_image')->getClientOriginalName();
        $imagePath = 'images/' . $imageName;
        $request->file('book_image')->move(public_path('images'), $imageName);



        $category = Category::where('categoryname', $request->book_category)->first();
        $author = Author::where('name', $request->book_author)->first();


        if (!$category) {

            \Log::error("Category not found: " . $request->book_category);
            return back()->withErrors(['error' => 'Category not found.']);
        }

        if (!$author) {

            \Log::error("Author not found: " . $request->book_author);
            return back()->withErrors(['error' => 'Author not found.']);
        }


        Product::create([
            'title' => $request->book_title,
            'description' => $request->book_description,
            'price' => $request->book_price,
            'stock' => $request->book_stock,
            'image' => $imagePath,
            'id_category' => $category->id,
            'id_author' => $author->id,
        ]);


        return redirect()->route('admin.addProduct')->with('success', 'Product added successfully!');
    }

    public function manageProducts()
    {
        $products = Product::with(['author', 'category'])->get();
        return view('admin.manageProducts', compact('products'));
    }

    public function edit($id)
    {
        $product = Product::findOrFail($id);
        $categories = Category::all();
        $authors = Author::all();
        return view('admin.editProduct', compact('product', 'categories', 'authors'));
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);
        $oldStock = $product->stock;
        $oldPrice = $product->price;
        $product->update($request->all());
        $newStock = $product->stock;
        $newPrice = $product->price;

        if ($oldStock == 0 && $newStock > 0) {
            // Get all users who have this product in their wishlist
            $wishlistUsers = WishlistProduct::where('id_product', $id)
                ->with('wishlist.user')
                ->get()
                ->pluck('wishlist.user');

            $message = "The product " . $product->title . " is now available!";

            foreach ($wishlistUsers as $user) {
                event(new WishlistProductAvailable($user->id, $message));
            }
        }

        if($oldPrice != $newPrice) {
            // Get all users who have this product in thei Shopping Cart
            $cartUsers = ShoppingCartProduct::where('id_product', $id)
                ->with('shoppingCart.user')
                ->get()
                ->pluck('shoppingCart.user')
                ->unique('id');

            $message = "The product " . $product->title . " has changed its price to " . $product->price . "€";

            foreach ($cartUsers as $user) {
                event(new ProductCartPriceChanged($user->id, $message));
            }
        }



        return redirect()->route('admin.manageProducts')->with('success', 'Product updated successfully');

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'id_category' => 'required|exists:category,id',
            'id_author' => 'required|exists:author,id',
            'image' => 'nullable|image|mimes:jpg,png,jpeg|max:2048',
        ]);

        $product = Product::findOrFail($id);

        if ($request->hasFile('image')) {

            $originalName = $request->file('image')->getClientOriginalName();
            $imagePath = $request->file('image')->storeAs('images', $originalName, 'public');
            $product->image = $imagePath;
        }


        $product->update($request->except('image') + ['image' => $product->image]);

        return redirect()->route('admin.manageProducts')->with('success', 'Product updated successfully.');
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);
        $product->delete();

        return redirect()->route('admin.manageProducts')->with('success', 'Product deleted successfully.');
    }


    //category operations   
    public function indexCategories()
    {
        $categories = Category::all();
        $html = '';
        foreach ($categories as $category) {
            $html .= view('partials.category', compact('category'))->render();
        }
        return response()->json(['html' => $html]);
    }

    public function deleteCategory($id)
    {
        $category = Category::findOrFail($id);

        if (Product::where('id_category', $id)->exists()) {
            return response()->json(['error' => 'Category cannot be deleted because it is associated with one or more products.']);
        }

        $category->delete();
        return response()->json(['success' => 'Category deleted successfully.']);
    }

    public function addCategory(Request $request)
    {
        $request->validate([
            'categoryname' => 'required|string|max:255|unique:category,categoryname',
        ]);

        \Log::info('Adding new category: ' . $request->categoryname);

        // Create and save the new category
        Category::create([
            'categoryname' => $request->categoryname,
        ]);

        return response()->json(['success' => 'Category added successfully.']);
    }



    //search operterations
    public function searchCategory($id_category)
    {
        $products = Product::where('id_category', $id_category)->get();
        $html = '';
        foreach ($products as $product) {
            $html .= view('partials.product', compact('product'))->render();
        }
        return response()->json(['html' => $html]);
    }

    public function search(Request $request)
    {
        $query = $request->input('q');
        if (empty($query)) {
            $products = Product::all();
        } else {
            // Normalize the query for full-text search
            $queryNormalized = str_replace(' ', ' & ', $query) . ':*';

            // Use the search_vector column with to_tsquery for full-text search
            $products = Product::whereRaw("search_vector @@ to_tsquery('english', ?)", [$queryNormalized])->get();
        }

        // Render the products into HTML
        $html = '';
        foreach ($products as $product) {
            $html .= view('partials.product', compact('product'))->render();
        }

        // Return the HTML as a JSON response
        return response()->json(['html' => $html]);
    }
}
