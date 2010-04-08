package view {
    import flash.display.Bitmap;

    import model.DuckChangeEvent;
    import model.IDuck;

    import mx.controls.Image;

    public class DuckShape extends Image {
        private var _duck: IDuck;

        public function DuckShape(duck: IDuck) {
            _duck = duck;
            _duck.addEventListener(DuckChangeEvent.NAME, update);
        }

        private function update(event: DuckChangeEvent): void {
            if (_duck.dismissed) {
                // hide this shape
//                parent.removeChild(this);
            } else {
                x = _duck.location.x;
                y = _duck.location.y;
                source = new Bitmap(_duck.currentImage.bitmapData);
            }
        }

        public function hit(): void {
            _duck.hit();
        }
    }
}