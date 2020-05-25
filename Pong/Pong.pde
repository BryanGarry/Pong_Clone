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

	The integer serve is being used to determine which direction the ball should be served from, if it needs to even
	be served at all. The breakdown of what each number corresponds to will be listed below:

	0	:	No serve needed
	1	:	Serve player 1
	2	: 	Serve player 2

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

int p1PosX;
int p2PosX;
int startPosY;
int ballPosX;

Level level;

int gameState;
int gameVersion;
boolean roundStart;

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
  	int p1PosX = (int)(width * 0.1);
  	int p2PosX = (int)(width * 0.9);
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

	// Set the timer to a default time of 1 second
	timer = new Timer(1);

	// Set players scores to 0
	p1Score = 0;
	p2Score = 0;

	// Set the winning score
	winningScore = 1;

	// Initialize the random number generator
	rng = new Random();

	// Add buttons to button list for start menu
	buttonList.add(new Button("PLAY (1P)", (int)(width * 0.5), (int)(height * 0.4), (int)(width * 0.2), (int)(height * 0.08), 0));
	buttonList.add(new Button("PLAY (2P)", (int)(width * 0.5), (int)(height * 0.5), (int)(width * 0.2), (int)(height * 0.08), 1));
	buttonList.add(new Button("OPTIONS", width / 2, (int)(height * 0.6), (int)(width * 0.2), (int)(height * 0.08), 2));
	buttonList.add(new Button("HIGHSCORE", (int)(width * 0.85), (int)(height * 0.9), (int)(width * 0.2), (int)(height * 0.08), 3));
	buttonList.add(new Button("CREDITS", (int)(width * 0.15), (int)(height * 0.9), (int)(width * 0.2), (int)(height * 0.08), 4));
	buttonList.add(new Button("EXIT", (int)(width * 0.5), (int)(height * 0.7), (int)(width * 0.2), (int)(height * 0.08), 5));

}

// Continually updates the game each frame
void draw() {
 	//background(115); // Background is drawn after every frame to get the window updated

 	if (gameState == 0) {
 		displayMenu();
 	} else if (gameState == 1) {
 		if (gameVersion == 1) {
 			if (triggerServe) {
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
 			} else {
 				playGame();
 				checkForWinner();
 			}
 		}
 	} else if (gameState == 2) {

 	}

}

// Logic to call to simply play the game
void playGame() {
	displayGame();
	ball.move();
	paddleMovement();
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

// Function that checks if a player has scored a point and then resets the game to begin another round
void checkPointScored() {
	// Check if player 1 scored a point on player 2
	if (ball._xCord + ball._radius / 2 > p2Paddle._xCord + p2Paddle._width / 3) {
		p1Score++;
		serve = 2;
		resetRound();
	}

	// Check if player 2 scored a point on player 1
	if (ball._xCord - ball._radius / 2 < p1Paddle._xCord + p1Paddle._width / 3) {
		p2Score++;
		serve = 1;
		resetRound();
	}
}

// Function that draws the players scores in the heading
void drawPlayerScores() {
	textSize(50);
	text("Player 1:", (int)(width * 0.2), (int)(height * 0.04));
	text(p1Score, (int)(width * 0.2), (int)(height * 0.12));
	text("Player 2:", (int)(width * 0.8), (int)(height * 0.04));
	text(p2Score, (int)(width * 0.8), (int)(height * 0.12));
}

// Function that resets are the necessary values at the end of the round
void resetRound() {
	triggerServe = true;
	ball._xCord = (int)(width * 0.5);
	ball._yCord = (int)(height * 0.55);
	p1Paddle._yCord = (int)(height * 0.55);
	p2Paddle._yCord = (int)(height * 0.55);
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