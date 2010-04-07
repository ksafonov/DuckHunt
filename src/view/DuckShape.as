package view {
    import flash.display.Bitmap;

    import model.IDuck;

    import mx.controls.Image;

    public class DuckShape extends Image {
        private var _duck:IDuck;

        public function DuckShape(duck:IDuck) {
            _duck = duck;
        }

        public function update():void {
            x = _duck.location.x;
            y = _duck.location.y;
            source = new Bitmap(_duck.currentImage.bitmapData);
        }
    }
}