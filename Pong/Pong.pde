/*
PONG CLONE

AUTHOR: BRYAN GARRY

SUMMARY: THIS IS MEANT TO BE A CLONE OF THE FAMOUS GAME PONG
*/

import java.util.*;

/*

 	The integer gameState is being used to deterimine which state the game is currently in. The breakdown of what
 	each state number corresponds to will be listed below:

 	0	:	Game Start (display start menu, instructions, and # of players)
 	1	:	Game Run (plays the game as usual until a player wins)
 	2	:	Game End (display winner, instructions for quitting or restarting the game)

 	The integer gameVersion is being used to determine which version the game is currently in. The breakdown of what
 	each version number corresponds to will be listed below:

 	0	:	1 Player Game
	1	:	2 Player Game
	2	:	Options
	3	:	Highscore
	4	:	Credits
	5	:	Exit
	6	:	CPU only game

	The integer serve is being used to determine which direction the ball should be served from, if it needs to even
	be served at all. The breakdown of what each number corresponds to will be listed below:

	0	:	No serve needed
	1	:	Serve player 1
	2	: 	Serve player 2

	The integer playerHitting is being used to determine which player is supposed to hit the ball next, this is 
	meant to prevent double hits from happening in case the ball is moving at too steep and angle

	0	:	No player hitting
	1	:	Player 1 hitting
	2	:	Player 2 hitting

 	*/

// Variables
Paddle p1Paddle;
boolean p1UP;
boolean p1DOWN;
int p1Score;

Paddle p2Paddle;
boolean p2UP; 
boolean p2DOWN;
int p2Score;

Ball ball;
int serve;
boolean triggerServe;
float maxBallSpeed;

int p1PosX;
int p2PosX;
int startPosY;
int ballPosX;

Level level;
int playerHitting;

boolean restartGame;
boolean quitGame;

int gameState;
int gameVersion;
boolean roundStart;

int volleyCount;

Timer timer;

int winningScore;

Random rng;

ArrayList<Button> buttonList = new ArrayList<Button>();

// Called to set up the game on the first frame
void setup() {
	// Set up background and window size
	size(1250, 750);
	background(115);
	rectMode(CENTER);

	// Define the position of the players and ball
  	int p1PosX = (int)(width * 0.2);
  	int p2PosX = (int)(width * 0.8);
  	int startPosY = (int)(height * 0.55);
  	int ballPosX = (int)(width * 0.5);

  	// Create paddles, ball, and level objects
	p1Paddle = new Paddle(p1PosX, startPosY, 20, 100);
	p2Paddle = new Paddle(p2PosX, startPosY, 20, 100);
	ball = new Ball(ballPosX, startPosY, 25);
	level = new Level();

	// Set game state equal to 0 to load the menu UI
	gameState = 0;

	// Set the default serve to the player 1
	serve = 1;
	triggerServe = true;

	// Set the default player to hit the ball to player 1
	playerHitting = 1;

	// Set the maxBallSpeed
	maxBallSpeed = 6;

	// Set the volley count to 0
	volleyCount = 0;

	// Set the timer to a default time of 1 second
	timer = new Timer(1);

	// Set players scores to 0
	p1Score = 0;
	p2Score = 0;

	// Set the winning score
	winningScore = 3;

	// Initialize the random number generator
	rng = new Random();

	// Set frame rate so game runs smoothly
	frameRate(120);

	// Add buttons to button list for start menu
	buttonList.add(new Button("PLAY (1P)", (int)(width * 0.5), (int)(height * 0.4), (int)(width * 0.2), (int)(height * 0.08), 0));
	buttonList.add(new Button("PLAY (2P)", (int)(width * 0.5), (int)(height * 0.5), (int)(width * 0.2), (int)(height * 0.08), 1));
	buttonList.add(new Button("OPTIONS", (int)(width * 0.5), (int)(height * 0.7), (int)(width * 0.2), (int)(height * 0.08), 2));
	buttonList.add(new Button("HIGHSCORE", (int)(width * 0.85), (int)(height * 0.9), (int)(width * 0.2), (int)(height * 0.08), 3));
	buttonList.add(new Button("CREDITS", (int)(width * 0.15), (int)(height * 0.9), (int)(width * 0.2), (int)(height * 0.08), 4));
	buttonList.add(new Button("EXIT", (int)(width * 0.5), (int)(height * 0.8), (int)(width * 0.2), (int)(height * 0.08), 5));
	buttonList.add(new Button("CPU BATTLE", (int)(width * 0.5), (int)(height * 0.6), (int)(width * 0.2), (int)(height * 0.08), 6));

}

