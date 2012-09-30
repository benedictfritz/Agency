package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Image;

    public class Menu extends World {
	[Embed(source="../../assets/images/menu.png")]
	    private const BACKGROUND:Class;
	[Embed(source="../../assets/sounds/working.mp3")]
	    private static var MUSIC:Class;

	private var
	    _music:Sfx = new Sfx(MUSIC);

	public function Menu():void {
	    addGraphic(new Image(BACKGROUND));
	}

	override public function begin():void {
	    _music.loop();
	}

	override public function update():void {
	    if (Input.pressed(Key.SPACE)) {
		_music.stop();
		FP.world = new TempAgency();
	    }
	}

    }
 }