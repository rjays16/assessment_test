<?php

namespace App\Http\Controllers;

use App\Services\VideoService;
use Illuminate\Http\Request;

class VideoController extends Controller
{
    protected $videoService;

    public function __construct(VideoService $videoService)
    {
        $this->videoService = $videoService;
    }

    public function uploadVideo(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimetypes:video/*|max:10485760', // Max 10GB
        ]);

        $video = $this->videoService->uploadVideo($request->file('file'));

        return response()->json($video, 201);
    }

    public function getAllVideos()
    {
        $videos = $this->videoService->getAllVideos();
        return response()->json($videos);
    }

    public function deleteVideo($id)
    {
        $this->videoService->deleteVideo($id);
        return response()->json(['message' => 'Video deleted successfully']);
    }
}