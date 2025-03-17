<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    use HasFactory;
    
    protected $fillable = ['name', 'daily_limit', 'price'];
    
    public function licenses()
    {
        return $this->hasMany(License::class);
    }
}
