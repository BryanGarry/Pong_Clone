/*
This class will be to represent the ball object that will be used to
play the game between the players
*/

public class Ball {
	// Instance Variable
	int _xCord;
	int _yCord;
	int _radius;
	int _velocity = 3;
	int _xVelocity;
	int _yVelocity;
	float _angleDeg;
	float _angleRad;
	boolean _serve = true;
	boolean _serveDirection = true;	// This boolean is true if serve is to the right, false if to the left


	// Methods
	void show() {
		circle(_xCord, _yCord, _radius);
	}

	void move() {
		// Check to see if the ball needs to be served
		if (_serve == true) {
			if (_serveDirection == true) {
				_angleDeg = 315.0;		// Serve the ball to the right
			} else {
				_angleDeg = 180.0;		// Serve the ball to the left
			}
			_serve = false;
		}

		// If the ball is already served then move the ball accordingly
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
