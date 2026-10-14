if global.gamePaused=false
{
  if !instance_exists(ownerID) {instance_destroy()}
  //speed=bulletSpeed
  //if speed=0 {speed=bulletSpeed}
  //vspeed+=0.2
  //bulletSpeed=speed
  //60fps change: moves by _hspeed/_vspeed (set by oThunderbirdEX) with the gravity added per 30fps tick (scrGravAcc), like
  //DT3+'s gravity bullets. The speed=0 on pause and speed=bulletSpeed after it only kept it still while paused, so it now
  //just doesn't move while paused (correctHSpeedVSpeed below is inside this block)
  _vspeed=scrGravAcc(_vspeed,0.2,1)
  if bDestroy=1
  {
    for(i=0;i<8;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sprite_index
      tNewAttack.image_xscale=0.5; tNewAttack.image_yscale=0.5; tNewAttack.image_speed=0.5
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4; tNewAttack.decayTime=12
      //tNewAttack.direction=tDir
      tNewAttack._direction=tDir //60fps change: DT3+'s oPassBullet moves by _direction
      tNewAttack.image_blend=c_yellow
      tDir+=360/8
    }
    instance_destroy()
  }
  correctHSpeedVSpeed(self) //60fps change (added): moves it by _hspeed/_vspeed
}
//else {speed=0}
//60fps change: see above
