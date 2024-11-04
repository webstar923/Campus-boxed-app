<div class="packaging-wrapper">
    <div class="form-group row">
        <label class="col-sm-3 col-form-label">Packaging Wrappers</label>
        <div class="col-sm-9 d-flex justify-content-evenly align-items-center">

            <select class="form-control" name="packaging_wrapper_ids[]">
              @foreach($packagingWrappers as $id => $name)
              <option value="{{ $id }}" {{ $value == $id? 'selected': '' }}>{{ $name }}</option>
              @endforeach
            </select>
          
          @if (!$removeable)
            <button type="button" class="ml-4 btn btn-primary add-wrapper-btn">Add</button>
          @else
            <button type="button" class="ml-4 btn btn-danger remove-wrapper-btn">Remove</button>
          @endif
          
        </div>
      </div>
</div>