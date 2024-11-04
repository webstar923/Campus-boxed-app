<?php

use Illuminate\Support\Facades\Route;
use App\Http\Middleware\AdminMiddleware;
use App\Http\Controllers\Admin\StorageBoxController;
use App\Http\Controllers\Admin\PackagingWrapperController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\ReservationController;
use App\Http\Controllers\Admin\SettingController;


Route::group(['middleware' => 'admin'], function() {
    
    Route::get('/', [SettingController::class, 'index'])->name('dashboard');

    Route::resource('storage-boxes', StorageBoxController::class);
    Route::resource('packaging-wrappers', PackagingWrapperController::class);
    Route::resource('users', UserController::class);
    Route::resource('reservations', ReservationController::class);

    Route::get('/settings/reset-password', [SettingController::class, 'resetPasswordForm'])->name('settings.reset-password-form');
    Route::post('/settings/reset-password', [SettingController::class, 'resetPasswordSubmit'])->name('settings.reset-password');
});

Route::resource('users', App\Http\Controllers\Admin\UserController::class)->only('index', 'store');
