package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Image;

    public class Fireman extends Entity {

	private static const
	    DEFAULT_VX:Number = 100;
	
	private var
	    _vx:Number = 0,
	    _accel:Number = 5;

	public function Fireman(x:Number, y:Number) {
	    super(x, y);
	    var tempRect:Image = Image.createRect(120, 60, 0xFF0000);
	    graphic = tempRect;
	    setHitbox(tempRect.width, tempRect.height);
	}

	override public function update():void {
	    super.update();
	    checkKeyPresses();
	    moveBy(FP.elapsed*_vx, 0);
	}

	private function checkKeyPresses():void {
	    if (Input.check(Key.LEFT)) { _vx -= _accel*2; }
	    else if (Input.check(Key.RIGHT)) { _vx += _accel*2; }
	    else {
		var centerOfScreenX:Number = FP.halfWidth - this.width/2;
		if (x == centerOfScreenX) { return; }

		if (x < centerOfScreenX) { 
		    if (_vx > DEFAULT_VX) { _vx = DEFAULT_VX; }
		    else { _vx += _accel; }
		}
		else {
		    if (_vx < -DEFAULT_VX) { _vx = -DEFAULT_VX; }
		    else { _vx -= _accel; }
		}
	    }
	}
	
    }
}