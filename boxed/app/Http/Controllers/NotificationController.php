<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Twilio\Rest\Client;
use App\Traits\{ApiResponsesTrait};

class NotificationController extends Controller
{
    use ApiResponsesTrait;
    
    public function store(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email',
            'phone_number' => 'nullable|regex:/^[0-9]{10,15}$/',
        ]);
        $existingNotification = Notification::where('email', $data['email'])
            ->where('phone_number', $data['phone_number'])
            ->first();

        if ($existingNotification) {
            return $this->success("Notification already exists");
        }

        $notification = Notification::create($data);
        return $this->success("Notification reminder saved successfully");
    }

    public function sendNotifications()
    {
        $notifications = Notification::where('status', 'pending')->get();
        $twilioSid = env('TWILIO_SID');
        $twilioToken = env('TWILIO_AUTH_TOKEN');
        $twilioFrom = env('TWILIO_PHONE_NUMBER');

        foreach ($notifications as $notification) {
            try {
                // Send email
                Mail::raw('Your requested reminder is ready!', function ($message) use ($notification) {
                    if (!empty($notification->email)) {
                        $message->to($notification->email)
                                ->subject('Reminder Notification')
                                ->from(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'));
                    } else {
                        \Log::warning('No email address provided for notification');
                    }
                });
                

                // Send SMS if applicable
                if (!empty($notification->phone_number)) {
                    $twilio = new Client($twilioSid, $twilioToken);
                    $twilio->messages->create(
                        $notification->phone_number,
                        [
                            'from' => $twilioFrom,
                            'body' => 'Your requested reminder is ready!',
                        ]
                    );
                }

                // Mark as notified
                // $notification->status = 'notified';
                // $notification->save();
            } catch (\Exception $e) {
                \Log::error('Notification failed: ' . $e->getMessage());
            }
        }

        return response()->json(['message' => 'Notifications sent successfully']);
    }
}
