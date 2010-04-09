package model.ducks {
import flash.geom.Point;

import model.BaseDuck;

public class TurboDuck extends BaseDuck {

    public static const HORIZONTAL_SPEED: int = 40; // pixels per frame

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

    private var _verticalSpeed: int;

    public function TurboDuck() {
        super(new Array(new imgClsAlive1(), new imgClsAlive2(), new imgClsAlive3()), new Array(new imgClsHit()));
        _verticalSpeed = (Math.random() - 0.5) * VERTICAL_SPEED;
    }

    override protected function move(hit: Boolean): Point {
        if (_hit) {
            return new Point(0, FALL_SPEED);
        } else {
            return new Point(_leftToRight ? HORIZONTAL_SPEED : -HORIZONTAL_SPEED, _verticalSpeed);
        }
    }

    override public function get points(): int {
        return 10;
    }
}
}