if global.gamePaused=false
{
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      oPlayer1.doubleJumpCheck=1
      if global.activeCharacter=2 {oPlayer1.mechFuel=25}
      instance_destroy()
    }
}
