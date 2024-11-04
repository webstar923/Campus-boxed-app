<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\{Reservation, User, StorageBox};
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Str, Hash;

class ReservationController extends Controller
{
    public function index(Request $request): View {
        $reservations = Reservation::with('packagingWrappers:id,name')->paginate(10);

        return view('reservations.index', compact('reservations'));
    }

    public function create() {
        $users = User::all()->pluck('first_name', 'id');
        $storageBoxes = StorageBox::all()->pluck('name', 'id');

        return view('reservations.create', compact('users', 'storageBoxes'));
    }

    public function store(Request $request): RedirectResponse {
        $input = $request->validate([
            'storage_box_id' => 'required:exists:storage_boxes,id',
            'packaging_wrapper_ids.*' => 'required:exists:packaging_wrapper,id',
            'pickup_time' => 'nullable',
            'dropoff_time' => 'nullable',
        ]);

        $reservation = Reservation::create($request->except('packaging_wrapper_ids'));
        foreach ($request->packaging_wrapper_ids as $value) {
            $reservation->packagingWrappers()->attach($value);
        }

        return redirect()->route('reservations.index');
    }

    public function edit($id) {
        $reservation = Reservation::find($id);
        $users = User::all()->pluck('first_name', 'id');
        $storageBoxes = StorageBox::all()->pluck('name', 'id');

        return view('reservations.edit', compact('reservation', 'users', 'storageBoxes'));
    }

    public function update(Request $request, $id) {
        
        $input = $request->validate([
            'storage_box_id' => 'required:exists:storage_boxes,id',
            'packaging_wrapper_ids.*' => 'required:exists:packaging_wrapper,id',
            'pickup_time' => 'nullable',
            'dropoff_time' => 'nullable',
        ]);

        $reservation = Reservation::find($id);
        $reservation->update($request->except('packaging_wrapper_ids', '_token', '_method'));

        $reservation->packagingWrappers()->sync($request->packaging_wrapper_ids);

        return redirect()->route('reservations.index');
    }

    public function destroy($id) {

        $reservation = Reservation::find($id);
        
        $reservation->packagingWrappers()->detach();
        $reservation->delete();

        return redirect()->route('reservations.index');
    }
}
