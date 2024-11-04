<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PackagingWrapper;

class PackagingWrapperController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $packagingWrappers = PackagingWrapper::all();

        return view('packaging-wrappers.index', compact('packagingWrappers'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('packaging-wrappers.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'price' => 'required|numeric',
            'image' => 'required|file',
        ]);
        $filename = storeFile($request->image, 'images/packaging-wrappers');

        $packagingWrapper = new PackagingWrapper();
        $packagingWrapper->name = $request->input('name');
        $packagingWrapper->price = $request->input('price');
        $packagingWrapper->image = $filename;
        $packagingWrapper->save();
        
        return redirect()->route('packaging-wrappers.index')->with('success', 'Packaging Wrapper created successfully!');
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
        $packagingWrapper = PackagingWrapper::find($id);

        return view('packaging-wrappers.edit', compact('packagingWrapper'));
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
        ]);

        $packagingWrapper = PackagingWrapper::findOrFail($id);

        $packagingWrapper->name = $request->input('name');
        $packagingWrapper->price = $request->input('price');

        if ($request->hasFile('image')) {
            $packagingWrapper->image = storeFile($request->image, 'images/packaging-wrappers');
        }
        $packagingWrapper->save();

        return redirect()->route('packaging-wrappers.index')->with('success', 'Packaging Wrapper updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        PackagingWrapper::destroy($id);

        return true;
    }
}
