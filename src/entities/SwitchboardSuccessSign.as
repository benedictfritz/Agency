package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Tween;
    import net.flashpunk.Entity;
    import net.flashpunk.utils.Ease;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.tweens.misc.VarTween;

    public class SwitchboardSuccessSign extends Entity {
	private var
	    _text:Text,
	    _growTextTween:VarTween,
	    _shrinkTextTween:VarTween;

	public function SwitchboardSuccessSign() {
	    _text = new Text("Successful connection!", 0, 0,
			     { width: 400, height: 100, size: 52, 
			       color: 0x00FF00, wordWrap:true, align:"center" });
	    graphic = _text;

	    layer = -100;

	    growText();

	    super(FP.halfWidth - _text.width/2, FP.halfHeight - _text.height/2);
	}

	override public function update():void {
	    super.update();

	    // have to keep ourselves centered while bouncing
	    x = FP.halfWidth - _text.width*_text.scale/2;
	    y = FP.halfHeight - _text.height*_text.scale/2;
	}

	public function growText():void {
	    _growTextTween = new VarTween(shrinkText);
	    _growTextTween.tween(_text, "scale", 1.25, 0.25, Ease.sineInOut);
	    FP.world.addTween(_growTextTween);
	}

	public function shrinkText():void {
	    _shrinkTextTween = new VarTween(growText);
	    _shrinkTextTween.tween(_text, "scale", 1, 0.25, Ease.sineInOut);
	    FP.world.addTween(_shrinkTextTween);
	}

	
    }
}