<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;


class RestrictAdminAccess
{
    public function handle(Request $request, Closure $next)
    {
        $user = Auth::user();

        // Check if the user is an admin
        $isAdmin = DB::table('admin');
            if ($user) {
                $isAdmin = DB::table('admin')
                ->where('id', $user->id)
                ->exists();
            } else {
                $isAdmin = false;
            }

        if ($isAdmin) {
            // Redirect to a different page if the user is an admin
            return redirect('/mainpage')->with('error', 'Access denied. Admins cannot access the shopping cart.');
        }

        return $next($request);
    }
}
