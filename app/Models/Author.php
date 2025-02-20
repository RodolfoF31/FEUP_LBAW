<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Author extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';

    protected $table = 'author';

    public $timestamps  = false;

    protected $fillable = ['name', 'biography', 'rating'];

    public function products()
    {
        return $this->hasMany(Product::class, 'id_author');
    }
}
