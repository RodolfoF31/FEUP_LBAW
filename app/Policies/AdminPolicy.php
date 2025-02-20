<?php

namespace App\Policies;

use App\Models\User;

class AdminPolicy
{
    public function accessAdminDashboard(User $user): bool
    {       
        return \DB::table('admin')->where('id', $user->id)->exists();
    }
}