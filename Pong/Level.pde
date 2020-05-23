/*
This class will represent the level object and will keep the ball
within the window
*/

public class Level {

	// Instance Variables
	int railWidth = width;
	int railHeight = (int)(height * 0.05);
	int xCordTopRail = (int)(width * 0.5);
	int yCordTopRail = (int)(height * 0.2);
	int xCordBottomRail = (int)(width * 0.5);
	int yCordBottomRail = (int)(height * 0.9);

	// Methods
	void show() {
		rect(xCordTopRail, yCordTopRail, railWidth, railHeight);
		rect(xCordBottomRail, yCordBottomRail, railWidth, railHeight);
	}

	// Constructors
	Level() {}

}