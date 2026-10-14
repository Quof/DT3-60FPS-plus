if global.gamePaused=false
{
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      oPlayer1.dashEnergy=9999
      instance_destroy()
    }
}
