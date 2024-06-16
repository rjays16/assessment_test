<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\VideoService;

class VideoController extends Controller
{
    protected $videoService;

    public function __construct(VideoService $videoService)
    {
        $this->videoService = $videoService;
    }

    public function upload(Request $request)
    {
        try {
            $video = $this->videoService->handleChunkUpload($request);
            return response()->json(['message' => 'Video uploaded successfully!', 'video' => $video], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
