/*
PONG CLONE

AUTHOR: BRYAN GARRY

SUMMARY: THIS IS MEANT TO BE A CLONE OF THE FAMOUS GAME PONG
*/

// Variables
Paddle p1Paddle;
Paddle p2Paddle;
Ball ball;
Level level;

// Called to set up the game on the first frame
void setup() {
	size(1250, 750);
	background(115);
	rectMode(CENTER);

  	int p1PosX = (int)(width * 0.1);
  	int p2PosX = (int)(width * 0.9);
  	int startPosY = (int)(height * 0.55);
  	int ballPosX = (int)(width * 0.5);

	p1Paddle = new Paddle(p1PosX, startPosY, 20, 100);
	p2Paddle = new Paddle(p2PosX, startPosY, 20, 100);
	ball = new Ball(ballPosX, startPosY, 25);
	level = new Level();
}

// Continually updates the game each frame
void draw() {
  background(115);
	p1Paddle.show();
	p2Paddle.show();
	ball.show();
	level.show();

	ball.move();

	detectCollision();
}

// Logic to determine if the ball has collided with something
void detectCollision() {
	// For right now, treat the ball as a square

	// Check top rail
	if (ball._yCord - ball._radius / 2 <= level._yCordTopRail + level._railHeight / 2) {
		// Check to see which direction the ball is headed and flip accordingly
		if (ball._angleDeg == 270) {
			ball._angleDeg = 90;
		} else {
			ball._angleDeg = 90 - (ball._angleDeg - 270);
		}
	}
}
