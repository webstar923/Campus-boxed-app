<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\StorageBox;

class StorageBoxController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index() {
        $storageBoxes = StorageBox::all();

        return view('storage-boxes.index', compact('storageBoxes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('storage-boxes.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request) {
        
        $request->validate([
            'name' => 'required|string',
            'price' => 'required|numeric',
            'image' => 'required|file',
            'description' => 'required|string',
            'height' => 'required|numeric',
            'width' => 'required|numeric',
            'depth' => 'required|numeric',
        ]);
        $filename = storeFile($request->image, 'images/storage-boxes');

        $storageBox = new StorageBox();
        $storageBox->name = $request->input('name');
        $storageBox->price = $request->input('price');
        $storageBox->image = $filename;
        $storageBox->description = $request->input('description');
        $storageBox->height = $request->input('height');
        $storageBox->width = $request->input('width');
        $storageBox->depth = $request->input('depth');
        $storageBox->save();
        
        return redirect()->route('storage-boxes.index')->with('success', 'Storage Box created successfully!');
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $storageBox = StorageBox::find($id);

        return view('storage-boxes.edit', compact('storageBox'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'name' => 'required|string',
            'price' => 'required|numeric',
            'image' => 'nullable|file',
            'description' => 'required|string',
            'height' => 'required|numeric',
            'width' => 'required|numeric',
            'depth' => 'required|numeric',
        ]);

        $storageBox = StorageBox::findOrFail($id);

        $storageBox->name = $request->input('name');
        $storageBox->price = $request->input('price');

        if ($request->hasFile('image')) {
            $storageBox->image = storeFile($request->image, 'images/storage-boxes');
        }

        $storageBox->description = $request->input('description');
        $storageBox->height = $request->input('height');
        $storageBox->width = $request->input('width');
        $storageBox->depth = $request->input('depth');
        $storageBox->save();

        return redirect()->route('storage-boxes.index')->with('success', 'Storage Box updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id) {
        StorageBox::destroy($id);

        return true;
    }
}
