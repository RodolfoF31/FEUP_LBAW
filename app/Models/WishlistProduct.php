<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WishlistProduct extends Model
{
    use HasFactory;

    protected $table = 'wishlist_product';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'id_wishlist',
        'id_product',
    ];

    public function wishlist()
    {
        return $this->belongsTo(Wishlist::class, 'id_wishlist');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }

}
