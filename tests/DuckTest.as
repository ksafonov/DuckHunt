package {
import flash.geom.Point;

import flexunit.framework.Assert;

import model.DuckFactory;
import model.IDuck;

public class DuckTest {

    private function forEachDuck(testIt: Function): void {
        for (var i: int = 0; i < DuckFactory.DUCKS_CLASSES.length; i++) {
            var clazz: Class = DuckFactory.DUCKS_CLASSES[i];
            testIt(new clazz());
        }
    }

    [Test]
    public function testAlive(): void {
        forEachDuck(function(duck: IDuck): void {
            Assert.assertTrue(!duck.dismissed);
            duck.advance();
            Assert.assertTrue(!duck.dismissed);
        });
    }

    [Test]
    public function testMove(): void {
        forEachDuck(function(duck: IDuck): void {
            var location: Point = duck.location;
            duck.location = location;
            duck.advance();
            Assert.assertFalse(location.equals(duck.location));
        });
    }

    [Test]
    public function testImage(): void {
        forEachDuck(function(duck: IDuck): void {
            Assert.assertNotNull(duck.currentImage);
            duck.advance();
            Assert.assertNotNull(duck.currentImage);
            duck.hit();
            Assert.assertNotNull(duck.currentImage);
        });
    }

}
}