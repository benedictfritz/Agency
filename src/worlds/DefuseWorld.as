package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;

    import entities.*;

    public class DefuseWorld extends World {
	[Embed(source="../../assets/sounds/working.mp3")]
	    private static var MUSIC:Class;
	[Embed(source="../../assets/sounds/win.mp3")]
	    private static var WIN:Class;
	[Embed(source="../../assets/sounds/explosion.mp3")]
	    private static var EXPLOSION:Class;
	[Embed(source="../../assets/sounds/plug.mp3")]
	    private static var PLUG:Class;
	[Embed(source="../../assets/images/defuse_background.png")]
	    private const BACKGROUND:Class;

	private var
	    _blinkingLight:BlinkingLight,
	    _blinkTween:VarTween,
	    _blackCover:Image,
	    _explosion:Sfx,
	    _music:Sfx,
	    _win:Sfx,
	    _plug:Sfx,
	    _done:Boolean;

	public function DefuseWorld():void {
	    addGraphic(new Image(BACKGROUND));

	    _blinkingLight = new BlinkingLight();
	    add(_blinkingLight);

	    _music = new Sfx(MUSIC);
	    _win = new Sfx(WIN);
	    _explosion = new Sfx(EXPLOSION);
	    _plug = new Sfx(PLUG);

	    add(new MoneyTracker());
	}

	override public function begin():void {
	    _blackCover = Image.createRect(FP.width, FP.height, 0x000000);

	    _blinkTween = new VarTween(explode);
	    _blinkTween.tween(Spritemap(_blinkingLight.graphic), "rate", 8, 10);
	    addTween(_blinkTween);

	    _music.loop();
	}

	override public function update():void {
	    super.update();
	    if(!_done && (Input.check(Key.R) || Input.check(Key.G) || 
			 Input.check(Key.B)) || Input.check(Key.Y)) {
		_plug.play();
	    	remove(_blinkingLight);
	    	_music.stop();
		_done = true;
		_win.loop();
		add(new DefuseSuccessSign());
		add(new DefuseInstructions());
		MoneyTracker.money += 100;
		removeTween(_blinkTween);
	    }
	    if (_done) {
		if (Input.check(Key.SPACE)) {
		    _win.stop();
		    FP.world = new DefuseWorld();
		}
	    }
	}

	private function explode():void {
	    remove(_blinkingLight);
	    addGraphic(_blackCover, -100);
	    _explosion.play(0.2);
	    _music.stop();
	    FP.alarm(4, function():void { FP.world = new TempAgency(); });
	}
    }
}