package view {
import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.geom.Matrix;

import model.DuckChangeEvent;
import model.IDuck;

import mx.controls.Image;

public class DuckShape extends Image {
    private var _duck: IDuck;

    public function DuckShape(duck: IDuck) {
        _duck = duck;
        _duck.addEventListener(DuckChangeEvent.NAME, update);

        if (_duck.leftToRight) {
            var matrix: Matrix = transform.matrix;
            matrix.scale(-1, 1);
            transform.matrix = matrix;
        }
    }

    private function update(event: DuckChangeEvent): void {
        if (_duck.dismissed) {
            // hide this shape
            parent.removeChild(this);
        } else {
            var bitmapData: BitmapData = _duck.currentImage.bitmapData;
            source = new Bitmap(bitmapData);
            x = _duck.leftToRight ? _duck.location.x + bitmapData.width : _duck.location.x;
            y = _duck.location.y;

        }
    }

    public function hit(): void {
        _duck.hit();
    }
}
}