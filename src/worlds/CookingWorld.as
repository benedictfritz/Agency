package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;

    import entities.*;

    public class CookingWorld extends World {

	[Embed(source="../../assets/sounds/working.mp3")]
	    private static var MUSIC:Class;
	[Embed(source="../../assets/sounds/win.mp3")]
	    private static var WIN:Class;
	[Embed(source="../../assets/sounds/lose.mp3")]
	    private static var LOSE:Class;
	[Embed(source="../../assets/sounds/kitchen.mp3")]
	    private static var KITCHEN:Class;
	[Embed(source="../../assets/images/cooking_background.png")]
	    private const BACKGROUND:Class;

	private var
	    _music:Sfx,
	    _win:Sfx,
	    _lose:Sfx,
	    _kitchen:Sfx,
	    _done:Boolean;

	public function CookingWorld():void {
	    addGraphic(new Image(BACKGROUND));
	    add(new MoneyTracker());
	    _music = new Sfx(MUSIC);
	    _win = new Sfx(WIN);
	    _kitchen = new Sfx(KITCHEN);
	    _lose = new Sfx(LOSE,
			    function():void { FP.world = new TempAgency(); } );
	}

	override public function begin():void {
	    super.begin();
	    add(new MoneyTracker);
	    _music.loop();
	    _kitchen.loop();
	}

	override public function update():void {
	    if(!_done && (Input.check(Key.P) || Input.check(Key.B) || 
			  Input.check(Key.G)) || Input.check(Key.T)) {
	    	_music.stop();
		_done = true;
		_win.loop();
		_kitchen.stop();
		add(new CookingSuccessSign());
		add(new CookingInstructions());
		MoneyTracker.money += 100;
	    }
	    else if(!_done && Input.check(Key.S)) {
		_done = true;
		_music.stop();
		_lose.play();
		_kitchen.stop();
		add(new CookingFailureSign());
	    }

	    if (_done && _win.playing) {
		if (Input.check(Key.SPACE)) {
		    _win.stop();
		    _kitchen.stop();
		    FP.world = new CookingWorld();
		}
	    }

	}
    }

}