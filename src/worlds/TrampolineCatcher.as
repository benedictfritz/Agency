package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;

    import entities.*;

    public class TrampolineCatcher extends World {

	private var
	    _timer:Timer,
	    _fireman:Fireman,
	    _faller:Faller;
	
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

	    if (_timer.finished) {
		FP.world = new TempAgency();
	    }
	}
    }
}