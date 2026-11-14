//Evil Boss Gallery: the bat's flight (see Create); stomped (life 0), a puff and gone (her own bats' end, without counting
//them: the game's bats count down Cackletta's myBats)
if global.gamePaused=false
{
  if life>0
  {
    x+=lengthdir_x(spd,dir)*gDeltaTime
    y+=lengthdir_y(spd,dir)*gDeltaTime
    if lengthdir_x(1,dir)<0 {image_xscale=-1}
    else {image_xscale=1}
    if x<240 or x>720 or y<-32 or y>384 {instance_destroy()}
  }
  else
  {
    var tEfCir;
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    instance_destroy()
  }
  enemyStepEvent()
}
