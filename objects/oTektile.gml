#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-16,7,16)
image_speed=0.1

//Enemy base statistics
eName="Tektite"
eLevel=9
maxLife=360
life=maxLife
pointWorth=14
atkPower=4
resType[0]=2
resType[1]=1
resType[2]=4
resType[3]=2
resType[4]=5
stunResist=6
baseItemChance=55
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

runAcc=3.5
jumpTime=25
jumpDelay=40+irandom(30)
fireTime=5
fireDelay=70

legBProg=0
legLength=16
bodyY=0

jeremyText="Ugh, remember these annoying things that could only be hurt by the Fire spell? They're just as annoying here... sorta. They have some Normal type resist, which is a pain. As for behavior, it just jumps and shoots."
chaoText="I always saw it as a waste of MP to use Fire just to take these out so I usually skipped by them. Usually with the downward stab to bounce off of them to get by easier.#HEY!! It worked okay!"
devText="Here's a fun fact. When making DT1, not all of the story points were down when it was started. It wasn't until Dusty Ruins that I had written the rest of the game's story. Due to this, a few inconsistencies earlier on had to be rewritten. There were a few subtle plotholes left in the dialogue purposely that allude to what the story used to be."
extraInfo="High Stun Resist."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if x<oCharacter.x
      image_xscale=1
    else
      image_xscale=-1

    //---------- Leg Movement ----------
    if legBProg=0
    {
      legLength-=2
      if legLength=0
        legBProg=1
    }
    else if legBProg=1
    {
      legLength+=2
      if legLength=16
        legBProg=0
    }

    //---------- Action: Jumping ----------
    jumpTime+=1
    if jumpTime>=jumpDelay
    {
      y-=4
      yVel=-8.5
      if image_xscale=1
        xVel=runAcc
      else
        xVel=-runAcc

      jumpTime=0
      jumpDelay=70+irandom(30)
    }

    //---------- Action: Fire ----------
    fireTime+=1
    if fireTime=fireDelay
    {
      var tEffect;
      tEffect=instance_create(x,y-7,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.image_speed=0.5; tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-7
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if fireTime>=fireDelay+15
    {
      var tFire;
      tFire=instance_create(x+(6*image_xscale),y-7,oPassBullet)
      if image_xscale=1 {tFire.direction=0}
      else {tFire.direction=180}
      tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower
      tFire.bulletSpeed=6.5; tFire.decayTime=-100
      fireTime=0
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      xVel=0
      yVel=0
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionTop(1)
      yVel=1

    moveTo(xVel,yVel)
    if isCollisionSolid()
      y-=2

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//event_inherited()
draw_sprite_ext(sTektileBody,0,x,y+16-legLength,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sTektileLegs,0,x,y+16-legLength,image_xscale,legLength,image_angle,image_blend,image_alpha)
