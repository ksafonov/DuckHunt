package model.ducks {
import flash.geom.Point;

import model.BaseDuck;

public class LazyDuck extends BaseDuck {

    public static const FLY_SPEED: int = 10; // pixels per frame

    public static const PERIOD: int = 50; // frames

    public static const AMPLITUDE: int = 10; // pixels

    public static const FALL_SPEED: int = 30; // pixels per frame

    [Embed(source="/lazyDuck/alive1.png")]
    private var imgClsAlive1: Class;

    [Embed(source="/lazyDuck/alive2.png")]
    private var imgClsAlive2: Class;

    [Embed(source="/lazyDuck/alive3.png")]
    private var imgClsAlive3: Class;

    [Embed(source="/lazyDuck/hit.png")]
    private var imgClsHit: Class;

    private var _counter: int = 0;

    public function LazyDuck() {
        super(new Array(new imgClsAlive1(), new imgClsAlive2(), new imgClsAlive3()), new Array(new imgClsHit()));
    }

    override public function advance(): void {
        super.advance();
        _counter++;
    }

    override protected function move(hit: Boolean): Point {
        if (_hit) {
            return new Point(0, FALL_SPEED);
        } else {
            var verticalOffset: int = AMPLITUDE * (Math.cos(_counter * PERIOD / 2 / Math.PI));
            return new Point(_leftToRight ? FLY_SPEED : -FLY_SPEED, verticalOffset);
        }
    }

    override public function get points(): int {
        return 3;
    }
}
}