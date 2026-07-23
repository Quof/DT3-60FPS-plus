#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-44,13,-1)
image_speed=0.15

//Enemy base statistics
eName="Shield Menace"
eLevel=22
maxLife=630
life=maxLife
pointWorth=35
atkPower=6
resType[5]=1
stunResist=5
baseItemChance=80
moneyWorth=10
dieEffect=0
initDir=0
runAcc=2
turnTime=30
shotTime=50
shotDelay=80

deathAnim=0
yDeath=0

jeremyText="These are like the Shield Knights, but much worse. They're faster at responding to you, deal more damage, and have a bigger sword wave. The worst part is they are completely impervious to attacks from the front, even while attacking. There is however, a really bad flaw. NORMAL type damage will deal double when they're attacking. Use that to your advantage to take down their high HP count."
chaoText="Why are there so many shielded enemies here?!"
devText="There are a few enemies in DT3 with very similar behaviors such as this and the Shield Knight. In all of them always build or improve upon a previous version of itself. In this case, not only is it slightly faster, but it has a few new rules for dealing damage."
extraInfo="Immune to all frontal attacks."
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
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }

    //Turn around if turn timer is 0 and player is close enough
    if point_distance(x,0,oPlayer1.x,0)<128
    {
      if (x<oPlayer1.x and image_xscale=-1) or (x>oPlayer1.x and image_xscale=1)
      {
        turnTime-=1
        if turnTime=0
        {
          xVel*=-1
          turnTime=25
        }
      }
    }

    if shotTime<shotDelay //Check direction
    {
      if xVel>0 {image_xscale=1}
      else {image_xscale=-1}
    }

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
        tDrop=1
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=25
    }

    //---------- Swing sword (wave) ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime=shotDelay //Change anim and step back if too close to player
      {
        if point_distance(x,0,oPlayer1.x,0)<224 and ((x>oPlayer1.x and image_xscale=-1) or (x<oPlayer1.x and image_xscale=1))
        {
          xVel=0
          resType[0]=4
          sprite_index=sShieldMenaceSwing
          image_speed=0
          image_index=0
        }
        else {shotTime=shotDelay-5}
      }
      else if shotTime=shotDelay+12 //Fire shot
      {
        image_index=1
        var tNewAttack;
        tNewAttack=instance_create(x+(12*image_xscale),y-28,oPassBullet)
        tNewAttack.sprite_index=sShieldMenaceBeam; tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=8.25; tNewAttack.decayTime=-100
        if image_xscale=-1 {tNewAttack.direction=180}
      }
      else if shotTime=shotDelay+21 //End attack
      {
        xVel=runAcc
        if x>oPlayer1.x {xVel*=-1}
        resType[0]=3
        sprite_index=sShieldMenaceWalk
        image_speed=0.15
        turnTime=25
        shotTime=0
      }
    }

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y-1-random(44),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if enemyDeflect(1,1,1,1,1,1)=1
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x+random_range(-11,11),y-4-random(44),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else {event_inherited()}
