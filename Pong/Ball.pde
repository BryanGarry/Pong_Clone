/*
This class will be to represent the ball object that will be used to
play the game between the players
*/

public class Ball {
	// Instance Variable
	int _xCord;
	int _yCord;
	int _radius;
	int _velocity = 5;
	int _xVelocity;
	int _yVelocity;
	float _angleDeg;
	float _angleRad;


	// Methods
	void show() {
		circle(_xCord, _yCord, _radius);
	}

	void move() {
		calculateVelocityComponents();
		_xCord = _xCord + _xVelocity;
		_yCord = _yCord + _yVelocity;
	}

	void calculateVelocityComponents() {
		_angleRad = radians(_angleDeg);
		_xVelocity = (int) (cos(_angleRad) * _velocity);
		_yVelocity = (int) (sin(_angleRad) * _velocity);
	}


	// Constructors
	public Ball() {}

	public Ball(int xCord, int yCord, int radius) {
		_xCord = xCord;
		_yCord = yCord;
		_radius = radius;

	}


}
