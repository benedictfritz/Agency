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

    public class TempAgency extends World {
	private static var
	    currentJobNumber:int = 0;

	private var
	    dialogueBox:DialogueBox,
	    jobsArray:Array,
	    nextJob:World,
	    music:Sfx;

	[Embed(source="../../assets/images/agency_background.png")]
	    private const BACKGROUND:Class;

	[Embed(source="../../assets/sounds/temp_agency.mp3")]
	    private static var MUSIC:Class;

	public function TempAgency():void {
	    addGraphic(new Image(BACKGROUND));
	    add(new MoneyTracker);

	    music = new Sfx(MUSIC);
	    music.loop();

	    dialogueBox = new DialogueBox(FP.halfWidth - 80, 10,
					  FP.halfWidth + 80, FP.halfHeight);

	    if (currentJobNumber == 0) {
		dialogueBox.textArray =
		    new Array("Welcome to Semantics Agency of Temporary Empoyment.", "I'll be your supervisor, Ray Jepson.", "Let's see here, a masters in astrophysics?", "Let's start you off as telephone operator.", "Ethyl is the only one who still uses the operator, so just connect her to a friend and you'll be fine.");
		nextJob = new SwitchboardWorld();
	    }
	    if (currentJobNumber == 1) {
		dialogueBox.textArray =
		    new Array("Maybe we started you off a little too quickly.", "Let's try something a bit slower.");
		nextJob = new FiremanWorld();		
	    }
	    if (currentJobNumber == 2) {
		dialogueBox.textArray =
		    new Array("Well that didn't go quite as planned.", "You responded surprisingly well to the fire; I only wish we could say the same for the civilians.", "Perhaps you should try something with fewer people skills.", "Bomb squad?");

		nextJob = new DefuseWorld();
	    }
	    if (currentJobNumber == 3) {
		dialogueBox.textArray =
		    new Array("You're looking well, considering.", "Some quiet time in the kitchen could really do you some good.");
		nextJob = new CookingWorld();
	    }
	    if (currentJobNumber == 4) {
		dialogueBox.textArray =	new Array("Don't worry, I mix up soap and sopa all the time.", "Unfortunately, the restaurant owners aren't so understanding and are suing you.", "Sorry.");
		nextJob = new Credits();
	    }

	    add(dialogueBox);

	    dialogueBox.advanceText();

	    currentJobNumber++;
	}

	override public function update():void {
	    super.update();

	    if (dialogueBox.done) {
		music.stop();
		FP.world = nextJob;
	    }

	    if (Input.pressed(Key.SPACE)) { dialogueBox.advanceText(); }
	}
    }
}