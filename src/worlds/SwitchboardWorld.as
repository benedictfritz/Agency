package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
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
	[Embed(source="../../assets/sounds/working.mp3")]
	    private static var MUSIC:Class;
	[Embed(source="../../assets/sounds/win.mp3")]
	    private static var WIN:Class;
	[Embed(source="../../assets/sounds/lose.mp3")]
	    private static var LOSE:Class;
	[Embed(source="../../assets/sounds/grandma_benedict.mp3")]
	    private static var CALL1:Class;
	[Embed(source="../../assets/sounds/grandma_ethel.mp3")]
	    private static var CALL2:Class;
	[Embed(source="../../assets/sounds/grandma_amethysta.mp3")]
	    private static var CALL3:Class;
	[Embed(source="../../assets/sounds/grandma_emergency.mp3")]
	    private static var CALL4:Class;
	[Embed(source="../../assets/sounds/grandma_winner.mp3")]
	    private static var CALL5:Class;
	[Embed(source="../../assets/sounds/grandma_services.mp3")]
	    private static var CALL6:Class;
	[Embed(source="../../assets/sounds/grandma_duncan.mp3")]
	    private static var CALL7:Class;
	[Embed(source="../../assets/sounds/grandma_old_gregg.mp3")]
	    private static var CALL8:Class;

	private var 
	    hasSelected:Boolean = false,
	    success:Boolean = true,
	    done:Boolean = false,
	    trueCorrectAnswer:int,
	    connector:Image,
	    music:Sfx,
	    winMusic:Sfx,
	    loseMusic:Sfx,
	    moneyTracker:MoneyTracker;

	public function SwitchboardWorld():void {
	    addGraphic(new Image(BACKGROUND));
	    connector = new Image(CONNECTOR);
	    trueCorrectAnswer = int(FP.random*8+1);
	    music = new Sfx(MUSIC);
	    winMusic = new Sfx(WIN);
	    loseMusic = new Sfx(LOSE, 
				function():void { FP.world = new TempAgency(); } );
	}

	override public function begin():void {
	    music.loop(0.6);

	    add(new MoneyTracker());
	}

	override public function update():void {
	    super.update();

	    if (!hasSelected) {
		if (Input.pressed(Key.DIGIT_1)) {
		    hasSelected = true;
		    (new Sfx(CALL1, playEnd)).play();
		    addGraphic(connector, -10, 20, 100);
		}
		if (Input.pressed(Key.DIGIT_2)) {
		    hasSelected = true;
		    (new Sfx(CALL2, playEnd)).play();
		    addGraphic(connector, -10, 245, 105);
		}
		if (Input.pressed(Key.DIGIT_3)) {
		    success = false;
		    hasSelected = true;
		    (new Sfx(CALL3, playEnd)).play();
		    addGraphic(connector, -10, 24, 180);
		}
		if (Input.pressed(Key.DIGIT_4)) {
		    success = false;
		    hasSelected = true;
		    (new Sfx(CALL4, playEnd)).play();
		    addGraphic(connector, -10, 245, 187);
		}
		if (Input.pressed(Key.DIGIT_5)) {
		    hasSelected = true;
		    (new Sfx(CALL5, playEnd)).play();
		    addGraphic(connector, -10, 24, 263);
		}
		if (Input.pressed(Key.DIGIT_6)) {
		    success = false;
		    hasSelected = true;
		    (new Sfx(CALL6, playEnd)).play();
		    addGraphic(connector, -10, 243, 270);
		}
		if (Input.pressed(Key.DIGIT_7)) {
		    hasSelected = true;
		    (new Sfx(CALL7, playEnd)).play();
		    addGraphic(connector, -10, 22, 342);
		}
		if (Input.pressed(Key.DIGIT_8)) {
		    hasSelected = true;
		    (new Sfx(CALL8, playEnd)).play();
		    addGraphic(connector, -10, 243, 350);
		}
	    }
	    else if (done) {
		if (Input.check(Key.SPACE)) {
		    winMusic.stop();
		    FP.world = new SwitchboardWorld();
		}
	    }
	}

	private function playEnd():void {
	    music.stop();
	    done = true;

	    if (success) {
		MoneyTracker.money += 20;
		add(new SwitchboardSuccessSign());
		add(new SwitchboardInstructions());
		winMusic.loop();
	    }
	    else {
		add(new SwitchboardFailureSign());
		loseMusic.play(1);
	    }
	}

    }
}