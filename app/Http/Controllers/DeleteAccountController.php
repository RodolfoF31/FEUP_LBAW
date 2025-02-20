<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class DeleteAccountController extends Controller
{
    public function anonymize(Request $request)
    {
        // Verifica se o usuário está autenticado
        $user = Auth::user();

        if (!$user) {
            return redirect()->route('login')->with('error', 'You need to be logged in to perform this action.');
        }

        // Limpa informações do usuário
        DB::transaction(function () use ($user) {
            // Atualiza a tabela de usuários
            $user->update([
                'username' => 'deletedUser' . $user->id,
                'email' => 'deletedUser' . $user->id . '@du.com',
                'fullname' => 'deletedUser' . $user->id,
                'password' => bcrypt('deleted_user_placeholder'),
                'avatar' => null,
            ]);
            

            // Remove informações de paymentInfo
            DB::table('payment_info')
                ->where('id_authenticated_user', $user->id)
                ->update([
                    'shippedaddress' => null,
                    'nif' => null,
                    'cardnumber' => null,
                ]);

            // Remove informações de shoppingCart
            DB::table('shoppingCart')
                ->where('id_authenticated_user', $user->id)
                ->delete();

            // Remove informações de wishlist
            DB::table('wishlist')
                ->where('id_authenticated_user', $user->id)
                ->delete();

            // Opcional: Desativa autenticação
            Auth::logout();
        });

        return redirect()->route('login')->with('success', 'Your account has been anonymized successfully.');
    }
}
