package view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import model.DuckChangeEvent;
import model.IDuck;

import mx.containers.Box;
import mx.controls.Image;

public class DuckShape extends Box {
    private var _duck: IDuck;
    private var _image: Image;

    public function DuckShape(duck: IDuck) {
        _duck = duck;
        _duck.addEventListener(DuckChangeEvent.NAME, update);

        _image = new Image();
        addChild(_image);

        _image.addEventListener(MouseEvent.MOUSE_DOWN, hit);
    }

    private function update(event: DuckChangeEvent): void {
        if (_duck.dismissed) {
            // hide this shape
            parent.removeChild(this);
        } else {
            var bitmapData: BitmapData = _duck.currentImage.bitmapData;
            _image.source = new Bitmap(bitmapData);
            x = _duck.location.x;
            y = _duck.location.y;

            var matrix: Matrix = _image.transform.matrix;
            matrix.a = _duck.leftToRight ? -1 : 1;
            matrix.tx = _duck.leftToRight ? bitmapData.width : 0;
            _image.transform.matrix = matrix;
        }
    }

    public function hit(e: MouseEvent): void {
        _duck.hit();
    }
}
}