<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wishlist extends Model
{
    use HasFactory;

    protected $table = 'wishlist';
    protected $primaryKey = 'id';
    public $timestamps = false;


    protected $fillable = [
        'id_authenticated_user',
    ];

    protected $casts = [
        'id_authenticated_user' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_authenticated_user');
    }

    public function WishlistProduct()
    {
        return $this->hasMany(WishlistProduct::class, 'id_wishlist');
    }



}
