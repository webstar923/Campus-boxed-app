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
            'receiver_email' => 'required|email',
            'receiver_phone' => 'nullable|string|max:20',
        ]);

        // $reservationInput = $request->except(['packaging_wrapper_ids', 'packaging_wrapper_items', 'card_number', 'expiration_date', 'cvc', 'zip_code']);
        $reservationInput = $request->except(['card_number', 'expiration_date', 'cvc', 'zip_code']);
        // new working
        $reservationInput['user_id'] = $request->sender_id ;
        // $reservationInput['user_id'] = Auth::user()->id;


        // $reservationInput['items'] = json_encode($request->packaging_wrapper_items);
        // $reservation = Reservation::create($reservationInput);
        $reservation = new \App\Models\Reservation();
        $reservation->user_id = $reservationInput['user_id'];
        $reservation->storage_box_id = $reservationInput['storage_box_id'];
        $reservation->receiver_email = $reservationInput['receiver_email'];
        $reservation->receiver_phone = $reservationInput['receiver_phone'];
        $reservation->save();
        //  Part temporarily removed for testing
        // foreach ($request->packaging_wrapper_ids as $packagingWrapperId) {
        //     $packagingWrapper = PackagingWrapper::find($packagingWrapperId['id']);

        //     $packagingWrapper->reservations()->attach($reservation, ["items" => json_encode($packagingWrapperId['items'])]);
        // }
        
        // $data = $reservation->load('packagingWrappers');

        // return $this->success($data, "Box Reserved Succussfully");
        return $this->success("Box Reserved Succussfully");
    }
}
