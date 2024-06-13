<?php

namespace App\Services;

use App\Models\Video;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Pion\Laravel\ChunkUpload\Handler\UploadHandler;
use Pion\Laravel\ChunkUpload\Receiver\FileReceiver;

class VideoService
{
    public function handleChunkUpload(Request $request)
    {
        $receiver = new FileReceiver("video", $request, UploadHandler::class);

        if ($receiver->isUploaded() === false) {
            throw new \Exception("File not uploaded");
        }

        $save = $receiver->receive();

        if ($save->isFinished()) {
            $file = $save->getFile();
            $filePath = $file->storeAs('videos', $file->getClientOriginalName());

            $video = new Video();
            $video->title = $request->input('title');
            $video->path_url = Storage::url($filePath);
            $video->save();

            return $video;
        }

        return response()->json([
            'done' => $save->handler()->getPercentageDone(),
            'status' => true
        ]);
    }
}
