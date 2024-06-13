<?php

namespace App\Services;

use App\Models\Video;
use Illuminate\Http\Request;
use Kunnu\Dropbox\Dropbox;
use Kunnu\Dropbox\DropboxApp;
use Illuminate\Support\Facades\Validator;

class VideoService
{
    protected $dropbox;

    public function __construct()
    {
        $app = new DropboxApp(env('DROPBOX_APP_KEY'), env('DROPBOX_APP_SECRET'), env('DROPBOX_ACCESS_TOKEN'));
        $this->dropbox = new Dropbox($app);
    }

    public function validateRequest(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'video' => 'required|file|mimes:mp4,mov,avi|max:10240000', // Adjust max size as needed
        ]);

        if ($validator->fails()) {
            return $validator->errors();
        }

        return null;
    }

    public function uploadVideoToDropbox($video)
    {
        $path = $video->getRealPath();
        $dropboxFilePath = '/videos/' . time() . '_' . $video->getClientOriginalName();
        $this->dropbox->upload($dropboxFilePath, file_get_contents($path), ['autorename' => true]);

        return $dropboxFilePath;
    }

    public function saveVideoDetails($title, $path_url)
    {
        $video = new Video();
        $video->title = $title;
        $video->path_url = $path_url;
        $video->save();

        return $video;
    }
}
