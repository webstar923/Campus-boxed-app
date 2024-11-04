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
        return Carbon::parse($value)->format('M d y, h:i a');
    }
    
    public function getDropoffTimeAttribute($value) {
        return Carbon::parse($value)->format('M d y, h:i a');
    }

    public function getStatusBadgeAttribute($value) {
        $statuses = ['Awaiting Pickup', 'Picked Up'];
        $value--;
        return "<span class='badge badge-info'>$statuses[$value]</span>";
    }
}
