#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-24,8,-1)
image_speed=0

//Enemy base statistics
eName="Sprongy Spring"
eLevel=8
maxLife=280
life=maxLife
pointWorth=9
atkPower=4
resType[1]=2
resType[3]=4
stunResist=1
baseItemChance=50
dieSound=0
dieEffect=0
initDir=0
turnTime=0
weight=120
runAcc=1.3

deathAnim=0
dthHeadX=0; dthHeadVelX=random_range(-2,2)
dthHeadY=0; dthHeadVelY=-2-random(2)
dthHeadAng=0; dthHeadTurn=random_range(-5,5)
dthSprX=0; dthSprVelX=random_range(-0.5,0.5)
dthSprY=0; dthSprVelY=-0.5-random(1)
dthSprAng=0; dthSprTurn=random_range(-3,3)

jeremyText="Eh... it just bounces, but like all the other robots around here, they don't have very good tracking."
chaoText="A robot sent by the Virus to remove those that threaten it."
if room=rCCity_NorthA
  chaoText+=" It seems Central City is one of those threats."
devText="The focus for DT2 is, as you've seen, far different than the other games. DT1 had a fairly broad scope in its design. DT2 simplified things extensively and focused almost purely on platforming, as seen with the addition of wall jumping. I knew I wasn't going to have that return in DT3, so I knew the final levels needed to make very good use of it... Maybe I went overboard. To be honest, even I have a lot of trouble with that final level in DT2."
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
    if x>oCharacter.x and image_xscale=1
      turnTime+=1
    else if x<oCharacter.x and image_xscale=-1
      turnTime+=1
    if turnTime>=45
    {
      xVel*=-1
      turnTime=0
    }

    if image_index>=3.6
    {
      image_index=0
      image_speed=0
    }

    yVel+=0.31
    if isCollisionBottom(1)
    {
      yVel=-7
      image_speed=0.3
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
      yVel=0.1

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

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
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+dthHeadX+random_range(-6,6),y+dthHeadY+random_range(-6,6),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    dthHeadX+=dthHeadVelX
    dthHeadY+=dthHeadVelY; dthHeadVelY+=0.3
    dthHeadAng+=dthHeadTurn
    dthSprX+=dthSprVelX
    dthSprY+=dthSprVelY; dthSprVelY+=0.2
    dthSprAng+=dthSprTurn
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {event_inherited()}
else
{
  //Head
  draw_sprite_general(sprite_index,image_index,0,0,21,14,x-7+dthHeadX,y-24+dthHeadY,1,1,dthHeadAng,c_white,c_white,c_white,c_white,image_alpha)
  //Spiral
  draw_sprite_general(sprite_index,image_index,0,15,21,15,x-7+dthSprX,y-10+dthSprY,1,1,dthSprAng,c_white,c_white,c_white,c_white,image_alpha)
}
