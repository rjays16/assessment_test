<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\VideoController;


    Route::post('/register', [AuthController::class, 'register']);
    Route::get('/login', [AuthController::class, 'login']);
    Route::middleware('auth:api')->post('/logout', [AuthController::class, 'logout']);
    Route::middleware('auth:api')->post('/videos', [VideoController::class, 'upload']);


