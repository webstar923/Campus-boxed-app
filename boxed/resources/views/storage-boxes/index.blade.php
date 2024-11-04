@extends('layouts.main')

@section('content')
    
<div class="content-wrapper pb-0">
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="card-title d-flex justify-content-between">
              <h4>Storage Boxes</h4>
              <a href="{{ route('storage-boxes.create') }}" class="btn btn-success">Add New</a>
            </div>
            <div class="table-responsive">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Height</th>
                    <th>Width</th>
                    <th>Depth</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                @foreach ($storageBoxes as $storageBox) 
                    <tr>
                        <td>{{ $storageBox->name }}</td>
                        <td>{{ $storageBox->price }}</td>
                        <td>
                            <img src="{{ $storageBox->image }}" alt="">
                        </td>
                        <td>{{ $storageBox->description }}</td>
                        <td>{{ $storageBox->height }}</td>
                        <td>{{ $storageBox->width }}</td>
                        <td>{{ $storageBox->depth }}</td>
                        <td>
                            <a href="{{ route('storage-boxes.edit', $storageBox->id) }}" class="btn btn-primary"><i class="mdi mdi-pencil"></i></a>
                            <a href="{{ route('storage-boxes.destroy', $storageBox->id) }}" class="btn btn-danger delete-btn"><i class="mdi mdi-trash-can"></i></a>
                        </td>
                    </tr>
                @endforeach
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
</div>

@endsection