package model {
    import flash.geom.Point;

    import mx.controls.Image;
    import mx.core.BitmapAsset;

    public class BaseDuck implements IDuck {
        protected var _location:Point;

        public function BaseDuck(initialLocation:Point) {
            location = initialLocation;
        }

        public function get currentImage():Class {
            return null;
        }

        public function get location():Point {
            return _location;
        }

        public function set location(p:Point):void {
            _location = p.clone();
        }

        public function advance():void {
            // base implementation does nothing
        }

        public function hit():void {
            // base implementation does nothing
        }

        public function isAlive():Boolean {
            // immortal duck by default
            return true;
        }
    }
}