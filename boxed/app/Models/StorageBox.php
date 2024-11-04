<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StorageBox extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function getImageAttribute($value) {
        $file = "storage/images/storage-boxes/$value";
        return file_exists(public_path($file))? asset($file): asset('storage/images/default.jpeg');
    }
    
}
