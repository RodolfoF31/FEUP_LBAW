<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShoppingCart extends Model
{
    use HasFactory;

    public $timestamps = false;
    
    protected $table = "shoppingCart";

    protected $fillable = ['id_authenticated_user'];

    public function shoppingCartProducts(){
        return $this->hasMany(ShoppingCartProduct::class, "id_shopping_cart");
    }

    public function user(){
        return $this->belongsTo(User::class, "id_authenticated_user");
    }

    public function getValue(){
        return $this->shoppingCartProducts()->with('product')->get()->sum(function($shoppingCartProduct) {
            return $shoppingCartProduct->product->price;
        });
    }

    public function getItemCount(){
        return $this->shoppingCartProducts()->count();
    }



    public function resetShoppingCart(){
        $this->shoppingCartProducts()->delete();
    }
}
