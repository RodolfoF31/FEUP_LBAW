<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShoppingCartProduct extends Model
{
    use HasFactory;

    protected $table = "shoppingCartProduct";

    protected $fillable = ['id_shopping_cart', 'id_product'];

    public $timestamps = false;

    public function product(){
        return $this->belongsTo(Product::class, 'id_product');
    }

    public function shoppingCart(){
        return $this->belongsTo(ShoppingCart::class, 'id_shopping_cart');
    }
}
