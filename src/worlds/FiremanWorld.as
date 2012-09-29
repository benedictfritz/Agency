package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;

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

	    _fireman = new Fireman(-130, FP.height - 70);
	    add(_fireman);

	    _faller = new Faller(FP.halfWidth - 20, 50);
	    add(_faller);

	    add(new MoneyTracker());
	}

	override public function update():void {
	    super.update();

	    if (_done) { return; }

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
		    // FP.alarm(2, playAgain);
		}
		else {
		    _done = true;
		    FP.world = new TempAgency();
		}
	    }
	}

	private function playAgain():void {
	    FP.world = new FiremanWorld();
	}
    }

}