#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-36,14,-1)
image_speed=0.3

//Enemy base statistics
eName="Walk Blaster"
eLevel=17
maxLife=240
life=maxLife
pointWorth=23
atkPower=5
resType[0]=2
resType[1]=2
stunResist=2
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
runAcc=1.8

shotTime=45
shotDelay=65

jeremyText="These walking guns are moderately armored with a fairly decent fire rate for their laser. The laser is also too low to the ground for you to duck under."
chaoText="It looks like all of the bots in this Gate have half resistance to PIERCE type weapons. Luckily that isn't going to be a problem for you."
devText="Mega Man X is easily my favorite of the different Mega Man series. I loved the pacing, the level design especially, and just overall tone. (X1-X3)"
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
    }

    //---------- Shoot ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(20*image_xscale),y-28,oPassBullet)
      tNewAttack.sprite_index=sWalkBlasterLaser
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7; tNewAttack.decayTime=-100
      if image_xscale=-1 {tNewAttack.direction=180}
      shotTime=0
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1) and xVel<0
        xVel=runAcc
      if isCollisionRight(1) and xVel>0
        xVel=-runAcc
    if isCollisionSolid()
      y-=2

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-20,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-3,3)
    tEffect=instance_create(x-(12*image_xscale),y-10,oEffectGrav); tEffect.sprite_index=sWalkBlasterParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(7*image_xscale),y-1,oEffectGrav); tEffect.sprite_index=sWalkBlasterParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(19*image_xscale),y-29,oEffectGrav); tEffect.sprite_index=sWalkBlasterParts
    tEffect.image_speed=0; tEffect.image_index=2; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    instance_destroy()
  }
  enemyStepEvent()
}
