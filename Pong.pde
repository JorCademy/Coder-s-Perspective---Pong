// General flags
boolean showMainMenu;
boolean gamePaused;
boolean gameOver;

// Font
PFont retroScore;
PFont retroPaused;
PFont retroGameOver;
PFont retroSmall;
PFont retroTitle;
PFont retroSubtitle;
PFont retroMenuItem;

// Player scores
int scoreP1;
int scoreP2;

// Game Objects
Racket p1;
Racket p2;
Ball ball;

void setup()
{
  size(800, 600);
  
  // General flags
  showMainMenu = true;
  gamePaused = false;
  gameOver = false;
  
  // Font
  retroScore = createFont("ka1.ttf", 25);
  retroPaused = createFont("ka1.ttf", 40);
  retroGameOver = createFont("ka1.ttf", 50);
  retroSmall = createFont("ka1.ttf", 20);
  retroTitle = createFont("ka1.ttf", 100);
  retroSubtitle = createFont("ka1.ttf", 25);
  retroMenuItem = createFont("ka1.ttf", 30);
  
  // Player scores
  scoreP1 = 0;
  scoreP2 = 0;
  
  // Game Objects
  this.p1 = new Racket(1, 30, 250);
  this.p2 = new Racket(2, (800 - 30), 250);
  this.p2.cpuControlled = false;
  this.ball = new Ball(400, 300);
}

void draw()
{  
  // Paint the backdrop black
  background(0, 0, 0);
  
  // Determine whether to show the Main Menu or let the game play
  if (showMainMenu)
  {
    ShowMainMenu();
  }
  else
  {
    PlayGame();
  }
}

// Show the Main Menu
void ShowMainMenu()
{  
  // Top border
  noStroke();
  fill(255, 255, 255);
  rect(0, 0, 800, 5);
  
  // Bottom border
  noStroke();
  fill(255, 255, 255);
  rect(0, 595, 800, 5);
  
  // Title text
  textFont(retroTitle);
  text("PONG", 210, 200);
  
  // Subtitle text
  textFont(retroSubtitle);
  text("BY  JORCADEMY", 210, 250);
  
  // PLAY - Menu item
  textFont(retroMenuItem);
  text("PLAY  1P  -  SPACE", 200, 400);
  
  // QUIT - Menu item
  textFont(retroMenuItem);
  text("QUIT  -  Q", 284, 460);
  
  // Listen for user input - and act accordingly
  if (keyPressed)
  {
    if (key == ' ')
    {
      showMainMenu = false;
    }
    else if (key == 'q')
    {
      exit();
    }
  }
}

// Play state
void PlayGame()
{
  // Draw playing field
  DrawField();
  
  // Checks whether game is paused/finished
  this.CheckGameState();
  
  // Update game objects
  if (!gameOver)
  {
    p1.Update(this.ball);
    p2.Update(this.ball);
    ball.Update(this.p1, this.p2);
  }
  
  // Draw the current score
  DrawScore();
  
  // Draw 'Paused' when paused
  if (gamePaused)
  {
    textFont(retroPaused);
    text("Paused", 300, 300);
    
    textFont(retroSmall);
    text("BACK  TO  MAIN  MENU  -  M", 250, 350);
    
    if (keyPressed)
    {
      if (key == 'm')
      {
        ResetGame();
      }
    }
  }
}

// Update score based on ball position
void UpdateScore()
{
  // Acts when ball is out of play - Left side
  if (ball.m_position_x < 0 - (ball.m_width / 2))
  {
    ball.ResetPosition();
    this.scoreP2++;
  }
  
  // Acts when ball is out of play - right side
  if (ball.m_position_x > 800 + (ball.m_width / 2))
  {
    ball.ResetPosition();
    this.scoreP1++;
  }
}

// Draw updated scores
void DrawScore()
{
  this.UpdateScore();
  
  // Score player 1
  textFont(retroScore);
  text(scoreP1, 350, 40);
  
  // Score player 2
  textFont(retroScore);
  text(scoreP2, 430, 40);
}

// Check whether game is paused/finished
void CheckGameState()
{
  // Toggle 'Paused' state when needed
  if (keyPressed)
  {
    if (key == BACKSPACE)
    {
      if (!this.gamePaused)
      {
        PauseGame();
      }
    }
    else if (key == ENTER)
    {
      if (this.gamePaused)
      {
        ContinueGame();
      }
    }
  }
  
  // Activate 'Game Over' state when needed
  if (scoreP1 == 5 || scoreP2 == 5)
  {    
    this.GameOver();
  }
}

// Pause the game
void PauseGame()
{
  this.gamePaused = true;
  
  this.p1.TogglePause();
  this.p2.TogglePause();
  this.ball.TogglePause();  
}

// Continue from pause
void ContinueGame()
{
  this.gamePaused = false;
  
  this.p1.TogglePause();
  this.p2.TogglePause();
  this.ball.TogglePause();
}

// Reset the whole game
void ResetGame()
{
  // General flags
  showMainMenu = true;
  gamePaused = false;
  gameOver = false;
  
  // Reset position of all objects
  p1.Reset();
  p2.Reset();
  ball.Reset();
  
  // Player scores
  scoreP1 = 0;
  scoreP2 = 0;
}

// Handle 'Game Over' state
void GameOver()
{
  gameOver = true;

  // Paint backdrop black
  background(0, 0, 0);
  
  // Top border
  noStroke();
  fill(255, 255, 255);
  rect(0, 0, 800, 5);
  
  // Bottom border
  noStroke();
  fill(255, 255, 255);
  rect(0, 595, 800, 5);

  // Show right Game Over message - based on score
  if (scoreP1 == 5)
  {
    textFont(retroGameOver);
    text("P1 has won!", 210, 300);
  }
  
  if (scoreP2 == 5)
  {
    textFont(retroGameOver);
    text("P2 has won!", 200, 300);
  }
  
  // Continuation message
  textFont(retroSmall);
  text("Continue - C", 320, 360);
  
  // Listen for user input - go back to Main Menu
  if (keyPressed)
  {
    if (key == 'c')
    {
      ResetGame();
    }
  }
}

// Draw the playing field
void DrawField()
{
  // Top border
  noStroke();
  fill(255, 255, 255);
  rect(0, 0, 800, 5);
  
  // Bottom border
  noStroke();
  fill(255, 255, 255);
  rect(0, 595, 800, 5);
  
  // Middle border
  noStroke();
  fill(255, 255, 255);
  rect(398.5, 0, 5, 600);
}
