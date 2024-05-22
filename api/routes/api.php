<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\AuthController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/



// Authentication Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:api')->post('/logout', [AuthController::class, 'logout']);

Route::prefix('products')->group(function () {
    Route::post('', [ProductController::class,'storeProduct']);
    Route::get('', [ProductController::class,'getAllProducts']);
    Route::delete('{product}', [ProductController::class, 'deleteProduct']);
    Route::put('{product}', [ProductController::class, 'updateProduct']);

});
