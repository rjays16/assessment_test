<?php
namespace App\Services;

use App\Models\Video;
use Illuminate\Http\Request;
use Pion\Laravel\ChunkUpload\Handler\UploadHandler;
use Pion\Laravel\ChunkUpload\Receiver\FileReceiver;
use Kunnu\Dropbox\DropboxApp;
use Kunnu\Dropbox\Dropbox;
use Kunnu\Dropbox\Exceptions\DropboxException;

class VideoService
{
    protected $dropbox;

    public function __construct(Dropbox $dropbox)
    {
        $this->dropbox = $dropbox;
    }

    public function handleChunkUpload(Request $request)
    {
        $receiver = new FileReceiver("video", $request, UploadHandler::class);

        if ($receiver->isUploaded() === false) {
            throw new \Exception("File not uploaded");
        }

        $save = $receiver->receive();

        if ($save->isFinished()) {
            $file = $save->getFile();
            $videoPath = $this->uploadToDropbox($file);

            $video = new Video();
            $video->title = $request->input('title');
            $video->path_url = $videoPath;
            $video->save();

            return $video;
        }

        return response()->json([
            'done' => $save->handler()->getPercentageDone(),
            'status' => true
        ]);
    }

    protected function uploadToDropbox($file)
    {
        try {
            $dropboxPath = '/videos/' . $file->getClientOriginalName();
            $this->dropbox->upload($file->getPathname(), $dropboxPath, ['autorename' => true]);
            $videoUrl = $this->dropbox->getTemporaryLink($dropboxPath);

            return $videoUrl;
        } catch (DropboxException $e) {
            throw new \Exception('Failed to upload video to Dropbox: ' . $e->getMessage());
        }
    }
}
