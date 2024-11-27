<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Password;
use Laravel\Passport\TokenRepository;
use App\Traits\{ApiResponsesTrait, PaymentTrait};
use Carbon\Carbon;
use Auth, Hash, Validator, Mail, Str;
use App\Models\User;
use App\Mail\OtpMail;

class AuthController extends Controller
{
    use ApiResponsesTrait, PaymentTrait;

    const OTP_EXPIRATION_MINUTES = 10;

    public function generateShortCustomerId()
    {
        $uuid = Str::orderedUuid()->toString(); // Generate UUID
        $shortId = substr(base_convert(md5($uuid), 16, 10), 0, 7); // Convert to numeric and shorten
        return $shortId;
    }

    public function login(Request $request) : JsonResponse {
        $credentials = $request->only(['email', 'password']);

        if (!Auth::attempt($credentials)) {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }

        $user = Auth::user();
        $user['token'] = $user->createToken('Personal Access Token')->accessToken;

        return $this->success($user, "Logged in");
    }

    public function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'first_name' => 'sometimes',
            'last_name' => 'sometimes',
            'phone_number' => 'sometimes',
            'role' => 'required|in:2,3',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
            // 'password_confirmation' => 'required|string|min:8',
            'location' => 'sometimes',
            // 'stripe_token_id' => 'required',
        ], [
            'role' => 'The selected role is invalid. Value must be 2 (as student) or 3 (as relative)'
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->messages()], 422);
        }

        $user = new \App\Models\User();
        $user->first_name = $request->first_name;
        $user->last_name = $request->last_name;
        $user->email = $request->email;
        $user->role = $request->role;
        $user->location = $request->location;
        $user->phone_number = $request->phone_number;
        $user->password = Hash::make($request->input('password'));
        $user->customer_id = $this->generateShortCustomerId();
        $user->save();
        $user['token'] = $user->createToken('Personal Access Token')->accessToken;

        // registration payment
        // $input = $request->toArray();
        // $input['amount'] = 50;
        // $input['type'] = 'registration';

        // $payment = $this->payment($input);
        // if($payment) {
        //     $user->update(['payment_status' => true]);
        // }

        return $this->success($user, "Registration Succesfull");
    }

    public function sendOtp(Request $request) {
        $request->validate([
            'email' => ['required', 'email', 'exists:users'],
        ]);

        try {

            $otp = rand(100000, 999999); // 6-digit OTP

            User::whereEmail($request->email)->update([
                'otp' => $otp,
                'otp_expires_at' => Carbon::now()->addMinutes(self::OTP_EXPIRATION_MINUTES)
            ]);
            Mail::to($request->email)->send(new OtpMail($otp));
            return $this->success([], 'OTP sent on mail');
        }
        catch(\Exception $e) {
            \Log::info($e);
            return $this->error($e->getMessage());
        }
    }

    public function verifyOtp(Request $request) {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'otp' => 'required|digits:6',
        ]);

        $user = User::where('email', $request->email)
                        ->where('otp', $request->otp)
                        ->where('otp_expires_at', '>', Carbon::now())
                        ->first();

        if ($user) {
            $user->otp = null;
            $user->otp_expires_at = null;
            $user->save();
            
            return $this->success('OTP verified successfully.');
        } else {
            return $this->error('Invalid or expired OTP.', 400);
        }
    }

    public function resetPassword(Request $request) {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::where('email', $request->email)->update(['password' => Hash::make($request->password)]);
        return $this->success([], 'Password updated successfully');
    }

    public function logout(Request $request) {
        $request->user()->token()->revoke();
        return $this->success([], 'Logged out successfully');
    }


}
