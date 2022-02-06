class Ball extends GameObject
{
  // General flags
  public float movement_x;
  public float movement_y;
  
  public Ball(float x, float y)
  {
    // General flags
    this.gamePaused = false;
    this.movement_x = -1; // Temporary set value (needs to be randomized in the future)
    this.movement_y = -1;
    
    // Position
    this.m_position_x = x;
    this.m_position_y = y;
    this.m_startPosition_x = x;
    this.m_startPosition_y = y;
    
    // Dimensions
    this.m_width = 30;
    this.m_height = 30;
    
    // Speed 
    this.m_startSpeed = 3;
    this.m_speed = 3;
  }
  
  // Update object state
  public void Update(Racket p1, Racket p2)
  {     
    this.Movement(p1, p2);
    
    this.DrawObject();
  }
  
  // Handle object movement
  public void Movement(Racket p1, Racket p2)
  {
    this.ChangeMovement(p1, p2);
    this.m_position_x += this.movement_x * this.m_speed;
    this.m_position_y += this.movement_y * this.m_speed;
  }
  
  // Handle object collision with screen borders - top and bottom
  public boolean CollisionWithBorder()
  {
    // Check collision with top border
    if (this.m_position_y <= 5 + (this.m_height / 2))
    {
      return true;
    }
    
    // Check collision with bottom border
    if (this.m_position_y >= 595 - (this.m_height / 2))
    {
      return true;
    }
    
    return false;
  }
  
  // Handle object collision with players
  public boolean CollisionWithPlayer(Racket p1, Racket p2)
  {
    // Collision with player 1
    if (this.m_position_x - (this.m_width / 2) <= (p1.m_position_x + p1.m_width) && this.movement_x == -1)
    {
      if (this.m_position_y - (this.m_height / 2) >= p1.m_position_y && this.m_position_y + (this.m_height / 2) <= p1.m_position_y + p1.m_height)
      {
        this.m_speed = 6;
        return true;
      }
    }
    
    // Collision with player 2
    if (this.m_position_x + (this.m_width / 2) >= p2.m_position_x && this.movement_x == 1)
    {
      if (this.m_position_y - (this.m_height / 2) >= p2.m_position_y && this.m_position_y + (this.m_height / 2) <= p2.m_position_y + p2.m_height)
      {
        this.m_speed = 6;
        return true;
      }      
    }
    
    return false;
  }
  
  // Change object movement based on collision
  private void ChangeMovement(Racket p1, Racket p2)
  {
    // Change direction when collision with border
    if (this.CollisionWithBorder())
    {
      this.movement_y *= -1;
    }
    
    // Change direction when collision with player
    if (this.CollisionWithPlayer(p1, p2))
    {
      this.movement_x *= -1;
    }
  }
  
  // Reset object position
  public void ResetPosition()
  {
    this.m_position_x = this.m_startPosition_x;
    this.m_position_y = this.m_startPosition_y;
    this.m_speed = 4;
  }
  
  // Draw the object on the screen
  public void DrawObject()
  {
    fill(255, 255, 255);
    ellipse(this.m_position_x, this.m_position_y, this.m_width, this.m_height);
  }
}
