package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Spritemap;

    public class Fireman extends Entity {
	[Embed(source="../../assets/images/fireman.png")]
	    private const FIREMAN:Class;

	private static const
	    DEFAULT_VX:Number = 120;
	
	private var
	    _vx:Number = 0,
	    _accel:Number = 1,
	    _stopped:Boolean = false,
	    _firemanSprite:Spritemap;

	public function Fireman(x:Number, y:Number) {
	    super(x, y);

	    _firemanSprite = new Spritemap(FIREMAN, 141, 80);
	    _firemanSprite.add("stop", [0], 1, true);
	    _firemanSprite.add("run", [0, 1], 8, true);
	    _firemanSprite.play("run");
	    _firemanSprite.centerOO();
	    graphic = _firemanSprite;

	    setHitbox(61, 20, -40, -32);

	    // setHitbox(_firemanSprite.width, _firemanSprite.height);
	    this.centerOrigin();
	}

	override public function update():void {
	    super.update();
	    if (_stopped) { return; }
	    checkKeyPresses();

	    // var centerOfScreenX:Number = FP.halfWidth - this.width/2;
	    if (x == FP.halfWidth) { _firemanSprite.play("stop"); }
	    else { _firemanSprite.play("run"); }
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
		if (x <= FP.halfWidth) {
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
		if (goingRight && (x > FP.halfWidth)
		    || !goingRight && (x < FP.halfWidth)) {
		    x = FP.halfWidth;
		    _vx = 0;
		}
	    }
	}

	public function stop():void {
	    _stopped = true;
	}
	
    }
}