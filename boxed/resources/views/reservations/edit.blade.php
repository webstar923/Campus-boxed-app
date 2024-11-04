@extends('layouts.main')

@section('content')
    
<div class="content-wrapper pb-0">

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Add Reservation</h4>

            @if($errors->any())
                {!! implode('', $errors->all('<div class="alert alert-danger">:message</div>')) !!}
            @endif
            
            <form class="forms-sample" action="{{ route('reservations.update', $reservation->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')
              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Storage Box</label>
                <div class="col-sm-9">
                  <select class="form-control" name="storage_box_id">
                    @foreach($storageBoxes as $id => $name)
                        <option value="{{ $id }}" {{ $reservation->storage_box_id == $id? 'selected': '' }}>{{ $name }}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">User</label>
                <div class="col-sm-9">
                  <select class="form-control" name="user_id">
                    @foreach($users as $id => $name)
                        <option value="{{ $id }}" {{ $reservation->user_id == $id? 'selected': '' }}>{{ $name }}</option>
                    @endforeach
                  </select>
                </div>
              </div>

              <div class="packaging-wrappers">
                @if (count($reservation->packagingWrappers))
                    
                  @foreach ($reservation->packagingWrappers as $packagingWrapper)
                    <x-packaging-wrapper-fields :removeable="$loop->iteration != 1" :value="$packagingWrapper->id" />
                  @endforeach

                @else
                  <x-packaging-wrapper-fields :removeable="false" />
                @endif
            </div>
              
              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Pickup Time</label>
                <div class="col-sm-9">
                  <input type="date" class="form-control" name="pickup_time" value="{{ $reservation->pickup_time }}" placeholder="Pickup Time" required>
                </div>
              </div>

              <div class="form-group row">
                <label class="col-sm-3 col-form-label">Dropoff Time</label>
                <div class="col-sm-9">
                  <input type="date" class="form-control" name="dropoff_time" value="{{ $reservation->dropoff_time }}" placeholder="Dropoff Time" required>
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


@push('script')
    <script>
      $('body').on('click', '.add-wrapper-btn', function() {
        $('.packaging-wrappers').append(`<x-packaging-wrapper-fields removeable="true" />`);
      })

      $('body').on('click', '.remove-wrapper-btn', function() {
        $(this).closest('.packaging-wrapper').remove();
      })
    </script>
@endpush