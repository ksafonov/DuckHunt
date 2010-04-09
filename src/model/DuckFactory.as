package model {
import model.ducks.LazyDuck;
import model.ducks.QuickDuck;

public class DuckFactory {
    public static const DUCKS_CLASSES: Array = [LazyDuck, QuickDuck];

    public static function newDuck(): IDuck {
        var i: int = Math.random() * DUCKS_CLASSES.length;
        return new DUCKS_CLASSES[i];
    }
}
}