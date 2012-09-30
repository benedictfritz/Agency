package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Tween;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Ease;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.tweens.misc.VarTween;

    public class SwitchboardFailureSign extends Entity {
	private var
	    _text:Text;

	public function SwitchboardFailureSign() {
	    _text = new Text("WHAT HAVE YOU DONE?", 0, 0, { size: 52, color: 0xFF0000 });
	    graphic = _text;

	    layer = -100;

	    super(FP.halfWidth - _text.width/2, -_text.height);

	    var _enterTween:VarTween = new VarTween();
	    _enterTween.tween(this, "y", FP.halfHeight - _text.height/2,
	    		      0.5, Ease.bounceOut);
	    FP.world.addTween(_enterTween);
	}
    }
}
