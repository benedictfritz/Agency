package entities
{
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Text;

    public class DialogueBox extends Entity {
	private static const
	    PRINT_INTERVAL:Number = 0.01;

	private var 
	    text:Text,
	    printing:Boolean,
	    currentWord:String,
	    currentChar:Number,
	    lastPrint:Number,
	    soundsArray:Array;

	public var
	    textArray:Array,
	    done:Boolean = false;

	public function DialogueBox(x:Number, y:Number, 
				    width:Number, height:Number):void {
	    super(x, y);

	    text = new Text("", 0, 0, width, height);
	    text.wordWrap = true;
	    text.size = 24;
	    text.color = 0xFFFFFF;
	    graphic = text;

	    printing = false;
	    advanceText();
	}

	override public function update():void {
	    super.update();
	    if (printing) {
		lastPrint += FP.elapsed;
		if (lastPrint > PRINT_INTERVAL) { continuePrinting(); }
	    }
	}

	public function advanceText():void {
	    if (!textArray) { return; }
	    if (!printing) {
		if (textArray.length == 0) {
		    done = true;
		    return;
		}
		printing = true;
		currentWord = textArray.shift();
		currentChar = -1;
		lastPrint = PRINT_INTERVAL;
		text.text = "";
	    }
	}

	private function continuePrinting():void {
	    lastPrint = 0;
	    currentChar++;
		    
	    if (currentChar > currentWord.length-1) { printing = false; }
	    else { concatCharactersToDialogue(); }
	}

	private function concatCharactersToDialogue():void {
	    var nextChar:String = currentWord.charAt(currentChar);
	    var currText:String = text.text;
	    currText = currText.concat(nextChar);
	    text.text = currText;
	}

    }
}