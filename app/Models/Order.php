<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $table = 'orders';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'id_authenticated_user',
        'orderdate',
        'arrivaldate',
        'shippedaddress',
        'totalprice',
        'orderstatus',
    ];

    protected $casts = [
        'id_authenticated_user' => 'integer',
        'orderDate' => 'date',
        'arrivalDate' => 'date',
        'totalPrice' => 'float',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_authenticated_user');
    }

    public function orderProducts()
    {
        return $this->hasMany(OrderProduct::class, 'id_order');
    }

    public function totalCost()
    {
        return $this->orderProducts()
        ->with('product')
        ->get()
        ->sum(function ($orderProduct) {
            return $orderProduct->product->price;
        });
    }

    public function productsCount()
    {
        return $this->orderProducts()
            ->selectRaw('count(*) as count, id_product')
            ->groupBy('id_product')
            ->with('product')
            ->get()
            ->map(function ($orderProduct) {
                return [
                    'count' => $orderProduct->count,
                    'product' => $orderProduct->product
                ];
            });
    }


    public function productsWithStatus()
    {
        return [
            'order' => $this,
            'products' => $this->orderProducts->map(function ($orderProduct) {
                return $orderProduct->product;
            })->toArray()
        ];
    }
}
