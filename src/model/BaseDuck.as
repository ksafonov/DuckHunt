package model {
import flash.events.EventDispatcher;
import flash.geom.Point;

import mx.core.BitmapAsset;

public class BaseDuck extends EventDispatcher implements IDuck {

    protected var _location: Point = new Point(0, 0);

    private var _dismissed: Boolean;
    protected var _leftToRight: Boolean;

    public function get currentImage(): BitmapAsset {
        return null;
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
        // base implementation does nothing
    }

    public function hit(): void {
        dismiss();
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