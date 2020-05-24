/*
PONG CLONE

AUTHOR: BRYAN GARRY

SUMMARY: THIS IS MEANT TO BE A CLONE OF THE FAMOUS GAME PONG
*/

// Variables
Paddle p1Paddle;
boolean p1UP;
boolean p1DOWN;
Paddle p2Paddle;
boolean p2UP; 
boolean p2DOWN;
Ball ball;
Level level;

// Called to set up the game on the first frame
void setup() {
	size(1250, 750);
	background(115);
	rectMode(CENTER);
	fill(0);
	textAlign(CENTER, CENTER);
	textSize((width+height)/30);
	text("WELCOME TO PONG", width / 2, height / 10);

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

	paddleMovement();

	detectCollision();

	text("WELCOME TO PONG", width / 2, height / 11);
}

// Logic to move the player paddles
void paddleMovement() {
	/*
	The key codes for player movement are as follows:
	0	:	remain where the paddle is at a.k.a. no movement
	-1	:	move upwards a.k.a. in the negative y-direction
	1	:	move downwards a.k.a. in the positive y-direction
	*/

	if (p1UP == true && p1Paddle._yCord - p1Paddle._height / 2 > level._yCordTopRail + level._railHeight / 2) {
		p1Paddle.move(-1);
	}
	if (p1DOWN == true && p1Paddle._yCord + p1Paddle._height / 2 < level._yCordBottomRail - level._railHeight / 2) {
		p1Paddle.move(1);
	}
	if (p2UP == true && p2Paddle._yCord - p2Paddle._height / 2 > level._yCordTopRail + level._railHeight / 2) {
		p2Paddle.move(-1);
	}
	if (p2DOWN == true && p2Paddle._yCord + p2Paddle._height / 2 < level._yCordBottomRail - level._railHeight / 2) {
		p2Paddle.move(1);
	}
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

	// Check bottom rail
	if (ball._yCord + ball._radius / 2 >= level._yCordBottomRail - level._railHeight / 2) {
		// Check to see which direction the ball is headed and flip accordingly
		if (ball._angleDeg == 90) {
			ball._angleDeg = 270;
		} else {
			ball._angleDeg = 270 - (ball._angleDeg - 90);
		}
	}

	// Check player 1 paddle
	if (ball._xCord - ball._radius / 2 <= p1Paddle._xCord + p1Paddle._width / 2) {
		if (ball._yCord > p1Paddle._yCord - p1Paddle._height / 2 && ball._yCord < p1Paddle._yCord + p1Paddle._height / 2) {
			// Check to see which direction the ball is headed and flip accordingly
			if (ball._angleDeg == 180) {
				ball._angleDeg = 0;
			} else if (ball._angleDeg < 180) {
				ball._angleDeg = 0 - (ball._angleDeg - 180);
			} else {
				ball._angleDeg = 360 - (ball._angleDeg - 180);
			}
		}
	}

	// Check player 2 paddle
	if (ball._xCord + ball._radius / 2 >= p2Paddle._xCord - p2Paddle._width / 2) {
		if (ball._yCord > p2Paddle._yCord - p2Paddle._height / 2 && ball._yCord < p2Paddle._yCord + p2Paddle._height / 2) {
			// Check to see which direction the ball is headed and flip accordingly
			if (ball._angleDeg == 0) {
				ball._angleDeg = 180;
			} else if (ball._angleDeg < 360 && ball._angleDeg > 270) {
				ball._angleDeg = 180 - (ball._angleDeg - 360);
			} else {
				ball._angleDeg = 180 - (ball._angleDeg - 0);
			}
		}
	}
}

public void keyPressed() {
	if (key == 'w') {
		p1UP = true;
	}
	if (key == 's') {
		p1DOWN = true;
	}
	if (key == 'o') {
		p2UP = true;
	}
	if (key == 'l') {
		p2DOWN = true;
	}
}

public void keyReleased() {
	if (key == 'w') {
		p1UP = false;
	}
	if (key == 's') {
		p1DOWN = false;
	}
	if (key == 'o') {
		p2UP = false;
	}
	if (key == 'l') {
		p2DOWN = false;
	}
}