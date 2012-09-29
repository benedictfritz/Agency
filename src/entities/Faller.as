package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.tweens.misc.VarTween;

    public class Faller extends Entity {
	
	public var
	    vy:Number = 0;

	[Embed(source="../../assets/images/faller.png")]
	    private const FALLER:Class;

	public function Faller(x:Number, y:Number) {
	    super(x, y);

	    var fallerImg:Image = new Image(FALLER);
	    fallerImg.smooth = true;
	    fallerImg.centerOO();
	    fallerImg.angle = 70;
	    graphic = fallerImg;
	    setHitbox(50, 22, 20, 15);

	    this.centerOrigin();
	}

	override public function update():void {
	    super.update();

	    if (y < FP.height - 30) {
		moveBy(0, FP.elapsed*vy);
	    }
	}

	public function stop():void {
	    vy = 0;
	}

    }
}