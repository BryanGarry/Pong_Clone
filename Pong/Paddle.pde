/*
This class will be to represent the paddle objects that will be
controlled by the individual players or the AI depending on what
mode they are set to.
*/

public class Paddle {
	// Instance Variable
	int _xCord;
	int _yCord;
	int _width;
	int _height;
	int _velocity = 2;

	// Methods
	void show() {
		rect(_xCord, _yCord, _width, _height);
	}

	void move(int code) {
		if (code == -1) {
			_yCord = _yCord - _velocity;
		} else if (code == 1) {
			_yCord = _yCord + _velocity;
		}
	}

	// Constructors
	public Paddle() {}

	public Paddle(int xCord, int yCord, int w, int h) {
		_xCord = xCord;
		_yCord = yCord;
		_width = w;
		_height = h;

	}


}
