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
        $errors = $this->videoService->validateRequest($request);

        if ($errors) {
            return response()->json(['errors' => $errors], 422);
        }

        $video = $request->file('video');
        $title = $request->input('title');

        $dropboxFilePath = $this->videoService.uploadVideoToDropbox($video);
        $videoModel = $this->videoService.saveVideoDetails($title, $dropboxFilePath);

        return response()->json(['message' => 'Video uploaded successfully!', 'video' => $videoModel], 200);
    }
}
