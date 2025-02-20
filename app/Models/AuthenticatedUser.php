<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AuthenticatedUser extends Model
{
    use HasFactory;

    
    protected $table = 'authenticated_user'; 

    public $timestamps = false; 

    
    public function user()
    {
        return $this->belongsTo(User::class, 'id'); 
    }

    public function reviews()
    {
        return $this->hasMany(ReviewProduct::class, 'id_authenticated_user');
    }

    public function notifications() {
        return $this->hasMany(Notification::class, 'id_authenticated_user');
    }
}
