<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\{StorageBox, PackagingWrapper, Reservation};
use Hash;

class SettingController extends Controller
{

    public function index() {
        $data['storage_boxes'] = StorageBox::count();
        $data['package_wrappers'] = PackagingWrapper::count();
        $data['reservations'] = Reservation::count();

        return view('index', compact('data'));
    }
    
    public function resetPasswordForm() {
        return view('auth.reset-password');
    }

    public function resetPasswordSubmit(Request $request) {
        $request->validate([
            'old_password' => 'required',
            'password' => 'required|confirmed|min:8',
            'password_confirmation' => 'required|same:password',
        ]);
    
        $user = auth()->user();
    
        if (!Hash::check($request->old_password, $user->password)) {
            return back()->withErrors(['old_password' => 'Current password is incorrect.']);
        }
    
        $user->password = Hash::make($request->password);
        $user->save();
    
        return redirect()->route('dashboard')->with('success', 'Password has been reset successfully.');
    


    }
    
}
