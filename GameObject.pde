class GameObject
{
  // Game flags
  boolean gamePaused;
  
  // Position
  public float m_position_x;
  public float m_position_y;
  protected float m_startPosition_x;
  protected float m_startPosition_y;
  
  // Dimensions
  public float m_width;
  public float m_height;
  
  // Speed
  public float m_startSpeed;
  public float m_speed;
  private float m_freezeSpeed;
  
  // Default constructor
  public GameObject()
  {
  }
  
  // Constructor for single single GameObject parameter
  public void Update(GameObject g1)
  { 
  }
  
  // Constructor for multiple GameObject parameters
  public void Update(GameObject g1, GameObject g2)
  { 
  }
  
  // Utility method for movement
  public void Movement()
  {
  }
  
  // Utility method for drawing the object on the screen
  public void DrawObject()
  { 
  }
  
  // Utility method for toggle 'Pause' state of the object
  public void TogglePause()
  { 
    // Track speed of object when pausing
    if (!gamePaused)
    {
      this.m_freezeSpeed = this.m_speed;
    }
    
    // Toggle 'Paused' state
    gamePaused = !gamePaused;
    
    // Change speed of object based on 'Pause' state
    if (gamePaused)
    {
      this.m_speed = 0;
    }
    else
    {
      this.m_speed = this.m_freezeSpeed;
    }
  }
  
  // Utility method for resetting the object's position
  public void ResetPosition()
  {
    this.m_position_x = this.m_startPosition_x;
    this.m_position_y = this.m_startPosition_y;
  }
  
  // Reset the whole object
  public void Reset()
  {
    this.ResetPosition();
    this.gamePaused = false;
    this.m_speed = m_startSpeed;
  }
}
