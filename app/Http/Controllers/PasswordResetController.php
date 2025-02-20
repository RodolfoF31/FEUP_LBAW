<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Mail\PasswordResetMail;
use App\Models\User;


class PasswordResetController extends Controller
{
     //Handle password reset request and send token via email.
     public function sendResetToken(Request $request)
     {
         $request->validate([
             'email' => 'required|email|exists:users,email',
         ]);
     
         // Gera um token aleatório
         $token = strtoupper(Str::random(6)); // String de 6 caracteres
     
         // Salva o token na tabela password_resets
         DB::table('password_resets')->updateOrInsert(
             ['email' => $request->email],
             [
                 'token' => $token,
                 'created_at' => Carbon::now(),
             ]
         );
     
         // Envia o e-mail com o token
         $mailData = ['token' => $token];
         Mail::to($request->email)->send(new PasswordResetMail($mailData));
         
         // Armazena o e-mail na sessão
         session()->put('email', $request->email);
         
         // Redireciona para a página de verificação de token
         return redirect()->route('password.verifyToken');
    }
     
    
    // Verify if the provided token is valid.
    public function verifyToken(Request $request)
{
    $request->validate([
        'email' => 'required|email|exists:users,email',
        'token' => 'required|string|min:6|max:6',
    ]);

    $resetRequest = DB::table('password_resets')
        ->where('email', $request->email)
        ->where('token', $request->token)
        ->first();

    if (!$resetRequest) {
        return redirect()->back()->withErrors(['error' => 'Invalid token.']);
    }

    $expirationTime = Carbon::parse($resetRequest->created_at)->addMinutes(15);
    if (Carbon::now()->greaterThan($expirationTime)) {
        return redirect()->back()->withErrors(['error' => 'The token has expired.']);
    }

    // Se o token for válido, redireciona para a página de redefinição de senha
    return redirect()->route('password.reset')->with([
        'email' => $request->email,
        'token' => $request->token,
    ]);
    }
    
    //Reset the user's password.
    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'token' => 'required|string|min:6|max:6',
            'password' => 'required|string|min:8|confirmed',
        ]);
    
        $resetRequest = DB::table('password_resets')
            ->where('email', $request->email)
            ->where('token', $request->token)
            ->first();
    
        if (!$resetRequest) {
            return redirect()->back()->withErrors(['error' => 'Invalid token or email.']);
        }
    
        $expirationTime = Carbon::parse($resetRequest->created_at)->addMinutes(15);
        if (Carbon::now()->greaterThan($expirationTime)) {
            return redirect()->back()->withErrors(['error' => 'The token has expired.']);
        }
    
        // Atualiza a senha do usuário
        User::where('email', $request->email)->update([
            'password' => bcrypt($request->password),
        ]);
    
        // Remove o token da tabela após o uso
        DB::table('password_resets')->where('email', $request->email)->delete();
    
         // Limpa a sessão
        session()->forget(['email', 'token']);
        
        return redirect()->route('login')->with('success', 'Password reset successfully. Please log in.');
    }
    




}
