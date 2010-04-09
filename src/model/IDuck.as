package model {
import flash.events.IEventDispatcher;
import flash.geom.Point;

import mx.core.BitmapAsset;

[Event(name="duckChanged", type="DuckChangeEvent")]

public interface IDuck extends IEventDispatcher {

    /**
     * @return an image to show for the duck currently
     */
    function get currentImage(): BitmapAsset;

    /**
     * @return current duck location relative to the top-left corner of the playground
     */
    function get location(): Point;

    function set location(p: Point): void;

    /**
     * the duck flight direction
     */
    function get leftToRight(): Boolean;

    function set leftToRight(p: Boolean): void;

    /**
     * perform the duck movement
     */
    function advance(): void;

    /**
     * update duck's state when it's hit
     */
    function hit(): void;

    /**
     * @return <code>true</code> if duck is dismissed and should be removed from the view
     */
    function get dismissed(): Boolean;

    /**
     * called when duck flew out of the screen
     */
    function dismiss(): void;

    /**
     * @return points that user gets when hits this duck
     */
    function get points(): int;

}
}