package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Image;

    public class Fireman extends Entity {

	private static const
	    DEFAULT_VX:Number = 120;
	
	private var
	    _vx:Number = 0,
	    _accel:Number = 1,
	    _stopped:Boolean = false; 

	public function Fireman(x:Number, y:Number) {
	    super(x, y);
	    var tempRect:Image = Image.createRect(120, 60, 0xFF0000);
	    graphic = tempRect;
	    setHitbox(tempRect.width, tempRect.height);
	}

	override public function update():void {
	    super.update();
	    if (_stopped) { return; }
	    checkKeyPresses();
	}

	private function checkKeyPresses():void {
	    var pressingRight:Boolean = Input.pressed(Key.RIGHT);
	    var pressingLeft:Boolean = Input.pressed(Key.LEFT);
	    if (pressingLeft || pressingRight) {
		if (pressingLeft) { _vx = -40; }
		if (pressingRight) { _vx = 40; }
		moveBy(FP.elapsed*_vx, 0);
	    }
	    else {
		var centerOfScreenX:Number = FP.halfWidth - this.width/2;
		var goingRight:Boolean;
		if (x <= centerOfScreenX) {
		    goingRight = true;
		    _vx += _accel;
		    if (_vx > DEFAULT_VX) { _vx = DEFAULT_VX; }
		}
		else {
		    goingRight = false;
		    _vx -= _accel;
		    if (_vx < -DEFAULT_VX) { _vx = -DEFAULT_VX; }
		}
		moveBy(FP.elapsed*_vx, 0);

		// stop the default behavior from bouncing back and forth
		if (goingRight && (x > centerOfScreenX)
		    || !goingRight && (x < centerOfScreenX)) {
		    FP.console.log("Stop");
		    x = centerOfScreenX;
		    _vx = 0;
		}
	    }
	}

	public function stop():void {
	    _stopped = true;
	}
	
    }
}