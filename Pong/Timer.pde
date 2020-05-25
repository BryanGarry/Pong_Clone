/*
This class is used as a timer for this that need to be dealt with on a time level
*/

public class Timer {

	// Instance Variables
	float _time;

	// Methods
	void countUp() {
		_time += 1 / frameRate;
	}

	void countDown() {
		_time -= 1 / frameRate;
	}

	// Constructors
	public Timer() {
		_time = 0.0;
	}

	public Timer(float t) {
		_time = t;
	}
}