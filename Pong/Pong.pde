/*
PONG CLONE

AUTHOR: BRYAN GARRY

SUMMARY: THIS IS MEANT TO BE A CLONE OF THE FAMOUS GAME PONG
*/

// Variables
Paddle p1Paddle;
Paddle p2Paddle;
Ball ball;

// Called to set up the game on the first frame
void setup() {
	size(1250, 750);
	background(115);
	rectMode(CENTER);
	p1Paddle = new Paddle(125, 400, 20, 100);
	p2Paddle = new Paddle(1125, 400, 20, 100);
	ball = new Ball(625, 400, 25);
}

// Continually updates the game each frame
void draw() {
	p1Paddle.show();
	p2Paddle.show();
	ball.show();
}
