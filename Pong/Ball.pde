/*
This class will be to represent the ball object that will be used to
play the game between the players
*/

public class Ball {
	// Instance Variable
	float _xCord;
	float _yCord;
	int _radius;
	float _velocity = 2;
	float _xVelocity;
	float _yVelocity;
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
		//System.out.println("angle: " + _angleDeg);
		//_xVelocity = (int) (cos(_angleRad) * _velocity);
		_xVelocity = cos(_angleRad) * _velocity;
		//System.out.println("vX: " + _xVelocity);
		//_yVelocity = (int) (sin(_angleRad) * _velocity);
		_yVelocity = sin(_angleRad) * _velocity;
		//System.out.println("vY: " + _yVelocity);
	}

	void normalizeAngle() {
		if (_angleDeg > 360) {
			_angleDeg = _angleDeg - 360;
		} else if (_angleDeg < 0) {
			_angleDeg = _angleDeg + 360;
		} else {
			return;
		}
	}

	void checkAngleRange(int lowerLimit, int upperLimit) {
		if (ball._angleDeg < lowerLimit + 10) {
			ball._angleDeg = lowerLimit + 10;
		} else if (ball._angleDeg > upperLimit - 10) {
			ball._angleDeg = upperLimit - 10;
		}
	}


	// Constructors
	public Ball() {}

	public Ball(int xCord, int yCord, int radius) {
		_xCord = xCord;
		_yCord = yCord;
		_radius = radius;

	}


}
