package model.ducks {
    import model.BaseDuck;

    import mx.core.BitmapAsset;

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

        private var _hitImg: BitmapAsset = new imgClsHit();

        private var _currentFrame: Number = 0;
        private var _frames: Array;

        private var _hit: Boolean;

        public function LazyDuck() {
            _frames = [new imgClsAlive1(), new imgClsAlive2(), new imgClsAlive3()];
        }

        override public function hit(): void {
            _hit = true;
            fireChanged(true);
        }

        override public function advance(): void {
            if (_hit) {
                location.offset(0, FALL_SPEED);
            } else {
                var verticalOffset: int = AMPLITUDE * (Math.cos(_currentFrame * PERIOD / 2 / Math.PI));
                location.offset(_leftToRight ? FLY_SPEED : -FLY_SPEED, verticalOffset);
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