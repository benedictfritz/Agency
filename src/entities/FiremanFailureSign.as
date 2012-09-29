package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Tween;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Ease;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.tweens.misc.VarTween;

    public class FiremanFailureSign extends Entity {
	private var
	    _text:Text;

	public function FiremanFailureSign() {
	    FP.console.log("Failure sign");

	    _text = new Text("Failure", 0, 0, { size: 64, color: 0xFF0000 });
	    graphic = _text;

	    super(FP.halfWidth - _text.width/2, -_text.height);

	    var _enterTween:VarTween = new VarTween();
	    _enterTween.tween(this, "y", FP.halfHeight - _text.height/2,
	    		      0.5, Ease.bounceOut);
	    FP.world.addTween(_enterTween);
	}
    }
    
}
