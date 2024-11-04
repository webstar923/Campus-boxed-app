<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use App\Models\PackagingWrapper;

class PackagingWrapperFields extends Component
{
    public $packagingWrappers, $removeable, $value;
    
    /**
     * Create a new component instance.
     */
    public function __construct($removeable, $value = null) {
        $this->packagingWrappers = PackagingWrapper::all()->pluck('name', 'id');
        $this->removeable = $removeable;
        $this->value = $value;
    }

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        return view('components.packaging-wrapper-fields');
    }
}
