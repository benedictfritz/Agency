package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;

    public class MoneyTracker extends Entity {

	public static var
	    money:Number;
	
	private var
	    _moneyText:Text;

	public function MoneyTracker():void {
	    super(0, 0);
	}

	override public function update():void {
	    super.update();

	    _moneyText = new Text("$"+String(money), 0, 0, 
				  { size: 46, color: 0x00FF00} );
	    graphic = _moneyText;
	    x = FP.width - _moneyText.width;
	    y = FP.height - _moneyText.height;
	}
    }
}