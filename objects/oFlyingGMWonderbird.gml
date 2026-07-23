#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Flying Great Magician Wonderbird"
eLevel=29
maxLife=1200
life=maxLife
pointWorth=80
atkPower=9
resType[0]=1
resType[1]=1
stunResist=8
baseItemChance=75
baseDropIndex=90
moneyWorth=10
affiliation=7
dieSound=0
dieEffect=0
detectDistX=304
inactiveDist*=2

gunShot=0
if x>=oPlayer1.x {xVel=-7}
else {xVel=7}

deathAnim=0

jeremyText="This has a very easy movement pattern. The problem when dealing with these comes from their above average HP count and bullet spam. When mixed with respawning enemies, which I hope doesn't happen, this could be harsh."
chaoText="This is a large ship from 'Contra: Hard Corps'. I don't remember where it was used in the game, though I bet Claire would remember. I played with her, but I wasn't very good at these kinds of games like Claire was."
devText="These are classified in the notes as a miniboss, but it really isn't. Hey, it'll be utilized in miniboss like scenarios... whatever that is."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //Look at player
    if x>oPlayer1.x and xVel>-3 {xVel-=0.2}
    else if x<oPlayer1.x and xVel<3 {xVel+=0.2}
    x+=xVel

    //Fire at player
    gunShot+=1
    if gunShot>=70
    {
      var tNewAttack;
      if gunShot mod 10=0
      {
        for(i=0;i<3;i+=1)
        {
          tNewAttack=instance_create(x-80,y-3,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=225+(55*i)
          tNewAttack=instance_create(x+80,y-3,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=225+(55*i)
        }
      }
    }
    if gunShot>=105
    {
      for(i=0;i<7;i+=1)
      {
        tNewAttack=instance_create(x,y+18,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=210+(20*i)
      }
      gunShot=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 2=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-116,116),y-random(20),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03
    if image_alpha<0
    {
      playSound(global.snd_HardHit1,0,0.98,1)
      tEffect=instance_create(x,y-17,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
