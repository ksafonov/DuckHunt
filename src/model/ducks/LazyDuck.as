package model.ducks {
    import flash.geom.Point;

    import model.BaseDuck;

    import mx.core.BitmapAsset;

    public class LazyDuck extends BaseDuck {

        [Embed(source="/lazyDuck/frame1.png")]
        private var imgCls1:Class;

        [Embed(source="/lazyDuck/frame2.png")]
        private var imgCls2:Class;

        [Embed(source="/lazyDuck/frame3.png")]
        private var imgCls3:Class;

        /**
         * angle to fly at, relevant to the direction to the center
         */
        var _angle:Number;

        var _currentFrame:Number = 0;
        var _frames:Array;

        public function LazyDuck(initialLocation:Point) {
            super(initialLocation);
            _frames = [new imgCls1(), new imgCls2(), new imgCls3()];
        }


        override public function advance():void {
            location.offset(5, 0);
            if (++_currentFrame >= _frames.length) {
                _currentFrame = 0;
            }
        }

        override public function get currentImage():BitmapAsset {
            return _frames[_currentFrame];
        }
    }
}