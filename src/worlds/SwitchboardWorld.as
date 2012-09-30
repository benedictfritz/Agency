package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.graphics.Image;

    import entities.*;

    public class SwitchboardWorld extends World {
	[Embed(source="../../assets/images/switchboard_background.png")]
	    private const BACKGROUND:Class;
	[Embed(source="../../assets/images/connector.png")]
	    private const CONNECTOR:Class;

	private var 
	    hasSelected:Boolean = false,
	    success:Boolean = true,
	    trueCorrectAnswer:int,
	    connector:Image;

	public function SwitchboardWorld():void {
	    addGraphic(new Image(BACKGROUND));
	    add(new MoneyTracker());
	    connector = new Image(CONNECTOR);
	    trueCorrectAnswer = int(FP.random*8+1)
	}

	override public function begin():void {
	    // play request to talk to Jonny
	}

	override public function update():void {
	    if (!hasSelected) {
		if (Input.pressed(Key.DIGIT_1)) {
		    // play #1 sound
		    hasSelected = true;
		    addGraphic(connector, -10, 20, 100);
		}
		if (Input.pressed(Key.DIGIT_2)) {
		    // play #2 sound
		    hasSelected = true;
		    addGraphic(connector, -10, 245, 105);
		}
		if (Input.pressed(Key.DIGIT_3)) {
		    // play #3 sound
		    success = false;
		    hasSelected = true;
		    addGraphic(connector, -10, 24, 180);
		}
		if (Input.pressed(Key.DIGIT_4)) {
		    // play #4 sound
		    success = false;
		    hasSelected = true;
		    addGraphic(connector, -10, 245, 187);
		}
		if (Input.pressed(Key.DIGIT_5)) {
		    // play #5 sound
		    hasSelected = true;
		    addGraphic(connector, -10, 24, 263);
		}
		if (Input.pressed(Key.DIGIT_6)) {
		    // play #6 sound
		    success = false;
		    hasSelected = true;
		    addGraphic(connector, -10, 243, 270);
		}
		if (Input.pressed(Key.DIGIT_7)) {
		    // play #7 sound
		    hasSelected = true;
		    addGraphic(connector, -10, 22, 342);
		}
		if (Input.pressed(Key.DIGIT_8)) {
		    // play #8 sound
		    hasSelected = true;
		    addGraphic(connector, -10, 243, 350);
		}
	    }
	}
    }
}