<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('transactions', function (Blueprint $table) {
            $table->foreignId('reservation_id')->constrained('reservations');
            $table->string('card_number', 20);
            $table->string('expiration_date', 5);
            $table->string('cvc', 3);
            $table->string('country', 50);
            $table->string('zip_code', 10);
            $table->enum('payment_status', ['completed', 'failed']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('transactions', function (Blueprint $table) {
            //
        });
    }
};
