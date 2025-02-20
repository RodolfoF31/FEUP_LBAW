<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable; 

    // Don't add create and update timestamps in database.
    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'username',
        'email',
        'password',
        'fullname',
        'avatar'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array<string>
     */

    public function shoppingCart()
    {
        return $this->hasOne(ShoppingCart::class, 'id_authenticated_user');
    }

    public function paymentInfo()
    {
        return $this->hasOne(PaymentInfo::class, 'id_authenticated_user');
    }

    public function wishlist()
    {
        return $this->hasOne(Wishlist::class, 'id_authenticated_user');
    }

    public function orders()
    {
        return $this->hasMany(Order::class, 'id_authenticated_user');
    }

    public function allProductsWithStatus()
    {
        return $this->orders()->where('orderstatus', '!=', 'delivered')->get()->mapWithKeys(function ($order) {
            return [$order->id => $order->productsWithStatus()];
        });
    }

    public function allWishlistProducts()
    {
        return $this->wishlist->wishlistProduct->map(function ($wishlistProduct) {
            return $wishlistProduct->product;
        });
    }
    
    public function authenticatedUser()
    {
        return $this->hasOne(AuthenticatedUser::class, 'id');
    }
}
