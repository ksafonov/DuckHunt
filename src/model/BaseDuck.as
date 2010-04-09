package model {
import flash.events.EventDispatcher;
import flash.geom.Point;

import mx.core.BitmapAsset;

public class BaseDuck extends EventDispatcher implements IDuck {

    protected var _location: Point = new Point(0, 0);

    protected var _hit: Boolean;
    private var _dismissed: Boolean;
    protected var _leftToRight: Boolean;
    private var _aliveFrames: FrameList;
    private var _hitFrames: FrameList;

    public function BaseDuck(aliveFrames: Array, hitFrames: Array) {
        _aliveFrames = new FrameList(aliveFrames);
        _hitFrames = new FrameList(hitFrames);
    }

    public function get currentImage(): BitmapAsset {
        return _hit ? _hitFrames.image : _aliveFrames.image;
    }

    public function get location(): Point {
        return _location;
    }

    public function set location(p: Point): void {
        _location = p.clone();
    }

    public function get leftToRight(): Boolean {
        return _leftToRight;
    }

    public function set leftToRight(p: Boolean): void {
        _leftToRight = p;
    }

    public function advance(): void {
        if (dismissed) {
            return;
        }

        var offset: Point = move(_hit);
        location.offset(offset.x, offset.y);
        if (_hit) {
            _aliveFrames.advance();
        } else {
            _hitFrames.advance();
        }
        fireChanged(false);
    }

    protected function move(hit: Boolean): Point {
        return new Point(0, 0);
    }

    public function hit(): void {
        _hit = true;
        fireChanged(true);
    }

    public function dismiss(): void {
        _dismissed = true;
    }

    public function get dismissed(): Boolean {
        return _dismissed;
    }

    protected function fireChanged(hitEvent: Boolean): void {
        dispatchEvent(new DuckChangeEvent(this, hitEvent));
    }

    public function get points(): int {
        return 0;
    }
}
}