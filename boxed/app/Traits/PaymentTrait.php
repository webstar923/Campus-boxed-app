<?php

namespace App\Traits;
use Stripe\Charge;
use Stripe\Stripe;
use Stripe\Token;
use Stripe\PaymentIntent;
use App\Models\{Transaction};
use Auth;

trait PaymentTrait
{
    public function payment(array $input) : bool {
        Stripe::setApiKey(env('STRIPE_SECRET_KEY'));
        $type = $input['type'];

        try {
            //Create a Stripe PaymentIntent
            $paymentIntent = PaymentIntent::create([
                'amount' => $input['amount'] * 100, // cents
                'currency' => 'usd',
                'payment_method' => $input['payment_method_id'],
                'automatic_payment_methods' => [
                    'enabled' => true,
                    'allow_redirects' => 'never',
                ],
                // 'receipt_email' => $request->email,
            ]);

            if ($paymentIntent->status === 'succeeded' || $paymentIntent->status === 'requires_confirmation') {
                // Save reservation details to the database
                $userId = Auth::user()->id;
                Transaction::create([
                    'user_id' => $userId,
                    'transaction_id' => $input['payment_method_id'],
                    'transaction_response' => json_encode($paymentIntent),
                    'type' => $type,
                    'reservation_id' => $input['reservation_id'],
                ]);
                
                return true;
            } else {
                return false;
            }

        } catch (Exception $e) {

            \Log::info(['stipe-error-message' => $e->getMessage()]);
            return false;
        }
    }
    // public function payment(array $input) : bool {
    //     Stripe::setApiKey(env('STRIPE_SECRET_KEY'));
    //     $type = $input['type'];

    //     try {
            
    //         // Create a Stripe charge using the token
    //         $charge = Charge::create([
    //             'amount' => $input['amount'] * 100,
    //             'currency' => 'USD',
    //             'source' => $input['stripe_token_id'],
    //             'description' => "payment - $type",
    //         ]);

    //         \Log::info($charge);
    //         return false;

    //         if ($charge->status === 'succeeded') {

    //             $userId = Auth::user()->id;

    //             Transaction::create([
    //                 'user_id' => $userId,
    //                 'transaction_id' => $transactionId,
    //                 'transaction_response' => $charge,
    //                 'type' => $type
    //             ]);
                
    //             return true;
    //         } else {
    //             return false;
    //         }
    //     } catch (Exception $e) {

    //         \Log::info(['stipe-error-message' => $e->getMessage()]);
    //         return false;
    //     }
    // }
}
