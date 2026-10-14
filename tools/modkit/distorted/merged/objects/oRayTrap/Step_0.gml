if global.gamePaused=false
{
  if room=rMega4_ToxicJungleA
  {
    x=oPlayer1.x    //spsp ns
  }
  makeEnemyActive(0)
  if checkArea=1
  {
    if fireTime=0
    {
      if checkScreenArea(x,y,4)=1 {fireTime=50}
    }
    checkArea=0
  }

  if fireTime>0
  {
    fireTime-=1*gDeltaTime
    if fireTime mod 2=0 and fireTime>30
    {
      if image_blend=c_white {image_blend=c_silver}
      else {image_blend=c_white}
    }

    if fireTime=30 //Fire laser
    {
      playSound(global.snd_LaserA,0,1,1)
      image_blend=c_white
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sWalkBlasterLaser
      tNewAttack.atkPower=atkPower+3; tNewAttack.bulletSpeed=20; tNewAttack.decayTime=-100
      tNewAttack._direction=player_sprite_center()
      tNewAttack.image_xscale=1.5
    }
  }
  enemyStepEvent()
}
