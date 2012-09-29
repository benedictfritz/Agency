package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;

    public class SuccessSign extends Entity {
	private var
	    _text:Text;

	public function SuccessSign() {
	    _text = new Text("Great job!", 0, 0, { size: 64, color: 0x00FF00 });
	    graphic = _text;

	    super(FP.halfWidth - _text.width/2, FP.halfHeight - _text.height/2);
	}
    }
}