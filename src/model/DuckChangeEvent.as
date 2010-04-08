package model {
    import flash.events.Event;

    public class DuckChangeEvent extends Event {

        public static const NAME:String = "duckChanged";

        private var _duck:IDuck;

        private var _hitEvent : Boolean;

        public function DuckChangeEvent(duck:IDuck, hitEvent: Boolean) {
            super(NAME);
            _duck = duck;
            _hitEvent = hitEvent;
        }

        public function get duck():IDuck {
            return _duck;
        }

        public function get hitEvent(): Boolean {
            return _hitEvent;
        }
    }
}