// Continually updates the game each frame
void draw() {
 	//background(115); // Background is drawn after every frame to get the window updated

 	if (gameState == 0) {
 		displayMenu();
 	} else if (gameState == 1) {
 		if (gameVersion == 0) {
 			if (triggerServe) {
 				displayCountDown();
 			} else {
 				playGame1P();
 				checkForWinner();
 			}
 		} else if (gameVersion == 1) {
 			if (triggerServe) {
 				displayCountDown();
 			} else {
 				playGame2P();
 				checkForWinner();
 			}
 		} else if (gameVersion == 5) {
 			exit();
 		} else if (gameVersion == 6) {
 			if (triggerServe) {
 				displayCountDown();
 			} else {
 				playGame0P();
 				checkForWinner();
 			}
 		}
 	} else if (gameState == 2) {
 		displayEndgame();
 	}

}

// Logic to play a 0 player game
void playGame0P() {
	displayGame();
	ball.move();
	paddleMovement0P();
	detectCollision();
	checkPointScored();
}

// Logic to play a 1 player game
void playGame1P() {
	displayGame();
	ball.move();
	paddleMovement1P();
	detectCollision();
	checkPointScored();
}

// Logic to play a 2 player game
void playGame2P() {
	displayGame();
	ball.move();
	paddleMovement2P();
	detectCollision();
	checkPointScored();
}

// Logic to display the start menu of the game
void displayMenu() {
	background(115);
	noStroke();
	fill(255);
	textAlign(CENTER, CENTER);
	textSize(height / 5);
	text("PONG", width / 2, height / 6);
	for (int i = 0; i < buttonList.size(); i++) {
		buttonList.get(i).display();
	}
	if (mousePressed) {
		for (int i = 0; i < buttonList.size(); i++) {
			if (buttonList.get(i).checkPressed()) {
				gameVersion = buttonList.get(i)._instruction;
				System.out.println("Version" + gameVersion);
				gameState = 1;
				System.out.println("State" + gameState);
				return;
			}
		}
	}
}

// Function that takes a message and a coordinate and creates a button out of it
void displayButton(String message, int x, int y, int w, int h) {
	fill(255);
	rect(x, y, w, h);
	fill(115);
	textSize(height / 20);
	text(message, x, y);
}

// Function that displays the objects in the game in the correct order
void displayGame() {
	background(115);
	drawPlayerScores();
	p1Paddle.show();
	p2Paddle.show();
	ball.show();
	level.show();
}

// Function that plays the countdown at the start of a new game
void displayCountDown() {
	displayGame(); // Display game

	// Get serve direction and set timer for countdown as well as the starting positions of the paddles and balls
	if (serve != 0) {
		startRound();
		timer._time = 1.0;
	}

	// If timer is still running, proceed to display the countdown, once timer ends, switch to regular gameplay
	if (timer._time > 0) {
		textSize(150);
		fill(0);
		if (timer._time > 0.67) {
			text("3", (int)(width * 0.33), (int)(height * 0.35));
		} else if (timer._time > 0.33) {
			text("2", (int)(width * 0.5), (int)(height * 0.35));
		} else {
			text("1", (int)(width * 0.67), (int)(height * 0.35));
		}
		timer.countDown();
	} else {
		triggerServe = false;
	}
}

// Function that displays the end game dialogue
void displayEndgame() {
	// Display the option to restart that game
	textSize(50);
	text("PRESS 'r' TO RESTART", (int)(width * 0.5), (int)(height * 0.65));
	text("PRESS 'q' TO RESTART", (int)(width * 0.5), (int)(height * 0.75));
	checkForRestart();
	checkForQuit();
}

