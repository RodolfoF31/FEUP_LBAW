<?php

namespace App\Policies;

use App\Models\User;

class ProfilePolicy
{
    /**
     * Determine if the given user can be updated by the auth user.
     */
    public function update(User $authUser, User $user): bool
    {
        return $authUser->id === $user->id;
    }
}
