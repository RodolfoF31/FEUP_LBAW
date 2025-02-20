<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;
use App\Models\ShoppingCart;
use App\Models\ShoppingCartProduct;
use App\Models\User;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Log;

class LoginController extends Controller
{

    /**
     * Display a login form.
     */
    public function showLoginForm()
    {
        if (Auth::check()) {
            return redirect('/mainpage');
        } else {
            return view('auth.login');
        }
    }

    public function authenticated(Request $request, $user){
        $shoppingCart = ShoppingCart::firstOrCreate(['id_authenticated_user' => $user->id]);
        $cart = json_decode(Cookie::get('cart', '[]'), true);
        foreach ($cart as $product_id) {
            ShoppingCartProduct::create([
                'id_shopping_cart' => $shoppingCart->id,
                'id_product' => $product_id
            ]);
        }
        Log::info($cart);

        Cookie::queue(Cookie::forget('cart'));

        return $this->redirectBasedOnRole($user);
    }

    /**
     * Handle an authentication attempt.
     */
    public function authenticate(Request $request): RedirectResponse
    {
    // Valida as credenciais
    $credentials = $request->validate([
        'email' => ['required', 'email'],
        'password' => ['required'],
    ]);

    // Busca o usuário pelo e-mail
    $user = User::where('email', $credentials['email'])->first();

    // Verificação de conta banida
    if ($user && $user->isbanned) {
        Log::warning("Attempt to login with a banned account: {$user->email}");
        return back()->withErrors([
            'email' => 'Your account has been banned.',
        ])->onlyInput('email');
    }

    // Tenta autenticar o usuário
    if ($user && Auth::attempt($credentials, $request->filled('remember'))) {
        Log::info("User {$user->email} successfully logged in.");
        $request->session()->regenerate();

        // Redireciona com base no tipo de usuário
        return $this->authenticated($request, Auth::user());
    }

    // Feedback para credenciais inválidas
    if ($user) {
        Log::warning("Failed login attempt for user {$user->email} with incorrect password.");
    } else {
        Log::warning("Failed login attempt for non-existent email: {$credentials['email']}");
    }

    return back()->withErrors([
        'email' => 'The provided credentials do not match our records.',
    ])->onlyInput('email');

    }


    /**
     * Log out the user from application.
     */
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect()->route('login')
            ->withSuccess('You have logged out successfully!');
    }

    /**
     * Handle post-login redirection based on user role.
     */
    private function redirectBasedOnRole($user): RedirectResponse
    {
        // Verifica se o usuário é um administrador
        $isAdmin = DB::table('admin')
            ->where('id', $user->id)
            ->exists();

        if ($isAdmin) {
            return redirect()->route('admin.dashboard'); // Rota para admin
        }

        return redirect('/mainpage'); // Rota para usuário comum
    }
}
