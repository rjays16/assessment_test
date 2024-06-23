<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Services\VideoService;

class UploadVideoJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $videoId;
    protected $localPath;

    public function __construct($videoId, $localPath)
    {
        $this->videoId = $videoId;
        $this->localPath = $localPath;
    }

    public function handle(VideoService $videoService)
    {
        $videoService->processChunkedUpload($this->videoId, $this->localPath);
    }
}