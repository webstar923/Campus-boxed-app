<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Reservation extends Model
{
    use HasFactory;

    protected $guarded = [];
    protected $appends = ['status_badge'];

    public function storageBox() {
        return $this->belongsTo(StorageBox::class);
    }
    
    public function packagingWrappers() {
        return $this->belongsToMany(PackagingWrapper::class)->withPivot('items');
    }

    public function getPickupTimeAttribute($value) {
        // return Carbon::parse($value)->format('M d y, h:i a');
        return Carbon::parse($value)->toIso8601String();
    }
    
    public function getDropoffTimeAttribute($value) {
        // return Carbon::parse($value)->format('M d y, h:i a');
        return Carbon::parse($value)->toIso8601String();
    }

    // public function getStatusBadgeAttribute($value) {
    //     $statuses = ['Awaiting Pickup', 'Picked Up'];
    //     $value--;
    //     return "<span class='badge badge-info'>$statuses[$value]</span>";
    // }
    
    public function getStatusBadgeAttribute() {
        // Define possible statuses
        $statuses = ['Awaiting Pickup', 'Picked Up'];
    
        // Assume `status` is a field in your database; adjust if necessary.
        $statusIndex = $this->attributes['status'] ?? null;
    
        // Ensure $statusIndex is valid and within range.
        if (is_null($statusIndex) || !isset($statuses[$statusIndex])) {
            return "<span class='badge badge-danger'>Unknown Status</span>";
        }
    
        // Return the badge HTML.
        return "<span class='badge badge-info'>{$statuses[$statusIndex]}</span>";
    }
    
}
