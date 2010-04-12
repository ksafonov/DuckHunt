package model {
import flash.display.BitmapData;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;

public class PlayModel extends EventDispatcher {

    private static const MISS_PENALTY:int = 1;

    private var _visibleAreaProviderDelegate:Function;
    private var _ducks:Array = new Array();
    private var _score:int;

    public function PlayModel(visibleAreaProviderDelegate:Function) {
        _visibleAreaProviderDelegate = visibleAreaProviderDelegate;
    }

    private function get visibleArea():Rectangle {
        return _visibleAreaProviderDelegate();
    }

    public function createNewDuck():IDuck {
        var duck:IDuck = DuckFactory.newDuck();

        // visible area extended by duck's size to the left and top
        var duckBitmapData:BitmapData = duck.currentImage.bitmapData;

        var area:Rectangle = new Rectangle(-duckBitmapData.width + 1, -duckBitmapData.height / 2, visibleArea.width - 1 + duckBitmapData.width, visibleArea.height + duckBitmapData.height / 2);

        var leftToRight:Boolean = Math.random() >= 0.5;
        duck.leftToRight = leftToRight;

        duck.location = new Point(leftToRight ? area.left : area.right, area.top + Math.random() * area.height);
        _ducks.push(duck);
        duck.addEventListener(DuckChangeEvent.NAME, duckChanged);
        return duck;
    }

    private function duckChanged(event:DuckChangeEvent):void {
        if (event.duck.dismissed) {
            return;
        }

        if (event.hitEvent) {
            _score += event.duck.points;
            fireScoreChanged();
        }
        var location:Point = event.duck.location;
        var bitmapData:BitmapData = event.duck.currentImage.bitmapData;
        var duckBoundaries:Rectangle = new Rectangle(location.x, location.y, bitmapData.width, bitmapData.height);
        if (!visibleArea.intersects(duckBoundaries)) {
            event.duck.dismiss();
            _ducks.splice(_ducks.indexOf(event.duck), 1);
        }
    }

    public function advanceAllDucks():void {
        var stableCopy:Array = new Array().concat(_ducks); // since ducks list may change inside duck.advance()
        for each (var duck:IDuck in stableCopy) {
            duck.advance();
        }
    }

    public function miss():void {
        if (_score > 0) {
            _score -= MISS_PENALTY;
            fireScoreChanged();
        }
    }

    private function fireScoreChanged():void {
        dispatchEvent(new ScoreChangeEvent());
    }

    public function get score():int {
        return _score;
    }
}
}