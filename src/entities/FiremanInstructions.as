package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;

    public class FiremanInstructions extends Entity {
	private var
	    _text:Text;

	public function FiremanInstructions() {
	    _text = new Text("press space to do your job!", 0, 0, 
			     { size:24, color:0x00FF00 });
	    graphic = _text;
	    super(FP.halfWidth - _text.width/2,
		  FP.halfHeight - _text.height/2 + 40);
	}
    }
}