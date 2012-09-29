package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;
    
    public class Timer extends Entity {

	public var
	    finished:Boolean;
	
	private var
	    _timerText:Text,
	    _time:Number;

	public function Timer(x:Number, y:Number, startTime:Number):void {
	    super(x, y);

	    _time = startTime;
	    graphic = _timerText;
	}

	override public function update():void {
	    if (finished) { return; }

	    _time -= FP.elapsed;
	    if (_time <= 0) {
		finished = true;
		_time = 0;
	    }

	    // get to specific decimal point accuracy
	    var _timeString:String = String(int(_time * 100)/100.0);
	    _timerText = new Text(_timeString, 0, 0, { align:"center", size:50 });
	    graphic = _timerText;
	    super.update();
	}

    }
      
    
}