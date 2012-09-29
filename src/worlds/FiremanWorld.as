package worlds
{
    import net.flashpunk.FP;
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

	private var
	    _timer:Timer,
	    _fireman:Fireman,
	    _faller:Faller,
	    _success:Boolean = false,
	    _done:Boolean = false;
	
	public function FiremanWorld():void {
	    var backgroundSprite:Spritemap = new Spritemap(BACKGROUND, 640, 480);
	    backgroundSprite.add("burn", [0, 1], 14, true);
	    backgroundSprite.play("burn");
	    addGraphic(backgroundSprite);

	    _timer = new Timer(10);
	    add(_timer);

	    _fireman = new Fireman(-70, FP.height - 80);
	    add(_fireman);

	    _faller = new Faller(FP.halfWidth, 50);
	    add(_faller);

	    add(new MoneyTracker());
	}

	override public function begin():void {
	    // rotate faller
	    FP.alarm(2, function():void { _faller.vy = 50; });
	    FP.alarm(2.5, function():void {
		    var _rotationTween:VarTween = new VarTween();
		    _rotationTween.tween(Image(_faller.graphic), "angle", 0, 1);
		    addTween(_rotationTween);
		});
	}

	override public function update():void {
	    super.update();

	    if (_done && _success) { 
		if (Input.check(Key.SPACE)) {
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
		    _done = true;
		    add(new FiremanSuccessSign());
		    add(new FiremanInstructions());
		    MoneyTracker.money += 100;
		}
		else {
		    _done = true;
		    add(new FiremanFailureSign());
		    FP.alarm(4, function():void { FP.world = new TempAgency(); });
		}
	    }
	}
    }

}