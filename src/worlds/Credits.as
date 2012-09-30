package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;

    public class Credits extends World {
	[Embed(source="../../assets/images/credits.png")]
	    private const CREDITS:Class;
	[Embed(source="../../assets/sounds/win_full.mp3")]
	    private static var MUSIC:Class;

	private var
	    _music:Sfx = new Sfx(MUSIC);

	public function Credits():void {
	    addGraphic(new Image(CREDITS));
	}

	override public function begin():void {
	    super.begin();
	    _music.loop();
	}

    }

}