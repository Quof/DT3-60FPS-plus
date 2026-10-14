if global.gamePaused=false
{
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      if x>192 {instance_create(x-224,y,oWhiteZone)}
      else
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        with oDSSR {instance_destroy()}
      }
      instance_destroy()
    }
}
