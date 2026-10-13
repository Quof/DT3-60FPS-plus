///Shoot Logic

//get origin point
if autoFire = true
{
    originPointX = x
    originPointY = y
}
else if enemyBullets = false
{
    originPointX = oIdentifier.x
    originPointY = oIdentifier.y
}
else
{
    originPointX = oChaoBoss.x
    originPointY = oChaoBoss.y
}

//get aim direction
if autoAim = true
{
    if instance_exists(oEnemyBase) {tFindClosest=instance_nearest(x,y,oEnemyBase)}
    else {exit}
    /*
    if room=rBT_Cousinoer5ChaoWarmaster
    {
        tDir=point_direction(originPointX,originPointY,tFindClosest.x,tFindClosest.y-26)
    }
    else
    {*/
    if tFindClosest.eName="CHAOS Warmaster" or tFindClosest.eName="CHAOS Warmaster EX" or tFindClosest.eName="Fedex"
        tDir=point_direction(originPointX,originPointY,tFindClosest.x,tFindClosest.y-26)
    else
        tDir=point_direction(originPointX,originPointY,tFindClosest.x,tFindClosest.y)
    //}
    
}
else
{
    if enemyBullets = false
    {
        tDir=point_direction(originPointX,originPointY,oIdentifier.chaoTargetX,oIdentifier.chaoTargetY)
    }
    else
    {
        tDir=point_direction(originPointX,originPointY,oChaoBoss.chaoTargetX,oChaoBoss.chaoTargetY)
    }
}

if enemyBullets = false
{
    decayTime-=decayPerShot
}

shotDelay=maxShotDelay

tDir-=10 * ((bulletSpread - 1) / 2)
for(i=0;i<bulletSpread;i+=1)
{
  if enemyBullets = false
  {
    tNewAttack=instance_create(originPointX,originPointY,oChaoBullet)
  }
  else
  {
    tNewAttack=instance_create(originPointX,originPointY,oChaoBossBullet)
  }
  //tNewAttack.direction=tDir; tNewAttack.image_angle=tDir
  tNewAttack._direction=tDir; tNewAttack.image_angle=tDir //60fps change: the Chao bullets move by _direction/_speed
  if enemyBullets = false
  {
    tNewAttack.atkPower = atkPower
  }
  else
  {
    tNewAttack.atkPower = 1
  }
  tNewAttack.maxSpeed = bulletSpeed
  
  tNewAttack.explodeLevel = explodeLevel
  tNewAttack.bounceLevel = bounceLevel
  tNewAttack.homeLevel = homeLevel
  tNewAttack.splitLevel = splitLevel
  tNewAttack.meleeLevel = meleeLevel
  tNewAttack.shieldLevel = shieldLevel
    
  tNewAttack.arcLevel = arcLevel
  
  tDir+=10
}
