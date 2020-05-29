/*
This class will be used to create button objects for the main menu. The main purpose here
is for the button to act as a way for the user to navigate the game. There will be an int code
that corresponds to the action that pressing the button will result in. The code is as follows:

0	:	1 Player Game
1	:	2 Player Game
2	:	Options
3	:	Highscore
4	:	Credits
5	:	Exit
6	:	CPU only game

Depending on the code, the appropriate action will be taken by the game. The reason this is done
is so that each buttons function can be stored in the same object type to simplify the conditional
statements.
*/

public class Button {

	// Instance Variables
	String _message;
	int _xCord;
	int _yCord;
	int _width;
	int _height;
	int _instruction;

	// Methods
	void display() {
		fill(255);
		rect(_xCord, _yCord, _width, _height);
		fill(115);
		textSize(height / 20);
		text(_message, _xCord, _yCord);
	}

	boolean checkPressed() {
		if (mouseX >= _xCord - _width / 2 && mouseX <= _xCord + _width / 2) {
			if (mouseY >= _yCord - _height / 2 && mouseY <= _yCord + _height / 2) {
				System.out.println("Button Pressed");
				return true;
			}
		}

		return false;
	}

	// Constructors
	public Button(){}

	public Button(String message, int xCord, int yCord, int w, int h, int instruction) {
		_message = message;
		_xCord = xCord;
		_yCord = yCord;
		_width = w;
		_height = h;
		_instruction = instruction;
	}

}
