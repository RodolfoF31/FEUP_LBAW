<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class EnsureValidPasswordReset
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next)
    {
        // Verifica se o e-mail e o token estão na sessão
        if (!session()->has('email') || !session()->has('token')) {
            return redirect()->route('password.request')
                ->withErrors(['error' => 'Unauthorized access to password reset page.']);
        }

        return $next($request);
    }
}
