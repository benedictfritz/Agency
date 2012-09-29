package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.graphics.Image;

    import entities.*;

    public class SwitchboardWorld extends World {
	[Embed(source="../../assets/images/switchboard_background.png")]
	    private const BACKGROUND:Class;

	public function SwitchboardWorld():void {
	    addGraphic(new Image(BACKGROUND));
	}
    }
}