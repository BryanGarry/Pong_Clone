/*
This class will represent the level object and will keep the ball
within the window
*/

public class Level {

	// Instance Variables
	int _railWidth = width;
	int _railHeight = (int)(height * 0.05);
	int _xCordTopRail = (int)(width * 0.5);
	int _yCordTopRail = (int)(height * 0.2);
	int _xCordBottomRail = (int)(width * 0.5);
	int _yCordBottomRail = (int)(height * 0.9);
	int leftBound = (int)(width * 0.2);
  	int rightBound = (int)(width * 0.8);

	// Methods
	void show() {
		stroke(0);
		strokeWeight(2);
		for (int i = (int)(_yCordTopRail); i < _yCordBottomRail; i += 20) {
			line(leftBound, i, leftBound, i + 10);
			line(rightBound, i, rightBound, i + 10);
		}
		noStroke();
		rect(_xCordTopRail, _yCordTopRail, _railWidth, _railHeight);
		rect(_xCordBottomRail, _yCordBottomRail, _railWidth, _railHeight);
	}

	// Constructors
	Level() {}

}
