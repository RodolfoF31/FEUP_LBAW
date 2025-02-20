<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentInfo extends Model
{
    use HasFactory;
    protected $table = 'payment_info';
    protected $primaryKey = 'id';
    public $timestamps = false; 
    protected $fillable = [
        'id_authenticated_user',
        'shippedaddress',
        'nif',
        'cardnumber',
    ];
    protected $casts = [
        'id_authenticated_user' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_authenticated_user');
    }
}
