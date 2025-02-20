<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductOnCartPriceChangeNotification extends Model
{
    use HasFactory;

    protected $table = 'productOnCartPriceChangeNotification';

    protected $fillable = ['id_shoppingCart', 'id_notification'];

    public function notification() {
        return $this->belongsTo(Notification::class, 'id_notification');
    }

    public function shoppingCart() {
        return $this->belongsTo(shoppingCart::class, 'id_shopping_cart');
    }
}
