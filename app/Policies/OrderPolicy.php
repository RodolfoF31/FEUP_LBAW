<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Order;


class OrderPolicy
{
    public function checkUser(User $user, Order $order)
    {
        return $user->id === $order->id_authenticated_user;
    }

}
