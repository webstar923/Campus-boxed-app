<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PackagingWrapper extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function reservations() {
        return $this->belongsToMany(Reservation::class)->withPivot('items');
    }

    public function getImageAttribute($value) {
        $file = "storage/images/packaging-wrappers/$value";
        return file_exists(public_path($file))? asset($file): asset('storage/images/default.jpeg');
    }
    
}
