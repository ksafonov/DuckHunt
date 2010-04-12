package model {
import flash.events.EventDispatcher;
import flash.geom.Point;

import mx.core.BitmapAsset;

/**
 * Base implementation
 */
public class BaseDuck extends EventDispatcher implements IDuck {

    protected var _location: Point = new Point(0, 0);

    protected var _hit: Boolean;
    private var _dismissed: Boolean;
    protected var _leftToRight: Boolean;
    private var _aliveFrames: FrameList;
    private var _hitFrames: FrameList;

    /**
     * @param aliveFrames List of BitmapAsset-s to be shown for an <b>alive</b> duck
     * @param hitFrames List of BitmapAsset-s to be shown for a duck that was <b>hit</b>
     */
    public function BaseDuck(aliveFrames: Array, hitFrames: Array) {
        _aliveFrames = new FrameList(aliveFrames);
        _hitFrames = new FrameList(hitFrames);
    }

    public function get currentImage(): BitmapAsset {
        return _hit ? _hitFrames.image : _aliveFrames.image;
    }

    /**
     * @inheritDoc
     */
    public function get location(): Point {
        return _location;
    }

    public function set location(p: Point): void {
        _location = p.clone();
    }

    /**
     * @inheritDoc
     */
    public function get fliesToTheRight(): Boolean {
        return _leftToRight;
    }

    public function set fliesToTheRight(p: Boolean): void {
        _leftToRight = p;
    }

    /**
     * @inheritDoc
     */
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

    /**
     * Perform the duck movement
     * @param hit specifies is duck is hit or alive
     * @return movement offset
     */
    protected function move(hit: Boolean): Point {
        return new Point(0, 0);
    }

    /**
     * @inheritDoc
     */
    public function hit(): void {
        _hit = true;
        fireChanged(true);
    }

    /**
     * @inheritDoc
     */
    public function dismiss(): void {
        _dismissed = true;
    }

    /**
     * @inheritDoc
     */
    public function get dismissed(): Boolean {
        return _dismissed;
    }

    protected function fireChanged(hitEvent: Boolean): void {
        dispatchEvent(new DuckChangeEvent(this, hitEvent));
    }

    /**
     * @inheritDoc
     */
    public function get points(): int {
        return 0;
    }
}
}