<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Kunnu\Dropbox\Dropbox;
use Kunnu\Dropbox\DropboxApp;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(Dropbox::class, function ($app) {
            $clientId = env('DROPBOX_APP_KEY');
            $clientSecret = env('DROPBOX_APP_SECRET');
            $accessToken = env('DROPBOX_ACCESS_TOKEN');

            $dropboxApp = new DropboxApp($clientId, $clientSecret, $accessToken);
            return new Dropbox($dropboxApp);
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
