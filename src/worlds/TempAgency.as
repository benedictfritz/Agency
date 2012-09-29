package worlds
{
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.utils.Key;
    import net.flashpunk.utils.Input;
    import net.flashpunk.graphics.Text;

    import entities.*;

    public class TempAgency extends World {
	private static var
	    currentJobNumber:int = 0;

	private var
	    dialogueBox:DialogueBox,
	    jobsArray:Array,
	    nextJob:World;

	public function TempAgency():void {
	    dialogueBox = new DialogueBox(0, 0, FP.halfWidth, FP.halfHeight);

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

	    currentJobNumber++;
	}

	override public function update():void {
	    super.update();

	    if (dialogueBox.done) { FP.world = nextJob; }

	    if (Input.pressed(Key.X)) { dialogueBox.advanceText(); }
	}
    }
}