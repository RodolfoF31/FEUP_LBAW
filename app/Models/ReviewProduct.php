<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReviewProduct extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';

    protected $table = 'review_product';

    public $timestamps = false;

    protected $fillable = [
        'id_product', 'id_authenticated_user', 'date', 'comment', 'rating'
    ];

    protected $casts = [
        'id' => 'integer',
        'id_product' => 'integer',
        'id_authenticated_user' => 'integer',
        'date' => 'datetime',
        'comment' => 'string',
        'rating' => 'integer'
    ];

    public function getDateAttribute($value)
    {
        return \Carbon\Carbon::parse($value)->format('Y-m-d H:i');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'id_authenticated_user');
    }




}
