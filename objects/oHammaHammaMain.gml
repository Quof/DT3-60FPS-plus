#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-20,-48,20,-1)

//Enemy base statistics
eName="Hamma Hamma"
eLevel=20
maxLife=590
life=maxLife
pointWorth=29
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=5
resType[5]=2
stunResist=6
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=1.5

armSeq=30
armSpd=7

jeremyText="These work pretty much exactly like the original. It will wait a moment and then send a spiked arm toward you, then follow up with the other. Its reach is pretty limited, but the arms do block projectiles."
chaoText="Jeremy forgot something again. These have very durable armor, but certain weapons can cut through it pretty quick. When you're dodging the arms, be sure you keep your surroundings in mind since you can't safely dash through them."
devText="The way these arms work is another new thing for the DT series. I'm always surprised at how simple these procedures actually are."
offsetLeftX=19; offsetLeftY=-41
offsetRightX=-1; offsetRightY=-43

leftBall=instance_create(x+offsetLeftX,y+offsetLeftY,oHammaHammaSpike)
leftBall.ownerID=id; leftBall.atkPower=atkPower-1; leftBall.image_blend=c_ltgray
rightBall=instance_create(x+offsetRightX,y+offsetRightY,oHammaHammaSpike)
rightBall.ownerID=id; rightBall.atkPower=atkPower-1
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
    if armSeq<60
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if image_xscale=1
    {
      offsetLeftX=21
      offsetRightX=-1
    }
    else
    {
      offsetLeftX=-21
      offsetRightX=1
    }

    if armSeq<60
    {
      leftBall.x=x+offsetLeftX; leftBall.y=y+offsetLeftY
      rightBall.x=x+offsetRightX; rightBall.y=y+offsetRightY
    }

    //---------- Arm (Spike) Extend ----------
    armSeq+=1
    if armSeq=50
    {
      var tEffect;
      tEffect=instance_create(leftBall.x,leftBall.y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if armSeq=60 {findLeftDir=point_direction(leftBall.x,leftBall.y,oPlayer1.x,returnPlayerYCenter())}
    else if armSeq>=61 and armSeq<=80 //Extend left arm
    {
      leftBall.x+=armSpd*cos(degtorad(findLeftDir))
      leftBall.y+=-armSpd*sin(degtorad(findLeftDir))
    }
    else if armSeq>=141 and armSeq<=160 //Retract left arm
    {
      leftBall.x+=armSpd*cos(degtorad(findLeftDir-180))
      leftBall.y+=-armSpd*sin(degtorad(findLeftDir-180))
    }

    if armSeq=80
    {
      var tEffect;
      tEffect=instance_create(rightBall.x,rightBall.y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if armSeq=90 {findRightDir=point_direction(rightBall.x,rightBall.y,oPlayer1.x,returnPlayerYCenter())}
    else if armSeq>=91 and armSeq<=110 //Extend right arm
    {
      rightBall.x+=armSpd*cos(degtorad(findRightDir))
      rightBall.y+=-armSpd*sin(degtorad(findRightDir))
    }
    else if armSeq>=171 and armSeq<=190 //Retract right arm
    {
      rightBall.x+=armSpd*cos(degtorad(findRightDir-180))
      rightBall.y+=-armSpd*sin(degtorad(findRightDir-180))
      if armSeq=190 {armSeq=0}
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2

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

    tDir=random_range(-2,2)
    tEffect=instance_create(x-(13*image_xscale),y-37,oEffectGrav); tEffect.sprite_index=sHammaHammaPartA; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-2,2)
    tEffect=instance_create(x+(10*image_xscale),y-37,oEffectGrav); tEffect.sprite_index=sHammaHammaPartA; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir); tEffect.image_blend=c_ltgray
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(10*image_xscale),y-30,oEffectGrav); tEffect.sprite_index=sHammaHammaPartB
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    for(i=0;i<4;i+=1)
    {
      tDir=random_range(-4,4)
      tEffect=instance_create(x-(14*image_xscale)+(random(28)*image_xscale),y-34+random(28),oEffectGrav); tEffect.sprite_index=sHammaHammaPartB
      tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
      tEffect.xSpd=tDir; tEffect.ySpd=-3-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    with leftBall {instance_destroy()}
    with rightBall {instance_destroy()}
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

var tLeftDist,tLeftDir;
tLeftDist=point_distance(x+offsetLeftX,y+offsetLeftY,leftBall.x,leftBall.y)
tLeftDir=point_direction(x+offsetLeftX,y+offsetLeftY,leftBall.x,leftBall.y)
draw_sprite(sHammaHammaRing,0,x+offsetLeftX,y+offsetLeftY)
for(i=0;i<3;i+=1)
{
  draw_sprite_ext(sHammaHammaRing,0,x+offsetLeftX+lengthdir_x(tLeftDist*(0.25*(i+1)),tLeftDir),y+offsetLeftY+lengthdir_y(tLeftDist*(0.25*(i+1)),tLeftDir),image_xscale,image_yscale,image_angle,c_ltgray,image_alpha)
}

var tRightDist,tRightDir;
tRightDist=point_distance(x+offsetRightX,y+offsetRightY,rightBall.x,rightBall.y)
tRightDir=point_direction(x+offsetRightX,y+offsetRightY,rightBall.x,rightBall.y)
draw_sprite(sHammaHammaRing,0,x+offsetRightX,y+offsetRightY)
for(i=0;i<3;i+=1)
{
  draw_sprite(sHammaHammaRing,0,x+offsetRightX+lengthdir_x(tRightDist*(0.25*(i+1)),tRightDir),y+offsetRightY+lengthdir_y(tRightDist*(0.25*(i+1)),tRightDir))
}
