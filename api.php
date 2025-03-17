<?php

use App\Http\Controllers\Api\LicenseController;
use App\Http\Controllers\Api\RankingController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

// Rutas públicas
Route::post('/validate-license', [LicenseController::class, 'validateLicense']);

// Rutas protegidas por API key
Route::middleware('verify.apikey')->group(function () {
    // Verificación de rankings
    Route::post('/check-ranking', [RankingController::class, 'checkRanking']);
    
    // Información de licencia y uso
    Route::get('/license-info', [RankingController::class, 'getLicenseInfo']);
});