// Logic to move the player paddles
void paddleMovement0P() {
	/*
	The key codes for player movement are as follows:
	0	:	remain where the paddle is at a.k.a. no movement
	-1	:	move upwards a.k.a. in the negative y-direction
	1	:	move downwards a.k.a. in the positive y-direction
	*/

	if (p1Paddle._yCord > ball._yCord && p1Paddle._yCord - p1Paddle._height / 2 > level._yCordTopRail + level._railHeight / 2) {
		p1Paddle.move(-1);
	}
	if (p1Paddle._yCord < ball._yCord && p1Paddle._yCord + p1Paddle._height / 2 < level._yCordBottomRail - level._railHeight / 2) {
		p1Paddle.move(1);
	}
	if (p2Paddle._yCord > ball._yCord && p2Paddle._yCord - p2Paddle._height / 2 > level._yCordTopRail + level._railHeight / 2) {
		p2Paddle.move(-1);
	}
	if (p2Paddle._yCord < ball._yCord && p2Paddle._yCord + p2Paddle._height / 2 < level._yCordBottomRail - level._railHeight / 2) {
		p2Paddle.move(1);
	}
}

// Logic to move the player paddles
void paddleMovement1P() {
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
	if (p2Paddle._yCord > ball._yCord && p2Paddle._yCord - p2Paddle._height / 2 > level._yCordTopRail + level._railHeight / 2) {
		p2Paddle.move(-1);
	}
	if (p2Paddle._yCord < ball._yCord && p2Paddle._yCord + p2Paddle._height / 2 < level._yCordBottomRail - level._railHeight / 2) {
		p2Paddle.move(1);
	}
}

