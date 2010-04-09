package model {
import flash.events.Event;

public class ScoreChangeEvent extends Event {

    public static const NAME: String = "scoreChanged";

    public function ScoreChangeEvent() {
        super(NAME);
    }
}
}
