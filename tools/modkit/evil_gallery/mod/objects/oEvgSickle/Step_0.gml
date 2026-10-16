//Evil Boss Gallery: the sickle's life: circling above Evil Death (prog 0), aiming (1), flying (2)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if prog=0
  {
    ang+=6*gDeltaTime
    if instance_exists(owner) {cx=owner.x}
    x=cx+lengthdir_x(orbitR,ang)
    y=cy+lengthdir_y(orbitR*0.6,ang)
    image_angle+=12*gDeltaTime
    if t>=launchT
    {
      prog=1; t=0
      aimDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      playSound(global.snd_DeathSlash,0,0.7,44100)
    }
  }
  else if prog=1
  {
    image_angle+=30*gDeltaTime
    if t>=12
    {
      prog=2; t=0
      playSound(global.snd_OrbThrow,0,0.85,30000)
    }
  }
  else
  {
    image_angle+=20*gDeltaTime
    x+=lengthdir_x(spd,aimDir)*gDeltaTime
    y+=lengthdir_y(spd,aimDir)*gDeltaTime
    if place_meeting(x,y,oSolid)
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
    else if x<-48 or x>room_width+48 or y<-64 or y>room_height+48 {instance_destroy()}
  }
  enemyStepEvent()
}
