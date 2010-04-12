package view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import model.DuckChangeEvent;
import model.IDuck;

import mx.core.IVisualElementContainer;

import spark.components.Group;
import spark.primitives.BitmapImage;

public class DuckShape extends Group {
    private var _duck: IDuck;
    private var _image: BitmapImage;

    public function DuckShape(duck: IDuck) {
        _duck = duck;
        _duck.addEventListener(DuckChangeEvent.NAME, update);

        _image = new BitmapImage();
        addElement(_image);

        addEventListener(MouseEvent.MOUSE_DOWN, hit);
    }

    private function update(event: DuckChangeEvent): void {
        if (_duck.dismissed) {
            // hide this shape
            (parent as IVisualElementContainer).removeElement(this);
        } else {
            // move the shape
            var bitmapData: BitmapData = _duck.currentImage.bitmapData;
            _image.source = new Bitmap(bitmapData);
            x = _duck.location.x;
            y = _duck.location.y;

            // flip the image if duck flies to the right
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