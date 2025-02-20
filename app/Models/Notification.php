<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

    protected $table = 'notification';

    protected $fillable = ['id_authenticated_user', 'text', 'is_read'];

    public function user() {
        return $this->belongsTo(User::class, 'id_authenticated_user');
    }
}
