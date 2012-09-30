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

    public class FiremanWorld extends World {
	[Embed(source="../../assets/images/fireman_background.png")]
	    private const BACKGROUND:Class;

	[Embed(source="../../assets/sounds/working.mp3")]
	    private static var MUSIC:Class;
	[Embed(source="../../assets/sounds/win.mp3")]
	    private static var WIN:Class;
	[Embed(source="../../assets/sounds/fire.mp3")]
	    private static var FIRE:Class;
	[Embed(source="../../assets/sounds/splat.mp3")]
	    private static var SPLAT:Class;

	private var
	    _timer:Timer,
	    _fireman:Fireman,
	    _faller:Faller,
	    _success:Boolean = false,
	    _done:Boolean = false,
	    _blackCover:Image,
	    _music:Sfx,
	    _splat:Sfx,
	    _winMusic:Sfx,
	    _fireSound:Sfx;
	
	public function FiremanWorld():void {
	    var backgroundSprite:Spritemap = new Spritemap(BACKGROUND, 640, 480);
	    backgroundSprite.add("burn", [0, 1], 14, true);
	    backgroundSprite.play("burn");
	    addGraphic(backgroundSprite);

	    _music = new Sfx(MUSIC);
	    _winMusic = new Sfx(WIN);
	    _fireSound = new Sfx(FIRE);
	    _splat = new Sfx(SPLAT);

	    _timer = new Timer(10);
	    add(_timer);

	    _fireman = new Fireman(-70, FP.height - 80);
	    add(_fireman);

	    _faller = new Faller(FP.halfWidth, 50);
	    add(_faller);

	    _blackCover = Image.createRect(FP.width, FP.height, 0x000000);

	    add(new MoneyTracker());
	}

	override public function begin():void {
	    // rotate faller
	    FP.alarm(2, function():void { _faller.vy = 47; });
	    FP.alarm(2.5, function():void {
		    var _rotationTween:VarTween = new VarTween();
		    _rotationTween.tween(Image(_faller.graphic), "angle", 0, 1);
		    addTween(_rotationTween);
		});
	    _music.loop();
	    _fireSound.loop(0.1);
	}

	override public function update():void {
	    super.update();

	    if (_done && _success) { 
		if (Input.check(Key.SPACE)) {
		    _winMusic.stop();
		    FP.world = new FiremanWorld();
		}
	    }
	    if (_done && !_success) {return; }

	    if (_faller.collideWith(_fireman, _faller.x, _faller.y) != null
		&& !_success) {
		_faller.stop();
		_fireman.stop();
		_success = true;
	    }

	    if (_timer.finished && !_done) {
		if (_success) {
		    _winMusic.loop();
		    _music.stop();
		    _fireSound.stop();
		    _done = true;
		    add(new FiremanSuccessSign());
		    add(new FiremanInstructions());
		    MoneyTracker.money += 100;
		}
		else {
		    _done = true;
		    _fireSound.stop();
		    _splat.play();
		    addGraphic(_blackCover, -100);
		    _music.stop();
		    FP.alarm(4, function():void { FP.world = new TempAgency(); });
		}
	    }
	}
    }

}