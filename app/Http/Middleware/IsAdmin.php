<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class IsAdmin
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next)
    {
        $user = Auth::user();

        // Verifica se o ID do usuário está na tabela "administrator"
        $isAdmin = DB::table('admin')
            ->where('id', $user->id)
            ->exists();

        if (!$isAdmin) {
            // Redireciona para uma página padrão se o usuário não for admin
            return redirect('/mainpage')->with('error', 'Access denied. Admins only.');
        }

        return $next($request);
    }
}
