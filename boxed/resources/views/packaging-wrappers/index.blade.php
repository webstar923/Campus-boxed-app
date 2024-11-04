@extends('layouts.main')

@section('content')
    
<div class="content-wrapper pb-0">
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="card-title d-flex justify-content-between">
              <h4>Packaging Wrappers</h4>
              <a href="{{ route('packaging-wrappers.create') }}" class="btn btn-success">Add New</a>
            </div>
            <div class="table-responsive">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Image</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                @foreach ($packagingWrappers as $packagingWrapper) 
                    <tr>
                        <td>{{ $packagingWrapper->name }}</td>
                        <td>{{ $packagingWrapper->price }}</td>
                        <td>
                            <img src="{{ $packagingWrapper->image }}" alt="">
                        </td>
                        <td>
                            <a href="{{ route('packaging-wrappers.edit', $packagingWrapper->id) }}" class="btn btn-primary"><i class="mdi mdi-pencil"></i></a>
                            <a href="{{ route('packaging-wrappers.destroy', $packagingWrapper->id) }}" class="btn btn-danger delete-btn"><i class="mdi mdi-trash-can"></i></a>
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