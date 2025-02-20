<?php

namespace App\Providers;

// use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use App\Models\User;
use App\Models\Admin;
use App\Models\Order;
use App\Policies\ProfilePolicy;
use App\Policies\AdminPolicy;
use App\Policies\OrderPolicy;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\DB;


class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        User::class => ProfilePolicy::class,
        Admin::class => AdminPolicy::class,
        Order::class => OrderPolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        $this->registerPolicies();

        Gate::define('accessAdminDashboard', function ($user) {
            
            return DB::table('admin')->where('id', $user->id)->exists();
        });
    }
}
