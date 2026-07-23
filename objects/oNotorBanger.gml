#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-30,12,-1)
image_speed=0.25

//Enemy base statistics
eName="Notor Banger"
eLevel=17
maxLife=180
life=maxLife
pointWorth=26
atkPower=6
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
atkProg=90
gunAngle=0
gunOffsetX=0
gunOffsetY=0
shotsFired=0
xThrow=0

initDir=0
bReadyToFire=1

jeremyText="Jump and shoot man.#I guess one thing to note is just don't get hit by it. Its power is pretty high."
chaoText="More like, jump and fire bombs. Jeremy is just being Jeremy again."
devText="I really wanted wall jumping back in from DT2, but the way I wanted the rest of the game outside of Gate 4 just didn't suit it. Since it didn't feel right having this place without it, I figured it best to simply have the ability locked to this area. It's inconsistent in some sense, but there are a few Gate specific rules to your abilities."
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
      if x>oPlayer1.x {image_xscale=-1}
      initDir=1
    }

    //Gun Angle
    findTargetX=point_distance(oPlayer1.x,0,x,0)
    if x>oPlayer1.x {gunAngle=findTargetX/6+90}
    else {gunAngle=-findTargetX/6+90}
    if image_xscale=1
    {
      if gunAngle>90 {gunAngle=70}
    }
    else
    {
      if gunAngle<90 {gunAngle=110}
    }

    //Movement
    atkProg+=1
    if atkProg=25 //Hop
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      sprite_index=sNotorBangerJump
      y-=2
      yVel=-7
      xVel=2.75*image_xscale
    }
    else if atkProg=105
    {
      //Check distance to player
      if shotsFired=0
      {
        xThrow=point_distance(x,0,oPlayer1.x,0)/32
        if xThrow>8
          xThrow=8
        else if xThrow<0.75
          xThrow=0.75
      }
      else
      {
        xThrow-=2.5
        if xThrow>8
          xThrow=8
        else if xThrow<0.75
          xThrow=0.75
      }

      var tNewAttack;
      tNewAttack=instance_create(x+(10*image_xscale)+lengthdir_x(12,gunAngle),y-25+lengthdir_y(12,gunAngle),oGravBulletAlt)
      tNewAttack.sprite_index=sNotorBangerBomb; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=1; tNewAttack.damageType="EXPLOSION"
      tNewAttack.xVel=xThrow*image_xscale; tNewAttack.yVel=-8-(shotsFired*0.5)
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.5
      shotsFired+=1
      if shotsFired<2 {atkProg=92}
      else
      {
        shotsFired=0
        bReadyToFire=0
        atkProg=0
      }
    }

    yVel+=0.5
    if isCollisionBottom(1)
    {
      if bReadyToFire=0
      {
        if atkProg>=26 and atkProg<=99 {sprite_index=sNotorBangerStand; xVel=0; bReadyToFire=1; atkProg=100}
      }
      yVel=0
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
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

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(6*image_xscale),y-24,oEffectGrav); tEffect.sprite_index=sNotorBangerGun; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

    tDir=random_range(-3,3)
    tEffect=instance_create(x,y-16,oEffectGrav); tEffect.sprite_index=sNotorBangerParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(8*image_xscale),y-15,oEffectGrav); tEffect.sprite_index=sNotorBangerParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(5*image_xscale),y-3,oEffectGrav); tEffect.sprite_index=sNotorBangerParts
    tEffect.image_speed=0; tEffect.image_index=2; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
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
if sprite_index=sNotorBangerStand
{
  gunOffsetX=6
  if image_index>=0 and image_index<=0.99 {gunOffsetY=25}
  else if image_index>=1 and image_index<=1.99 {gunOffsetY=24}
  else if image_index>=2 and image_index<=2.99 {gunOffsetY=22}
}
else if sprite_index=sNotorBangerJump
{
  gunOffsetX=6
  gunOffsetY=32
}
draw_sprite_ext(sNotorBangerGun,0,x+(gunOffsetX*image_xscale),y-gunOffsetY,1,image_yscale,gunAngle,image_blend,image_alpha)
