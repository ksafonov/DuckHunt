package model {
import flash.events.IEventDispatcher;
import flash.geom.Point;

import mx.core.BitmapAsset;

[Event(name="duckChanged", type="DuckChangeEvent")]

public interface IDuck extends IEventDispatcher {

    /**
     * @return An image to show for the duck currently
     */
    function get currentImage(): BitmapAsset;

    /**
     * @return current duck location relative to the top-left corner of the playground
     */
    function get location(): Point;

    function set location(p: Point): void;

    /**
     * Flight direction
     */
    function get fliesToTheRight(): Boolean;

    function set fliesToTheRight(p: Boolean): void;

    /**
     * Perform the duck movement
     */
    function advance(): void;

    /**
     * Update duck's state when it's hit
     */
    function hit(): void;

    /**
     * @return <code>true</code> if duck is dismissed and should be removed from the view
     */
    function get dismissed(): Boolean;

    /**
     * Called when duck flew out of the screen
     */
    function dismiss(): void;

    /**
     * @return Points that user gets when hits this duck
     */
    function get points(): int;

}
}