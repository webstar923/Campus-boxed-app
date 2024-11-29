<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Traits\ApiResponsesTrait;
use App\Models\{Reservation, StorageBox, PackagingWrapper, Banner};
use Auth;

class ApiController extends Controller
{
    use ApiResponsesTrait;

    public function getStorageBoxes(): JsonResponse {
        $data = StorageBox::all();
        return $this->success($data);
    }

    public function getPackagingWrapper(): JsonResponse {
        $data = PackagingWrapper::all();
        return $this->success($data);
    }

    public function getBanner() {
        $data = Banner::all();
        return $this->success($data);
    }

    public function getUserDetails() {
        $data = Auth::user();
        return $this->success($data);
    }

    // Add mine
    public function getReservationDetails() {
        $user = Auth::user();
        $data = Reservation::where('user_id', $user['id'])
            ->where('status', '!=', 7)
            ->firstOrFail();
        return $this->success($data);
    }
}
