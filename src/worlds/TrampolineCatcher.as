package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;

    import entities.*;

    public class TrampolineCatcher extends World {

	private var
	    _timer:Timer;
	
	public function TrampolineCatcher():void {
	    _timer = new Timer(FP.halfWidth, FP.halfHeight, 5);
	    add(_timer);
	}

	override public function update():void {
	    super.update();

	    if (_timer.finished) {
		FP.world = new TempAgency();
	    }
	}
    }
}