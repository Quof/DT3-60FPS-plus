#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-28,1,28,24)
image_speed=0

//Enemy base statistics
eName="Crablaster"
eLevel=18
maxLife=180
life=maxLife
pointWorth=25
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
stunResist=2
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
runAcc=0.5
stepTime=0
blasterFrame=0

shotTime=50
shotDelay=80

jeremyText="These weird walking crab robots stay on the ceiling and fire ELEMENTAL type shots... and they're slow. There's really nothing else I can say about its behavior other than the fire rate is bleh."
chaoText="I don't like what happened to X either, but he believes in you. We'll pull through this and figure out how to set everything right."
devText="The speed that DT was modeled after is actually the Mega Man X series. I've always loved the pacing of the combat in Mega Man X and tried to match it to some degree."
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
    stepTime+=1
    if stepTime=1
    {
      if x>oPlayer1.x {xVel=-runAcc; image_xscale=-1}
      else {xVel=runAcc; image_xscale=1}
    }
    else if stepTime>=2 and stepTime<=99
    {
      image_index+=0.15
      if image_index>7.8
      {
        image_index=0
        xVel=0
        stepTime=100
      }
    }
    else if stepTime=110 {stepTime=0}

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,-4)
    {
      if aiCheckVert(1,1,-8,8,-4)=1
        tDrop=1
    }
    if tDrop=1
    {
      xVel*=-1
      image_xscale*=-1
    }

    //---------- Shoot ----------
    shotTime+=1
    if shotTime>=shotDelay+20
    {
      var tNewAttack;
      tNewAttack=instance_create(x+13,y+23,oPassBullet)
      tNewAttack.sprite_index=sCrablasterShot
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
      tNewAttack.decayTime=-100; tNewAttack.direction=315
      tNewAttack.damageType="ELEMENTAL"

      tNewAttack=instance_create(x-13,y+23,oPassBullet)
      tNewAttack.sprite_index=sCrablasterShot
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
      tNewAttack.decayTime=-100; tNewAttack.direction=225
      tNewAttack.damageType="ELEMENTAL"
      shotTime=0
    }

    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1

    moveTo(xVel,yVel)
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y+13,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-3,3)
    tEffect=instance_create(x+16,y,oEffectGrav); tEffect.sprite_index=sCrablasterParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-16,y,oEffectGrav); tEffect.sprite_index=sCrablasterParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-3,3)
    tEffect=instance_create(x,y+7,oEffectGrav); tEffect.sprite_index=sCrablasterParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-1-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x,y+15,oEffectGrav); tEffect.sprite_index=sCrablasterParts
    tEffect.image_speed=0; tEffect.image_index=2; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-1-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    instance_destroy()
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if shotTime>=shotDelay
{
  blasterFrame+=0.3
  draw_sprite(sCrablasterShot,blasterFrame,x+13,y+23)
  draw_sprite(sCrablasterShot,blasterFrame,x-13,y+23)
}
