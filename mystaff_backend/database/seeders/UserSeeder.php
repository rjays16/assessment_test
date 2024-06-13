<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            [
                'name' => 'Allan Condiman',
                'email' => 'allan@example.com',
                'password' => Hash::make('condiman123'),
                'remember_token' => Str::random(20),
            ],
            [
                'name' => 'John Doe',
                'email' => 'doe@example.com',
                'password' => Hash::make('john_doe123'),
                'remember_token' => Str::random(20),
            ],
        ]);
    }
}
