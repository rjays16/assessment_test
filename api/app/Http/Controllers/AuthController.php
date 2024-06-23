<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('MyApp')->plainTextToken;

        return response()->json(['token' => $token], 201);
    }

 // app/Http/Controllers/AuthController.php
public function login(Request $request) {
  // Validate the request
  $request->validate([
    'email' => 'required|email',
    'password' => 'required',
  ]);

  if (!Auth::attempt($request->only('email', 'password'))) {
    return response()->json([
      'message' => 'Invalid login credentials'
    ], 401);
  }

  $user = Auth::user();
  $token = $user->createToken('auth_token')->plainTextToken;

  return response()->json([
    'token' => $token,
    'user' => $user
  ]);
}

public function logout(Request $request) {
  $request->user()->tokens()->delete();

  return response()->json([
    'message' => 'Logged out successfully'
  ]);
}
}
