package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;

    import entities.*;

    public class TrampolineCatcher extends World {

	private var
	    _timer:Timer,
	    _fireman:Fireman,
	    _faller:Faller,
	    _success:Boolean = false,
	    _done:Boolean = false;
	
	public function TrampolineCatcher():void {
	    _timer = new Timer(FP.width - 120, 20, 10);
	    add(_timer);

	    _fireman = new Fireman(-130, FP.height - 70);
	    add(_fireman);

	    _faller = new Faller(FP.halfWidth - 20, -40);
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
		    add(new SuccessSign());
		    MoneyTracker.money += 100;
		    FP.alarm(2, playAgain);
		}
		else {
		    _done = true;
		    FP.world = new TempAgency();
		}
	    }
	}

	private function playAgain():void {
	    FP.world = new TrampolineCatcher();
	}
    }

}