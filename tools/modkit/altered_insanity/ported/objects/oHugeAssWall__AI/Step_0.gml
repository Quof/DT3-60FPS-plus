if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if !instance_exists(myTurretA) and !instance_exists(myTurretB)
    {
      gunShot+=1*gDeltaTime
      if gunShot>=gunDelay
      {
        var tNewAttack;
        tNewAttack=instance_create(x+22,y+112,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack._direction=point_direction(x+22,y+112,oPlayer1.x,returnPlayerYCenter())
        gunShot=0
      }
    }
  }
  else if life<=0
  {
    if (deathAnim == 0)
    {
      deathAnim = 1-gDeltaTime
    }
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with myTurretA {instance_destroy()}
      with myTurretB {instance_destroy()}
    }

    if oGame.time mod (8/gDeltaTime)=0 {playSound(global.snd_EnemyDieMM,0,0.9,1)}
    if gDeltaDoTicks { //60fps change (added): one explosion per 30fps tick (was 2x/4x as many at 60/120fps)
    tEffect=instance_create(x+random(sprite_width),y+random(sprite_height),oEffect)
    tEffect.sprite_index=sRobotExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1
    } //60fps change (added)

    if deathAnim>=35
    {
      with mySolid {instance_destroy()}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
