package model {
    import flash.events.Event;

    public class DuckChangeEvent extends Event {

        public static const NAME:String = "duckChanged";

        private var _duck:IDuck;

        public function DuckChangeEvent(duck:IDuck) {
            super(NAME);
            _duck = duck;
        }

        public function get duck():IDuck {
            return _duck;
        }
    }
}