<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\StorageBox;

class StorageBoxesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'name' => 'Collage Cart',
                'price' => 119,
                'description' => "Get Your second collage cart",
                'height' => 45,
                'width' => 27,
                'depth' => 30,
                'image' => 'Boxed-Blue-Cart4.2.png',
            ],
            [
                'name' => 'Boxed Box',
                'price' => 30,
                'description' => "Get Your Boxed box",
                'height' => 18,
                'width' => 18,
                'depth' => 18,
                'image' => 'Boxed-Box 1.png',
            ],
            [
                'name' => 'Small',
                'price' => 25,
                'description' => "Get Your Small",
                'height' => 10,
                'width' => 10,
                'depth' => 10,
                'image' => 'largeOrder.png',
            ],
            [
                'name' => 'Medium',
                'price' => 25,
                'description' => "Get Your Small",
                'height' => 10,
                'width' => 10,
                'depth' => 10,
                'image' => 'mediumOrder.png',
            ],
            [
                'name' => 'Large',
                'price' => 25,
                'description' => "Get Your Small",
                'height' => 10,
                'width' => 10,
                'depth' => 10,
                'image' => 'smallorder.png',
            ],
        ];
        
        foreach ($data as $key => $value) {
            StorageBox::firstOrCreate([
                'name' => $value['name'],
                'price' => $value['price'],
                'description' => $value['description'],
                'height' => $value['height'],
                'width' => $value['width'],
                'depth' => $value['width'],
                'image' => $value['image'],
            ]);
        }
    }
}
