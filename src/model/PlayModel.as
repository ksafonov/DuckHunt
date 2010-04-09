package model {
import flash.display.BitmapData;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.collections.ArrayList;
import mx.collections.IList;

public class PlayModel extends EventDispatcher {

    private var _visibleAreaProvider: Function;
    private var _ducks: IList = new ArrayList();
    private var _score: int;

    public function PlayModel(visibleArea: Function) {
        _visibleAreaProvider = visibleArea;
    }

    private function get visibleArea(): Rectangle {
        return _visibleAreaProvider();
    }

    public function createNewDuck(): IDuck {
        var duck: IDuck = DuckFactory.newDuck();

        // visible area extended by duck's size to the left and top
        var area: Rectangle = new Rectangle(-duck.currentImage.bitmapData.width + 1, 0, visibleArea.width - 1 + duck.currentImage.bitmapData.width, visibleArea.height - duck.currentImage.bitmapData.height);

        var leftToRight: Boolean = Math.random() >= 0.5;
        duck.leftToRight = leftToRight;

        duck.location = new Point(leftToRight ? area.left : area.right, area.top + Math.random() * area.height);
        _ducks.addItem(duck);
        duck.addEventListener(DuckChangeEvent.NAME, duckChanged);
        return duck;
    }

    private function duckChanged(event: DuckChangeEvent): void {
        if (event.duck.dismissed) {
            _ducks.removeItemAt(_ducks.getItemIndex(event.duck));
            return;
        }

        if (event.hitEvent) {
            _score += event.duck.points;
            fireScoreChanged();
        }
        var location: Point = event.duck.location;
        var bitmapData: BitmapData = event.duck.currentImage.bitmapData;
        var duckBoundaries: Rectangle = new Rectangle(location.x, location.y, bitmapData.width, bitmapData.height);
        if (!visibleArea.intersects(duckBoundaries)) {
            event.duck.dismiss();
        }
    }

    public function advanceAllDucks(): void {
        var stableCopy: Array = _ducks.toArray(); // since ducks list may change in duck.advance()
        for each (var duck: IDuck in stableCopy) {
            duck.advance();
        }
    }

    public function miss(): void {
        if (_score > 0) {
            _score--;
            fireScoreChanged();
        }
    }

    private function fireScoreChanged(): void {
        dispatchEvent(new ScoreChangeEvent());
    }

    public function get score(): int {
        return _score;
    }
}
}