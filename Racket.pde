class Racket extends GameObject
{
  // General flags
  public boolean cpuControlled;
  private int pNumber;
  
  public Racket(int playerNumber, float x, float y)
  {
    // General flags
    this.gamePaused = false;
    this.cpuControlled = false;
    this.pNumber = playerNumber;
    
    // Position
    this.m_position_x = x;
    this.m_position_y = y;
    this.m_startPosition_x = x;
    this.m_startPosition_y = y;
    
    // Dimensions
    this.m_width = 5;
    this.m_height = 100;
    
    // Speed
    this.m_startSpeed = 6;
    this.m_speed = 6;      
  }
  
  // Update object state
  public void Update(Ball ball)
  {
    // Determine whether this racket is CPU controlled
    if (this.pNumber == 2)
    {
      this.m_startSpeed = 5.4;
      this.m_speed = 5.4f;
      this.cpuControlled = true;
    }  
    
    this.Movement(ball);
        
    this.DrawObject();
  }
  
  // Handle object movement
  public void Movement(Ball ball)
  {
    // Handle movement using enemy AI
    if (this.cpuControlled)
    {
      this.CPU_Movement(ball);
    }
    
    // Handle movement using user input
    if (this.cpuControlled == false)
    {      
      this.PlayerMovement();
    }    
  }
  
  // Handle movement using user input
  private void PlayerMovement()
  {
    // Listener for user input - only works with wasd keys
    if (keyPressed)
    {
      switch (key)
      {
        case 'w':
          if (this.pNumber == 1)
          {
            this.MoveUp();  
          }
          break;
          
        case 's':
          if (this.pNumber == 1)
          {
            this.MoveDown();  
          }
          break;
      }
      
      // Listener for user input - only works with UP and DOWN arrow keys
      switch (keyCode)
      {
        case UP:
          this.MoveUp();
          break;
          
        case DOWN:
          this.MoveDown();
          break;
      }
    }
  }
  
  // Handle movement using enemy AI
  private void CPU_Movement(Ball ball)
  {        
    if (ball.m_position_x > 100 && ball.movement_x == 1)
    {      
      if (this.m_position_y + (this.m_height / 2) < ball.m_position_y)
      {
        this.MoveDown();
      }
      else
      {
        this.MoveUp();
      }
    }
  }
  
  // Make the object move up
  private void MoveUp()
  {
    if (this.CollisionWithTopBorder() == false)
    {
      this.m_position_y -= this.m_speed;
    }
  }
  
  // Make the object move down
  private void MoveDown()
  {
    if (this.CollisionWithBottomBorder() == false)
    {
      this.m_position_y += this.m_speed;
    }
  }
  
  // Handle collision of the object with the top border
  private boolean CollisionWithTopBorder()
  {
    if (this.m_position_y <= 5)
    {
      return true;
    }
    
    return false;
  }
  
  // Handle collision of the object with the bottom border
  private boolean CollisionWithBottomBorder()
  {
    if (this.m_position_y >= (595 - this.m_height))
    {
      return true;
    }
    
    return false;
  }
  
  // Draw the object on the screen
  public void DrawObject()
  {
    fill(255, 255, 255);
    rect(this.m_position_x, this.m_position_y, this.m_width, this.m_height);
  }
}
