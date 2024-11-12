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
        Schema::create('breservations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('recipient_email');
            $table->string('recipient_phone')->nullable();
            $table->enum('status', ['pending', 'confirmed', 'completed', 'canceled'])->default('pending');
            $table->dateTime('reservation_date');
            $table->foreignId('sender_id')->constrained('users')->onDelete('cascade');
            $table->string('recipient_email')->nullable();
            $table->string('recipient_phone')->nullable();
            $table->string('payment_email')->nullable();
            $table->string('card_number', 16)->nullable();
            $table->string('expiration_date', 7)->nullable();
            $table->string('cvc', 4)->nullable();
            $table->string('country')->nullable();
            $table->string('zip_code')->nullable();
            $table->enum('status', ['pending', 'completed', 'cancelled'])->default('pending');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('breservations');
    }
};
