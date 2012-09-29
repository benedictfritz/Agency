package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class Faller extends Entity {
	
	private var
	    _vy:Number = 50;

	public function Faller(x:Number, y:Number) {
	    super(x, y);

	    var tempRect:Image = Image.createRect(40, 40, 0x0000FF);
	    graphic = tempRect;
	    setHitbox(tempRect.width, tempRect.height);
	}

	override public function update():void {
	    super.update();
	    moveBy(0, FP.elapsed*_vy);
	}

    }
}