<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';

    protected $table = 'product';

    public $timestamps  = false;

    protected $fillable = [
        'id_category', 'id_author', 'title', 'description', 'price', 'stock', 'search_vector', 'image'
    ];

    public function author() 
    {
        return $this->belongsTo(Author::class, 'id_author');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'id_category');
    }

    public function reviews()
    {
        return $this->hasMany(ReviewProduct::class, 'id_product');
    }

    

}
