@extends('layouts.main')

@section('content')
    
<div class="content-wrapper pb-0">
    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="card-title d-flex justify-content-between">
              <h4>Reservations</h4>
              <a href="{{ route('reservations.create') }}" class="btn btn-success">Add New</a>
            </div>
            <div class="table-responsive">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th>Storage Box</th>
                    <th>Packaging Wrappers</th>
                    {{-- <th>Items</th> --}}
                    <th>Pick Up</th>
                    <th>Drop Off</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                @foreach ($reservations as $reservation) 
                    <tr>
                        <td>{{ $reservation->storageBox->name ?? '--' }}</td>
                        <td>
                            @foreach ($reservation->packagingWrappers as $packagingWrapper)
                                {{ $packagingWrapper->name ?? '--' }},
                            @endforeach
                        </td>
                        <td>{{ $reservation->pickup_time ?? '--' }}</td>
                        <td>{{ $reservation->dropoff_time ?? '--' }}</td>
                        <td>{!! $reservation->status ?? '--' !!}</td>
                        <td>
                            <a href="{{ route('reservations.edit', $reservation->id) }}" class="btn btn-primary"><i class="mdi mdi-pencil"></i></a>
                            <a href="{{ route('reservations.destroy', $reservation->id) }}" class="btn btn-danger delete-btn"><i class="mdi mdi-trash-can"></i></a>
                        </td>
                    </tr>
                @endforeach
                </tbody>
              </table>
            </div>
          </div>
          <div class="d-flex justify-content-end mr-4">
            {{ $reservations->links() }}
          </div>
        </div>
      </div>
</div>

@endsection