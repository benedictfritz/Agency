package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.tweens.misc.VarTween;

    public class Faller extends Entity {
	
	private var
	    _vy:Number = 0;

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

	    // delay the jump
	    FP.alarm(5, function():void { _vy = 50; });
	    FP.alarm(5.5, function():void {
		    var _rotationTween:VarTween = new VarTween();
		    _rotationTween.tween(fallerImg, "angle", 0, 1);
		    addTween(_rotationTween);
		});
	    this.centerOrigin();
	}

	override public function update():void {
	    super.update();

	    if (y < FP.height - 30) {
		moveBy(0, FP.elapsed*_vy);
	    }
	}

	public function stop():void {
	    _vy = 0;
	}

    }
}