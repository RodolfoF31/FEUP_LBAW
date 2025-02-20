<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cookie;

use Illuminate\View\View;

use App\Models\User;
use App\Models\ShoppingCart;
use App\Models\ShoppingCartProduct;

class RegisterController extends Controller
{
    /**
     * Display a login form.
     */
    public function showRegistrationForm(): View
    {
        return view('auth.register');
    }

    /**
     * Register a new user.
     */
    public function register(Request $request)
    {
        $bannedUser = User::where('email', $request->email)->where('isbanned', true)->first();
        if ($bannedUser) {
            return back()->withErrors([
                'email' => 'That email is banned.',
            ])->onlyInput('email');
        }
        
        $request->validate([
            'username' => 'required|string|max:20|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'fullname' => 'nullable|string|max:255',
        ]);

        // Cria o novo usuário
        $user = User::create([
            'username' => $request->username,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'fullname' => $request->fullname,
        ]);

        // Insere o ID do usuário na tabela `authenticated_user`
        $authenticatedUserId = DB::table('authenticated_user')->insertGetId([
            'id' => $user->id, // Usa o ID recém-criado da tabela `users`
        ]);

        // Cria um shopping cart associado ao authenticated_user
        $shoppingCart = ShoppingCart::create(['id_authenticated_user' => $authenticatedUserId]);

        $cart = json_decode(Cookie::get('cart', '[]'), true);
        foreach ($cart as $product_id) {
            ShoppingCartProduct::create([
                'id_shopping_cart' => $shoppingCart->id,
                'id_product' => $product_id
            ]);
        }

        Cookie::queue(Cookie::forget('cart'));

        // Autentica o usuário e redireciona
        $credentials = $request->only('email', 'password');
        Auth::attempt($credentials);
        $request->session()->regenerate();
        return redirect('/mainpage')
            ->withSuccess('You have successfully registered & logged in!');
    }
}
