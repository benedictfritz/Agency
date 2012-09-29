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
	    _success:Boolean = false;
	
	public function TrampolineCatcher():void {
	    _timer = new Timer(FP.width - 120, 20, 10);
	    add(_timer);

	    _fireman = new Fireman(-130, FP.height - 70);
	    add(_fireman);

	    _faller = new Faller(FP.halfWidth - 20, -40);
	    add(_faller);
	}

	override public function update():void {
	    super.update();

	    if (_faller.collideWith(_fireman, _faller.x, _faller.y) != null) {
		_faller.stop();
		_fireman.stop();
		_success = true;
	    }

	    if (_timer.finished) {
		if (_success) {
		    add(new SuccessSign());
		}
		else {
		    FP.world = new TempAgency();
		}
	    }
	}
    }
}