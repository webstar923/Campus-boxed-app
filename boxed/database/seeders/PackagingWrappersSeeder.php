<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\PackagingWrapper;

class PackagingWrappersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'name' => 'Packing Tape',
                'price' => 10,
                'image' => 'packing_tape.png'
            ],
            [
                'name' => 'Bubble Wrap',
                'price' => 10,
                'image' => 'bubble_wrap.png'
            ],
            [
                'name' => 'Duffle',
                'price' => 10,
                'image' => 'packingtap.png'
            ],
            [
                'name' => 'XL Duffle',
                'price' => 10,
                'image' => 'dummy.jpg'
            ],
            [
                'name' => 'Boxed Box',
                'price' => 10,
                'image' => 'dummy.jpg'
            ],
            [
                'name' => 'Packing Tape Cello',
                'price' => 10,
                'image' => 'packingtap.png'
            ],
        ];

        foreach ($data as $key => $value) {
            PackagingWrapper::firstOrCreate([
                'name' => $value['name'],
                'price' => $value['price'],
                'image' => $value['image'],
            ]);
        }
        
    }
}
