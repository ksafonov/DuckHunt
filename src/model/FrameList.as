package model {
import mx.core.BitmapAsset;

public class FrameList {

    private var _frames: Array;
    private var _currentFrame: int = 0;

    public function FrameList(frames: Array) {
        _frames = frames;
    }

    public function get image(): BitmapAsset {
        return _frames[_currentFrame % _frames.length];
    }

    public function advance(): void {
        _currentFrame++;
    }
}
}