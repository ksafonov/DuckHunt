package {
import flash.geom.Point;
import flash.utils.getQualifiedClassName;

import flexunit.framework.Assert;

import model.DuckFactory;
import model.IDuck;

public class DuckTest {

    [Test]
    public function testAlive(): void {
        forEachDuckType(function(duck: IDuck): void {
            Assert.assertTrue(dump(duck) + " should not be dismissed by default", !duck.dismissed);
            duck.advance();
            Assert.assertTrue(dump(duck) + " should not be dismissed after advance", !duck.dismissed);
        });
    }

    [Test]
    public function testMove(): void {
        forEachDuckType(function(duck: IDuck): void {
            var location: Point = duck.location;
            duck.location = location;
            duck.advance();
            Assert.assertFalse(dump(duck) + " does not move", location.equals(duck.location));
        });
    }

    [Test]
    public function testImage(): void {
        forEachDuckType(function(duck: IDuck): void {
            Assert.assertNotNull(dump(duck) + " does not have an image", duck.currentImage);
            duck.advance();
            Assert.assertNotNull(dump(duck) + " does not have an image", duck.currentImage);
            duck.hit();
            Assert.assertNotNull(dump(duck) + " does not have an image", duck.currentImage);
        });
    }

    [Test]
    public function testPoints(): void {
        forEachDuckType(function(duck: IDuck): void {
            Assert.assertTrue(dump(duck) + " gives no points", duck.points > 0);
        });
    }

    private static function forEachDuckType(testIt: Function): void {
        for (var i: int = 0; i < DuckFactory.DUCKS_CLASSES.length; i++) {
            var clazz: Class = DuckFactory.DUCKS_CLASSES[i];
            testIt(new clazz());
        }
    }

    private static function dump(duck: IDuck): String {
        return getQualifiedClassName(duck);
    }
}
}