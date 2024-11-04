<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{Reservation, PackagingWrapper};
use App\Traits\{ApiResponsesTrait, PaymentTrait};
use Auth;

class ReservationController extends Controller
{
    use ApiResponsesTrait;
    
    public function store(Request $request) {
        $request->validate([
            'storage_box_id' => 'required',
            'pickup_time' => 'sometimes',
            'dropoff_time' => 'sometimes',
            'items_packed_labeled' => 'sometimes',
            'items_pickup_ready' => 'sometimes',
            'items_movers_possession' => 'sometimes',
            'status' => 'sometimes',
            'packaging_wrapper_ids' => 'sometimes|array',
        ]);

        $reservationInput = $request->except(['packaging_wrapper_ids', 'packaging_wrapper_items']);
        $reservationInput['user_id'] = Auth::user()->id;
        // $reservationInput['items'] = json_encode($request->packaging_wrapper_items);
        // dd($reservationInput);
        
        $reservation = Reservation::create($reservationInput);
        foreach ($request->packaging_wrapper_ids as $packagingWrapperId) {
            $packagingWrapper = PackagingWrapper::find($packagingWrapperId['id']);

            $packagingWrapper->reservations()->attach($reservation, ["items" => json_encode($packagingWrapperId['items'])]);
        }
        
        $data = $reservation->load('packagingWrappers');

        return $this->success($data, "Box Reserved Succussfully");
    }
}
