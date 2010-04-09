package model.ducks {
import model.BaseDuck;

import mx.core.BitmapAsset;

public class TurboDuck extends BaseDuck {

    public static const FLY_SPEED: int = 40; // pixels per frame

    public static const VERTICAL_SPEED: int = 60; // pixels per frame

    public static const FALL_SPEED: int = 30; // pixels per frame

    [Embed(source="/turboDuck/alive1.png")]
    private var imgClsAlive1: Class;

    [Embed(source="/turboDuck/alive2.png")]
    private var imgClsAlive2: Class;

    [Embed(source="/turboDuck/alive3.png")]
    private var imgClsAlive3: Class;

    [Embed(source="/turboDuck/hit.png")]
    private var imgClsHit: Class;

    private var _hitImg: BitmapAsset = new imgClsHit();

    private var _currentFrame: int = 0;
    private var _frames: Array;

    private var _hit: Boolean;

    private var _verticalSpeed: int;

    public function TurboDuck() {
        _frames = [new imgClsAlive1(), new imgClsAlive2(), new imgClsAlive3()];
        _verticalSpeed = (Math.random() - 0.5) * VERTICAL_SPEED;
    }

    override public function hit(): void {
        _hit = true;
        fireChanged(true);
    }

    override public function advance(): void {
        if (dismissed) {
            return;
        }

        if (_hit) {
            location.offset(0, FALL_SPEED);
        } else {
            location.offset(_leftToRight ? FLY_SPEED : -FLY_SPEED, _verticalSpeed);
        }
        _currentFrame++;
        fireChanged(false);
    }

    override public function get currentImage(): BitmapAsset {
        return _hit ? _hitImg : _frames[_currentFrame % _frames.length];
    }

    override public function get points(): int {
        return 10;
    }
}
}