// Logic to move the player paddles
void paddleMovement2P() {
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
		// If the ball is going upwards to the left, that means it is between 180-270. The ball reflected must be between 90-180.
		// If the ball is going upwards to the right, that means it is between 270-360. The ball reflected must be between 0-90.
		if (ball._angleDeg > 180 && ball._angleDeg < 270) {
			ball._angleDeg = (270 - ball._angleDeg) + 90;
		} else if (ball._angleDeg > 270 && ball._angleDeg < 360) {
			ball._angleDeg = 360 - ball._angleDeg;
		} else {
			ball._angleDeg = (270 - ball._angleDeg) + 90;
		}
		ball.normalizeAngle();
	}

	// Check bottom rail
	if (ball._yCord + ball._radius / 2 >= level._yCordBottomRail - level._railHeight / 2) {
		// If the ball is going downwards to the left, that means it is between 90-180. The ball reflected must be between 180-270.
		// If the ball is going downwards to the right, that means it is between 0-90. The ball reflected must be between 270-360.
		if (ball._angleDeg > 90 && ball._angleDeg < 180) {
			ball._angleDeg = 270 - (ball._angleDeg - 90);
		} else if (ball._angleDeg > 270 && ball._angleDeg < 360) {
			ball._angleDeg = 360 - ball._angleDeg;
		} else {
			ball._angleDeg = 270 - (ball._angleDeg - 90);
		}
		ball.normalizeAngle();
	}


	// Player 1 paddle collision detection and reflection
	if (ball._xCord - ball._radius / 2 <= p1Paddle._xCord + p1Paddle._width / 2 && playerHitting == 1) {
		if (ball._yCord > p1Paddle._yCord - p1Paddle._height / 2 && ball._yCord < p1Paddle._yCord + p1Paddle._height / 2) {
			// Find the difference between the paddle center and the ball center and change the angle of the ball accordingly.
			// Add this raw value to the newly calculated angle and then check to make sure the angle is still within the correct bounds.
			int yDif = (int) (ball._yCord - p1Paddle._yCord);
			int deltaAngle = (int)(yDif * 0.8);

			System.out.println("------New Collision------");
			System.out.println("Incoming Angle: " + ball._angleDeg);
			System.out.println("P1 DeltaAngle: " + deltaAngle);

			// If the ball is going upwards, that means the angle is between 180-270. The ball reflected must be between 270-360.
			// If the ball is going downwards, that means the angle is between 90-180. The ball reflected must be between 0-90.
			if (ball._angleDeg > 180 && ball._angleDeg < 270) {
				ball._angleDeg = 270 + (270 - ball._angleDeg) + deltaAngle;
			} else if (ball._angleDeg > 90 && ball._angleDeg < 180) {
				ball._angleDeg = 90 - (ball._angleDeg - 90) + deltaAngle;
			} else {
				ball._angleDeg = ball._angleDeg + 180 + deltaAngle;
			}
			ball.normalizeAngle();

			// Check that the ball is within the bounds of the acceptable return angles: 0 - 90 and 270 - 360
			if (ball._angleDeg < 285 && ball._angleDeg > 180) {
				ball._angleDeg = -75;
			} else if (ball._angleDeg > 75 && ball._angleDeg < 180) {
				ball._angleDeg = 75;
			}

			// Increase volley count
			volleyCount++;
			checkVolleyCount();
			playerHitting = 2;

			System.out.println("Outgoing Angle: " + ball._angleDeg);
		}
	}

	// Player 2 paddle collison detection and reflection
	if (ball._xCord + ball._radius / 2 >= p2Paddle._xCord - p2Paddle._width / 2 && playerHitting == 2) {
		if (ball._yCord > p2Paddle._yCord - p2Paddle._height / 2 && ball._yCord < p2Paddle._yCord + p2Paddle._height / 2) {
			// Find the difference between the paddle center and the ball center and change the angle of the ball accordingly.
			// Add this raw value to the newly calculated angle and then check to make sure the angle is still within the correct bounds.
			int yDif = (int) (ball._yCord - p2Paddle._yCord);
			int deltaAngle = (int)(yDif * 0.8);

			System.out.println("------New Collision------");
			System.out.println("Incoming Angle: " + ball._angleDeg);
			System.out.println("P2 DeltaAngle: " + deltaAngle);

			// If the ball is going upwards, that means the angle is between 270-360. The ball reflected must be between 180-270.
			// If the ball is going downwards, that means the angle is between 0-90. The ball reflected must be between 90-180.
			if (ball._angleDeg > 270 && ball._angleDeg < 360) {
				ball._angleDeg = 270 - (ball._angleDeg - 270) - deltaAngle;
			} else if (ball._angleDeg > 0 && ball._angleDeg < 90) {
				ball._angleDeg = 90 + (90 - ball._angleDeg) - deltaAngle;
			} else {
				ball._angleDeg = ball._angleDeg + 180;
			}
			ball.normalizeAngle();

			// Check that the ball is within the bounds of the acceptable return angles: 115 - 255
			if (ball._angleDeg < 115) {
				ball._angleDeg = 115;
			} else if (ball._angleDeg > 255) {
				ball._angleDeg = 255;
			}

			// Increase volley count
			volleyCount++;
			checkVolleyCount();
			playerHitting = 1;

			System.out.println("Outgoing Angle: " + ball._angleDeg);
		}
	}

}

// Function that checks if a player has scored a point and then resets the game to begin another round
void checkPointScored() {
	// Check if player 1 scored a point on player 2
	// if (ball._xCord + ball._radius / 2 > p2Paddle._xCord + p2Paddle._width / 3) {
	if (ball._xCord + ball._radius / 2 > p2Paddle._xCord) {
		p1Score++;
		serve = 2;
		playerHitting = 2;
		resetRound();
	}

	// Check if player 2 scored a point on player 1
	// if (ball._xCord - ball._radius / 2 < p1Paddle._xCord + p1Paddle._width / 3) {
	if (ball._xCord - ball._radius / 2 < p1Paddle._xCord) {
		p2Score++;
		serve = 1;
		playerHitting = 1;
		resetRound();
	}
}

