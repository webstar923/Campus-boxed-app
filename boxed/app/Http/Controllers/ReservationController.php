<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{Reservation, PackagingWrapper};
use App\Traits\{ApiResponsesTrait, PaymentTrait};
use Auth;
use Carbon\Carbon;

class ReservationController extends Controller
{
    use ApiResponsesTrait, PaymentTrait;
    
    public function store(Request $request) {

       $request->validate([
            'storage_box_id' => 'required',
            'receiver_email' => 'required|email',
            'receiver_phone' => 'nullable|string|max:20',
        ]);

        $reservationInput = $request;
        // $reservationInput['user_id'] = $request->sender_id ;
        $reservationInput['user_id'] = Auth::user()->id;
        $reservation = new \App\Models\Reservation();
        $existingReservation = Reservation::where('user_id', $reservationInput['user_id'])
                    ->where('status', '!=', 7)
                    ->exists();
        if(!$existingReservation)
        {
            $reservation->user_id        = $reservationInput['user_id'];
            $reservation->status         = 1;
            $reservation->storage_box_id = $reservationInput['storage_box_id'];
            $reservation->receiver_email = $reservationInput['receiver_email'];
            $reservation->receiver_phone = $reservationInput['receiver_phone'];
            $reservation->save();
            $reservation_id  = $reservation->id;
            $input['amount'] = 50;
            $input['type']   = 'registeration';
            $input['reservation_id']    = $reservation_id;
            $input['payment_method_id'] = $reservationInput['paymentID'];

            $payment = $this->payment($input);         
            return $this->success("Box Reserved Succussfully");
        }
        else
        {
            return $this->error('A reservation already exists');
        }
    }

    public function update(Request $request) {
        $reservationInput['user_id'] = Auth::user()->id;
        $reservation = Reservation::where('user_id', $reservationInput['user_id'])
        ->where('status', '!=', 7)
        ->first();
        $pickup = Carbon::createFromFormat('m/d/Y', $request['pickup_time']);
        $dropoff = Carbon::createFromFormat('m/d/Y', $request['dropoff_time']);
        $formattedPickupDate = $pickup->format('Y-m-d');
        $formattedDropoffDate = $dropoff->format('Y-m-d');
        $reservation->update([
            'pickup_time' => $formattedPickupDate,
            'dropoff_time' => $formattedDropoffDate,
            'pickup_location' => $request['pickup_location'],
            'delivery_location' => $request['delivery_location'],
        ]);
        return $this->success('Update Success');
    }

    // public function store(Request $request) {
    //     $request->validate([
    //          'storage_box_id' => 'required',
    //          'pickup_time' => 'sometimes',
    //          'dropoff_time' => 'sometimes',
    //          'items_packed_labeled' => 'sometimes',
    //          'items_pickup_ready' => 'sometimes',
    //          'items_movers_possession' => 'sometimes',
    //          'status' => 'sometimes',
    //          'packaging_wrapper_ids' => 'sometimes|array',
    //          'receiver_email' => 'required|email',
    //          'receiver_phone' => 'nullable|string|max:20',
    //      ]);
 
    //      // $reservationInput = $request->except(['packaging_wrapper_ids', 'packaging_wrapper_items', 'card_number', 'expiration_date', 'cvc', 'zip_code']);
    //      $reservationInput = $request->except(['card_number', 'expiration_date', 'cvc', 'zip_code']);
    //      // new working
    //      $reservationInput['user_id'] = $request->sender_id ;
    //      // $reservationInput['user_id'] = Auth::user()->id;
 
 
    //      // $reservationInput['items'] = json_encode($request->packaging_wrapper_items);
    //      // $reservation = Reservation::create($reservationInput);
    //      $reservation = new \App\Models\Reservation();
    //      $reservation->user_id = $reservationInput['user_id'];
    //      $reservation->storage_box_id = $reservationInput['storage_box_id'];
    //      $reservation->receiver_email = $reservationInput['receiver_email'];
    //      $reservation->receiver_phone = $reservationInput['receiver_phone'];
    //      $reservation->save();
    //      //  Part temporarily removed for testing
    //      // foreach ($request->packaging_wrapper_ids as $packagingWrapperId) {
    //      //     $packagingWrapper = PackagingWrapper::find($packagingWrapperId['id']);
 
    //      //     $packagingWrapper->reservations()->attach($reservation, ["items" => json_encode($packagingWrapperId['items'])]);
    //      // }
         
    //      // $data = $reservation->load('packagingWrappers');
 
    //      // return $this->success($data, "Box Reserved Succussfully");
    //      return $this->success("Box Reserved Succussfully");
    //  }
}
