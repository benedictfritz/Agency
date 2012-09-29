package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class Faller extends Entity {
	
	private var
	    _vy:Number = 0;

	[Embed(source="../../assets/images/faller.png")]
	    private const FALLER:Class;

	public function Faller(x:Number, y:Number) {
	    super(x, y);

	    var fallerImg:Image = new Image(FALLER);
	    fallerImg.centerOO();
	    graphic = fallerImg;
	    setHitbox(50, 22, 20, 15);

	    // delay the jump
	    FP.alarm(5, function():void { _vy = 50; });
	    this.centerOrigin();
	}

	override public function update():void {
	    super.update();
	    moveBy(0, FP.elapsed*_vy);
	}

	public function stop():void {
	    _vy = 0;
	}

    }
}