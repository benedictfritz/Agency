package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.graphics.Image;

    import entities.*;

    public class TempAgency extends World {
	private static var
	    currentJobNumber:int = 0;

	private var
	    dialogueBox:DialogueBox,
	    jobsArray:Array,
	    nextJob:World;

	[Embed(source="../../assets/images/agency_background.png")]
	    private const BACKGROUND:Class;

	public function TempAgency():void {
	    addGraphic(new Image(BACKGROUND));
	    add(new MoneyTracker);

	    dialogueBox = new DialogueBox(FP.halfWidth - 80, 10,
					  FP.halfWidth + 80, FP.halfHeight);

	    if (currentJobNumber == 0) {
		dialogueBox.textArray =
		    new Array("Welcome to the temp agency.",
			      "Looks like we found a new job for you.");
		nextJob = new TrampolineCatcher();
	    }
	    if (currentJobNumber == 1) {
		dialogueBox.textArray =
		    new Array("Well that didn't go as well as we had hoped...",
			      "How about you try this for a change of pace.");
		nextJob = new World2();		
	    }
	    add(dialogueBox);

	    dialogueBox.advanceText();

	    currentJobNumber++;
	}

	override public function update():void {
	    super.update();

	    if (dialogueBox.done) { FP.world = nextJob; }

	    if (Input.pressed(Key.X)) { dialogueBox.advanceText(); }
	}
    }
}