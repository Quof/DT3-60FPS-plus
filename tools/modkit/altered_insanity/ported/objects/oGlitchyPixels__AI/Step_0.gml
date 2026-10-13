if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      //Movement
      var tDirToPlayer;
      tDirToPlayer=point_direction(x,y,oPlayer1.x+lengthdir_x(96,circlePlayer),returnPlayerYCenter()+lengthdir_y(96,circlePlayer))
      circlePlayer+=2*gDeltaTime
      _direction=tDirToPlayer
      _speed=runAcc

      //Weapon
      shotTime+=1*gDeltaTime
      if shotTime>=shotDelay-30 {orbitSpd=8}
      else {orbitSpd=1}
      orbitPos+=orbitSpd*gDeltaTime

      if shotTime>=shotDelay
      {
        var tNewAttack,tDir;
        tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        tDir-=12
        for(i=0;i<3;i+=1)
        {
          tNewAttack=instance_create(x,y,oGlitchBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6; tNewAttack.decayTime=-100
          tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.75
          tNewAttack._direction=tDir
          tDir+=12
        }
        shotTime=0
      }
    }
    else {_speed=0}
  }
  enemyStepEvent()
}
else {_speed=0}

correctSpeedDirection(self)
