<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderProduct extends Model
{
    use HasFactory;

    protected $table = 'order_product';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'id_order',
        'id_product',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'id_order');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }
}
