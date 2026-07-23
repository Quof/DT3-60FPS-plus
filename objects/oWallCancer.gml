#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(1,-22,24,22)
image_speed=0

//Enemy base statistics
eName="Wall Cancer"
eLevel=19
maxLife=210
life=maxLife
pointWorth=27
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=2
resType[5]=4
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

jeremyText="These weirdly named crabs crawl along the walls and shoot ELEMENTAL based energy attacks that bounce off walls. Equipped with standard armor."
chaoText="I wonder if the Mega Man developers had a thing for crabs. There seem to be a lot of crab like enemies in the early games."
devText="Not sure if it's just me, but attacks that bounce off walls seem way more threatening than they initially appear. Probably because they are. The longer an attack lingers, the more threatening it becomes."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=-1 {setCollisionBounds(-24,-22,-1,22)}
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
      if y>oPlayer1.y-26 {yVel=-runAcc; image_yscale=-1}
      else {yVel=runAcc; image_yscale=1}
    }
    else if stepTime>=2 and stepTime<=99
    {
      image_index+=0.15
      if image_index>3.8
      {
        image_index=0
        xVel=0
        stepTime=100
      }
    }
    else if stepTime=110 {stepTime=0}

    //Check if at cliff edge and turn around
    tDrop=0
    //if aiCheckHoriz(1,1,-8,0,image_yscale*12) {tDrop=1}

    if !collision_point(x-(8*image_xscale),y+(12*image_yscale),oSolid,0,1) {tDrop=1}
    if tDrop=1
    {
      yVel*=-1
      image_yscale*=-1
    }

    //---------- Shoot ----------
    shotTime+=1
    if shotTime>=shotDelay+20
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(22*image_xscale),y-9,oMMWC_Shot)
      tNewAttack.atkPower=atkPower; tNewAttack.xVel=image_xscale*5; tNewAttack.yVel=-5
      tNewAttack=instance_create(x+(22*image_xscale),y+9,oMMWC_Shot)
      tNewAttack.atkPower=atkPower; tNewAttack.xVel=image_xscale*5; tNewAttack.yVel=5
      shotTime=0
    }

    if isCollisionTop(1)
      yVel*=-1
    if isCollisionBottom(1)
      yVel*=-1

    moveTo(xVel,yVel)
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x+(13*image_xscale),y,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(22*image_xscale),y-8,oEffectGrav); tEffect.sprite_index=sWallCancerParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(22*image_xscale),y+8,oEffectGrav); tEffect.sprite_index=sWallCancerParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(7*image_xscale),y-16,oEffectGrav); tEffect.sprite_index=sWallCancerParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(7*image_xscale),y+16,oEffectGrav); tEffect.sprite_index=sWallCancerParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-1,1)
    tEffect=instance_create(x+(8*image_xscale),y,oEffectGrav); tEffect.sprite_index=sWallCancerParts
    tEffect.image_speed=0; tEffect.image_index=2; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
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
  draw_sprite(sWallCancerShot,blasterFrame,x+(22*image_xscale),y-9)
  draw_sprite(sWallCancerShot,blasterFrame,x+(22*image_xscale),y+9)
}
