package model {
    import model.ducks.LazyDuck;

    public class DuckFactory {
        private static const DUCKS_CLASSES: Array = [LazyDuck];

        public static function newDuck(): IDuck {
            var i: int = Math.random() * DUCKS_CLASSES.length;
            return new DUCKS_CLASSES[i];
        }
    }
}