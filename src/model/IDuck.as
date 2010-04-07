package model {
    import flash.geom.Point;

    import mx.core.BitmapAsset;

    public interface IDuck {

        /**
         * @return an image to show for the duck currently
         */
        function get currentImage():BitmapAsset;

        /**
         * @return current duck location relative to the top-left corner of the playground
         */
        function get location():Point;

        function set location(p:Point):void;

        /**
         * perform the duck movement
         */
        function advance():void;

        /**
         * update duck's state when it's hit
         */
        function hit():void;

        /**
         * @return <code>true</code> if duck is alive (is moving and subject to be fired at), <code>false</code> otherwise
         */
        function isAlive():Boolean;

    }
}