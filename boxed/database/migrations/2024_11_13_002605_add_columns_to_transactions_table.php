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
            $table->string('card_number', 20)->nullable();
            $table->string('expiration_date', 5)->nullable();
            $table->string('cvc', 3)->nullable();
            $table->string('country', 50)->nullable();
            $table->string('zip_code', 10)->nullable();
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
