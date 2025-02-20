<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\User;
use Illuminate\Http\Request;
use App\Events\PostLike;

class OrderController extends Controller
{
    

    public function index($id)
    {
        $user = auth()->user();

        $order = Order::find($id);

        $this->authorize('checkUser', $order);

            
        $productsCount = $order->productsCount();

        return view('pages.order', compact('user','order','productsCount'));
    }

    public function allOrders()
    {

        $user = auth()->user();
        $orders = $user->orders;
        
        $this->authorize('checkUser',$orders->first());

        return view('pages.fullorderHistory',compact('orders'));
    }

    public function deleteOrder($id) {

        $order = Order::find($id);

        $this->authorize('checkUser', $order);

        $order->delete();

        return redirect()->route('profile.show');
        
    }
}
