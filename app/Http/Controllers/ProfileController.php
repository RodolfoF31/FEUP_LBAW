<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{

    public function show()
    {
        \Log::info('Showing profile page');

        
        $user = auth()->user();
        $paymentInfo = $user->paymentInfo;
        $orders = $user->allProductsWithStatus();
        $wishlist = $user->allWishlistProducts();
        return view('pages.profile', compact('user', 'paymentInfo', 'orders', 'wishlist'));

    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $this->authorize('update', $user);

        \Log::info('Updating profile for user: ' . $user->id );

        
        $this->validate($request, [
            'username' => 'required|string|max:20|unique:users,username,' . $user->id,
            'fullname' => 'nullable|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'new-password' => 'nullable|string|min:8',
            'shippedaddress' => 'required|string|max:255',
            'nif' => 'required|string|max:9',
            'cardNumber' => 'required|string|max:16',
        ]);
        

        $user->username = $request->input('username');
        $user->fullname = $request->input('fullname');
        $user->email = $request->input('email');
        
        if ($request->input('new-password') != null) {
            \Log::info('Password updated for user: ' . $user->id . ' - ' . $request->input('new-password'));
            $user->password = bcrypt($request->input('new-password'));
        }
            
        $user->save();

        $paymentInfo = $user->paymentInfo;
        $paymentInfo->shippedaddress = $request->input('shippedaddress');
        $paymentInfo->nif = $request->input('nif');
        $paymentInfo->cardnumber = $request->input('cardNumber');
        $paymentInfo->save();

        return redirect()->route('profile.show')->with('success', 'Profile updated successfully.');
    }

    public function updateAvatar(Request $request, $id)
    {
        $this->validate($request, [
            'avatar' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = User::findOrFail($id);

        // Authorize the update action
        $this->authorize('update', $user);

        if ($request->hasFile('avatar')) {
            $avatar = $request->file('avatar');
            $avatarName = time() . '.' . $avatar->getClientOriginalExtension();
            $avatar->storeAs('public/avatars', $avatarName);
            $user->avatar = $avatarName;
            $user->save();
        }

        // Redirect with success message
        return redirect()->route('profile.show')->with('success', 'Avatar updated successfully.');
    }
}
