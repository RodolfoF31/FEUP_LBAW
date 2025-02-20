<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\ReviewProduct;
use App\Models\OrderProduct;
use App\Models\Product;
use Illuminate\Support\Facades\Log;


class ReviewProductController extends Controller
{
    public function createReviewProduct(Request $request)
    {
        if (!Auth::check()) return redirect('login');

        $request->validate([
            'id_product' => 'required|integer|', 
            'comment' => 'required|string|max:500', 
            'rating' => 'required|integer|min:1|max:5' 
        ]);
        

        ReviewProduct::insert([
            'id_product' => $request->id_product,
            'id_authenticated_user' => Auth::id(),
            'date' => now(),
            'comment' => $request->comment,
            'rating' => $request->rating,
        ]);
        

        return redirect()->back()->with('success', 'Review submitted successfully!');


    }
    public function edit($id)
    {
        $review = ReviewProduct::findOrFail($id);

        $product = Product::findOrFail($review->id_product);

        if ($review->id_authenticated_user !== Auth::id()) {
            abort(403, 'Unauthorized action.');
        }

        return view('reviews.edit', compact('review', 'product'));
    }
    public function update(Request $request, $id)
    {
        $review = ReviewProduct::findOrFail($id);

        if ($review->id_authenticated_user !== Auth::id()) {
            abort(403, 'Unauthorized action.');
        }

        $request->validate([
            'comment' => 'required|string|max:500',
            'rating' => 'required|integer|min:1|max:5'
        ]);

        $review->update([
            'comment' => $request->comment,
            'rating' => $request->rating,
        ]);

        return redirect()->route('product.show', $review->id_product)->with('success', 'Review updated successfully!');
    }

    public function destroy($id)
    {
        $review = ReviewProduct::findOrFail($id);

        if ($review->id_authenticated_user !== Auth::id()) {
            abort(403, 'Unauthorized action.');
        }

        $review->delete();

        return redirect()->back()->with('success', 'Review deleted successfully!');
    }

    public function ajaxUpdate(Request $request, $id)
    {
        $review = ReviewProduct::findOrFail($id);

        if ($review->id_authenticated_user !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $request->validate([
            'comment' => 'required|string|max:500',
            'rating' => 'required|integer|min:1|max:5',
        ]);

        $review->update([
            'comment' => $request->comment,
            'rating' => $request->rating,
        ]);

        return response()->json(['message' => 'Review updated successfully!', 'review' => $review]);
    }

    public function ajaxDestroy($id)
    {
        $review = ReviewProduct::findOrFail($id);

        if ($review->id_authenticated_user !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $review->delete();

        return response()->json(['message' => 'Review deleted successfully!']);
    }

}
