<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Banner;

class BannersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'title' => 'banner 1',
                'description' => 'banner 1',
                'image' => 'banner.png',
            ],
            [
                'title' => 'banner 2',
                'description' => 'banner 2',
                'image' => 'banner.png',
            ],
            [
                'title' => 'banner 3',
                'description' => 'banner 3',
                'image' => 'banner.png',
            ],
        ];

        foreach ($data as $key => $value) {
            Banner::firstOrCreate([
                'title' => $value['title'],
                'description' => $value['description'],
                'image' => $value['image'],
            ]);
        }
    }
}