// Function that checks the volley count and increases the ball speed depending on the number of volleys
void checkVolleyCount() {
	if (ball._velocity < maxBallSpeed) {
		if (volleyCount == 3) {
			ball._velocity += 0.5;
		} else if (volleyCount == 7) {
			ball._velocity += 1.0;
		} else if (volleyCount == 15) {
			ball._velocity += 1.0;
		} else {
			ball._velocity += 0.1;
		}
	}
}

// Function that draws the players scores in the heading
void drawPlayerScores() {
	textSize(50);
	text("Player 1:", (int)(width * 0.2), (int)(height * 0.04));
	text(p1Score, (int)(width * 0.2), (int)(height * 0.12));
	text("Player 2:", (int)(width * 0.8), (int)(height * 0.04));
	text(p2Score, (int)(width * 0.8), (int)(height * 0.12));
	text("Volley:", (int)(width * 0.5), (int)(height * 0.04));
	text(volleyCount, (int)(width * 0.5), (int)(height * 0.12));
}

// Function that resets are the necessary values at the end of the round
void resetRound() {
	triggerServe = true;
	ball._xCord = (int)(width * 0.5);
	ball._yCord = (int)(height * 0.55);
	p1Paddle._yCord = (int)(height * 0.55);
	p2Paddle._yCord = (int)(height * 0.55);
	volleyCount = 0;
	ball._velocity = 2;
}

// Function called to serve the ball in a given direction based on the serve int state
void startRound() {
	// Determine the direction of the serve
	if (serve == 1) {
		// Serve the ball to player 1
		float offset = (float)rng.nextGaussian()*15+0;
		ball._angleDeg = 180.0 + offset;
		serve = 0;
	} else if (serve == 2) {
		// Serve the ball to player 2
		float offset = (float)rng.nextGaussian()*15+0;
		ball._angleDeg = 0.0 + offset;
		serve = 0;
	}

	/*
	---NOTE---
	IT MIGHT BE WORTH LOOKING INTO SHIFTING THE MEAN OF THE GAUSIAN UP OR DOWN
	IN ORDER TO GIVE MORE VARIETY TO THE SERVES. I COULD ALSO LOOK INTO SHIFTING
	THE STD DEV AND JUST CAPPING THE MAX AMOUNT OF OFFSET THE SERVE COULD HAVE
	*/
}

// Function that checks to see if a player won the game
void checkForWinner() {
	if (p1Score == winningScore) {
		resetRound();
		displayGame();
		textSize(150);
 		fill(0);
		text("PLAYER 1 WINS", (int)(width * 0.5), (int)(height * 0.35));
		gameState = 2;
	}
	if (p2Score == winningScore) {
		resetRound();
		displayGame();
		textSize(150);
 		fill(0);
		text("PLAYER 2 WINS", (int)(width * 0.5), (int)(height * 0.35));
		gameState = 2;
	}
}

// Function that checks to see if the user wants to restart the game
void checkForRestart() {
	if (restartGame == true) {
		reset();
	}
}

// Function that checks to see if the user wants to quit the game
void checkForQuit() {
	if (quitGame == true) {
		exit();
	}
}

// Function that resets all the initial values from setup
void reset() {
	int p1PosX = (int)(width * 0.2);
  	int p2PosX = (int)(width * 0.8);
  	int startPosY = (int)(height * 0.55);
  	int ballPosX = (int)(width * 0.5);

  	// Create paddles, ball, and level objects
	p1Paddle = new Paddle(p1PosX, startPosY, 20, 100);
	p2Paddle = new Paddle(p2PosX, startPosY, 20, 100);
	ball = new Ball(ballPosX, startPosY, 25);
	level = new Level();

	// Set game state equal to 0 to load the menu UI
	gameState = 0;

	// Set the default serve to the player 1
	serve = 1;
	triggerServe = true;
	playerHitting = 1;

	// Set the volley count to 0
	volleyCount = 0;

	// Set players scores to 0
	p1Score = 0;
	p2Score = 0;

	// Set the winning score
	winningScore = 3;
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
	if (key == 'r') {
		restartGame = true;
	}
	if (key == 'q') {
		quitGame = true;
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
	if (key == 'r') {
		restartGame = false;
	}
	if (key == 'q') {
		quitGame = false;
	}
}
