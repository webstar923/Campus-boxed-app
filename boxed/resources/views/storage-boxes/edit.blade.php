@extends('layouts.main')

@section('content')
    
<div class="content-wrapper pb-0">

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Edit Storage Box</h4>

            @if($errors->any())
                {!! implode('', $errors->all('<div class="alert alert-danger">:message</div>')) !!}
            @endif
            
            <form class="forms-sample" action="{{ route('storage-boxes.update', $storageBox->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')
              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Name</label>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="name" value="{{ $storageBox->name }}" placeholder="Name">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Price</label>
                <div class="col-sm-9">
                  <input type="number" class="form-control" name="price" value="{{ $storageBox->price }}" placeholder="Price">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Image</label>
                <div class="col-sm-9">
                  <input type="file" class="form-control" name="image" value="{{ $storageBox->image }}" placeholder="Image">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Description</label>
                <div class="col-sm-9">
                  <input type="text" class="form-control" name="description" value="{{ $storageBox->description }}" placeholder="Description">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Height</label>
                <div class="col-sm-9">
                  <input type="number" class="form-control" name="height" value="{{ $storageBox->height }}" placeholder="Height">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Width</label>
                <div class="col-sm-9">
                  <input type="number" class="form-control" name="width" value="{{ $storageBox->width }}" placeholder="Width">
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Depth</label>
                <div class="col-sm-9">
                  <input type="number" class="form-control" name="depth" value="{{ $storageBox->depth }}" placeholder="Depth">
                </div>
              </div>

              <button type="submit" class="btn btn-primary me-2">Submit</button>
              <button class="btn btn-light">Cancel</button>
            </form>
          </div>
        </div>
      </div>
    
</div>

@endsection
