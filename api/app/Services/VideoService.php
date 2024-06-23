<?php

namespace App\Services;

use App\Models\Video;
use Illuminate\Http\UploadedFile;
use Spatie\Dropbox\Client as DropboxClient;

class VideoService
{
    protected $dropbox;

    public function __construct()
    {
        $this->dropbox = new DropboxClient(config('filesystems.disks.dropbox.authorization_token'));
    }

    public function uploadVideo(UploadedFile $file)
    {
        $fileName = time() . '_' . $file->getClientOriginalName();
        $path = $fileName; // or 'videos/' . $fileName if you want a subfolder
    
        $fileContents = file_get_contents($file->getRealPath());
        
        try {
            $this->dropbox->upload($path, $fileContents);
        } catch (\Exception $e) {
            \Log::error('Dropbox upload failed: ' . $e->getMessage());
            throw $e;
        }
    
        $video = Video::create([
            'name' => $fileName,
            'path' => $path,
            'size' => $file->getSize(),
        ]);
    
        return $video;
    }

    public function getAllVideos()
    {
        return Video::all();
    }

    public function deleteVideo($id)
    {
        $video = Video::findOrFail($id);
        $this->dropbox->delete($video->path);
        $video->delete();
    }
}