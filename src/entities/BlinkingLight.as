package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;

    public class BlinkingLight extends Entity {
	[Embed(source="../../assets/images/blinker.png")]
	    private const BLINKER:Class;
	[Embed(source="../../assets/sounds/beep.mp3")]
	    private static var BEEP:Class;

	private var
	    _lightSprite:Spritemap,
	    _beep:Sfx,
	    _playedBeep:Boolean;

	public function BlinkingLight():void {
	    _lightSprite = new Spritemap(BLINKER, 173, 151);
	    _lightSprite.add("blink", [0, 1], 3, true);
	    _lightSprite.centerOO();
	    _lightSprite.play("blink");
	    graphic = _lightSprite;

	    _beep = new Sfx(BEEP);

	    this.centerOrigin();
	    super(FP.halfWidth-7, 268);
	}

	override public function update():void {
	    if (_lightSprite.frame == 0 && !_playedBeep) {
		_playedBeep = true;
		(new Sfx(BEEP)).play(0.3);
	    }
	    else if (_lightSprite.frame == 1) {
		_playedBeep = false;
	    }
	}

    }
}