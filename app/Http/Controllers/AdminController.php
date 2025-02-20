<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Log;
use App\Models\Author;
use App\Models\Order;
use App\Models\User;
use App\Events\OrderStatusChanged;

class AdminController extends Controller
{

    public function showDashboard()
    {
        if (!Gate::allows('accessAdminDashboard')) {
            abort(403, 'Unauthorized access.');
        }
        $authors = Author::all(); 
        $adminIds = \DB::table('admin')->pluck('id')->toArray();
        $users = User::whereNotIn('id', $adminIds)->where('isbanned', false)->get();
        return view('admin.dashboard', compact('authors', 'users')); 
    }

    public function store(Request $request)
    {
        
        $request->validate([
            'name' => 'required|string|max:255',
            'biography' => 'required|string',
            'rating' => 'required|integer|between:0,5',
        ]);

        
        Author::create([
            'name' => $request->name,
            'biography' => $request->biography,
            'rating' => $request->rating,
        ]);

        return redirect()->back()->with('success', 'Author added successfully.');
    }

    public function destroy($id)
    {
        Author::findOrFail($id)->delete();
        return redirect()->back()->with('success', 'Author deleted successfully.');
    }

    public function showManageOrders() {
        $orders = Order::with('user', 'orderProducts.product')->orderBy('id')->get();
        return view('admin.manageOrders', compact('orders'));
    }

    public function updateOrderStatus(Request $request) {
        try {
            $order = Order::findOrFail($request ->input('order_id'));
            $order->orderstatus = $request->input('orderstatus');
            $order->save();

            $message = "Your order's status has been updated to " . $order->orderstatus;
            event(new OrderStatusChanged($order->id_authenticated_user, $message));

            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            Log::error('Error updating order status: ' . $e->getMessage());
            return response()->json(['success' => false, 'message' => 'Failed to update order status'], 500);
        }
    }

    public function showManageUsers() {
        $users = User::all();
        return view('admin.dashboard', compact('users'));
    }

    public function banUser(Request $request) {
        try {
            $user = User::findOrFail($request->input('user_id'));
            $user->isbanned = true;
            $user->save();

            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            Log::error('Error banning user: ' . $e->getMessage(), ['exception' => $e]);
            return response()->json(['success' => false, 'message' => 'Failed to ban user'], 500);
        }
    }
}
