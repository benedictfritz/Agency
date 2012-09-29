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

	public function Timer(startTime:Number):void {
	    var _widthText:Text = new Text("9.99", 0, 0, { size:50 });
	    super(FP.width - _widthText.width, 0);

	    _time = startTime;
	    graphic = _timerText;
	}

	override public function update():void {
	    super.update();
	    if (finished) { return; }

	    _time -= FP.elapsed;
	    if (_time <= 0) {
		finished = true;
		_time = 0;
	    }

	    // get to specific decimal point accuracy
	    var _timeString:String = String(int(_time * 100)/100.0);
	    // make sure we don't show 0 as '0', but '0.00'
	    if (_time == 0) { _timeString = "0.00"; }
	    _timerText = new Text(_timeString, 0, 0, { align:"right", size:50 });
	    graphic = _timerText;
	}
    }
}