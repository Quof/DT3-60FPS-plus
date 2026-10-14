if global.gamePaused=false
{
  if oAquaSerpent.life>0
  {
    if oAquaSerpent.movePath!=2
    {
      if oAquaSerpent.movePath=1
        fireTime+=(1+oAquaSerpent.bossProgress)*gDeltaTime
      else if oAquaSerpent.movePath=6
        fireTime+=0.5*gDeltaTime
      else
        fireTime+=1*gDeltaTime
    }

    if fireTime>=fireDelay and fireTime<=fireDelay+39
      image_blend=c_orange
    else if fireTime>=fireDelay+40 and fireTime<=fireDelay+79
      image_blend=c_red
    else if fireTime>=fireDelay+80
    {
      playSound(global.snd_Fireball,0,0.8,28000+random(8000))
      var tFire,tDir;
      tDir=player_sprite_center()
      tFire=instance_create(x,y,oPassBullet)
      tFire.sprite_index=sWolfHeadShot; tFire._direction=tDir
      tFire.atkPower=oAquaSerpent.atkPower-1+1; tFire.bulletSpeed=4; tFire.decayTime=-100 //spsp
      if true        //spsp
      {
        tFire.image_xscale=2.5; tFire.image_yscale=2.5
      }

      image_blend=c_white
      fireTime=0
    }
    if oAquaSerpent.movePath=2
      image_blend=c_white
  }

  if oAquaSerpent.moveBehavior=1
  {
    if bodySeg=0 //To head
    {
      if point_distance(x,y,oAquaSerpent.x,oAquaSerpent.y)>4+(oAquaSerpent.moveSpd/2)
      {
        direction=point_direction(x,y,oAquaSerpent.x,oAquaSerpent.y)
        speed=oAquaSerpent.moveSpd
      }
      else if point_distance(x,y,oAquaSerpent.x,oAquaSerpent.y)>(4+(oAquaSerpent.moveSpd/2))*1.2
      {
        direction=point_direction(x,y,oAquaSerpent.x,oAquaSerpent.y)
        speed=oAquaSerpent.moveSpd*1.25
      }
      else
        speed=0
    }
    else //To next body part
    {
      if point_distance(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)>8+(oAquaSerpent.moveSpd/1.25)
      {
        direction=point_direction(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)
        speed=oAquaSerpent.moveSpd
      }
      else if point_distance(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)>(8+(oAquaSerpent.moveSpd/1.25))*1.2
      {
        direction=point_direction(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)
        speed=oAquaSerpent.moveSpd*1.25
      }
      else
        speed=0
    }
  }
  else
    speed=0

    _hspeed=hspeed
    _vspeed=vspeed
    speed=0
    x+=_hspeed*gDeltaTime
    y+=_vspeed*gDeltaTime
}
else
  speed=0
