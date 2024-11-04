<?php

namespace App\Traits;
use Stripe\Charge;
use Stripe\Stripe;
use Stripe\Token;

trait PaymentTrait
{
    public function payment(array $input) : bool {
        Stripe::setApiKey(env('STRIPE_SECRET_KEY'));
        $type = $input['type'];

        try {
            
            // Create a Stripe charge using the token
            $charge = Charge::create([
                'amount' => $input['amount'] * 100,
                'currency' => 'INR',
                'source' => $input['stripe_token_id'],
                'description' => "payment - $type",
            ]);

            \Log::info($charge);
            return false;

            if ($charge->status === 'succeeded') {

                $userId = Auth::user()->id;

                Transaction::create([
                    'user_id' => $userId,
                    'transaction_id' => $transactionId,
                    'transaction_response' => $charge,
                    'type' => $type
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
}
