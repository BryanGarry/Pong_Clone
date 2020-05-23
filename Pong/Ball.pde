/*
This class will be to represent the ball object that will be used to
play the game between the players
*/

public class Ball {
	// Instance Variable
	int _xCord;
	int _yCord;
	int _radius;

	// Methods
	void show() {
		circle(_xCord, _yCord, _radius);
	}

	// Constructors
	public Ball() {}

	public Ball(int xCord, int yCord, int radius) {
		_xCord = xCord;
		_yCord = yCord;
		_radius = radius;

	}


}
