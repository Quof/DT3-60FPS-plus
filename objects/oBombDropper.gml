#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0.3

//Enemy base statistics
eName="Bomb Dropper"
eLevel=9
maxLife=300
life=maxLife
pointWorth=10
atkPower=4
resType[1]=5
resType[3]=2
resType[4]=4
stunResist=3
baseItemChance=55
dieSound=0
dieEffect=0
initDir=0
runAcc=1
weight=90

turnTime=0
shootTime=50
shootDelay=100

deathAnim=0
dthPropX=0; dthPropVelX=random_range(-2,2)
dthPropY=0; dthPropVelY=-1-random(2)
dthPropAng=0; dthPropTurn=random_range(-4,4)
dthBodyX=0; dthBodyVelX=random_range(-0.5,0.5)
dthBodyY=0; dthBodyVelY=0.5
dthBodyAng=0; dthBodyTurn=random_range(-1,1)

jeremyText="A robot with slow tracking capabilities. They aren't much of a threat due to their slow bomb deployment. They usually serve as air support."
chaoText="I don't remember where these sprites are from... oh geeze, what was it?#"
if room=rCCity_NorthA
  chaoText+="The inhabitants of Central City don't have the facilities or means to fight back yet. We need to somehow remove these from the area for them."
devText="I wanted DT1 to be more like a Metroidvania, but at the time, I just didn't have the skill to pull it off effectively in Game Maker. I used a few elements, such as using new abilities to open up new areas, but it didn't feel the same with the world broken up the way it was."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !gDeltaDoTicks { exit; }
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
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    x+=xVel

    if x>oPlayer1.x and image_xscale=1
      turnTime+=1
    else if x<oPlayer1.x and image_xscale=-1
      turnTime+=1
    if turnTime>=50
    {
      xVel*=-1
      turnTime=0
    }

    shootTime+=1
    if shootTime>=shootDelay
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_BombLaunch,0,0.72,48000)}
      var tNewAttack,tXVel;
      tXVel=-0.5
      for(i=0;i<3;i+=1)
      {
        tNewAttack=instance_create(x,y+2,oGravityBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.sprite_index=sBDBomb; tNewAttack.damageType="EXPLOSION"
        tNewAttack.bulletSpeed=3; tNewAttack.xVel=tXVel
        tXVel+=0.5
      }
      shootTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEfCir=instance_create(x,y,oEfCircleBlast)
      tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+dthBodyX+random_range(-10,10),y+dthBodyY+random_range(-10,10),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    dthPropX+=dthPropVelX
    dthPropY+=dthPropVelY; dthPropVelY+=0.2
    dthPropAng+=dthPropTurn
    dthBodyX+=dthBodyVelX
    dthBodyY+=dthBodyVelY; dthBodyVelY+=0.025
    dthBodyAng+=dthBodyTurn
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
  //Propeller
  draw_sprite_general(sprite_index,image_index,0,0,31,6,x-15+dthPropX,y-15+dthPropY,1,1,dthPropAng,c_white,c_white,c_white,c_white,image_alpha)
  //Body
  draw_sprite_general(sprite_index,image_index,0,7,31,24,x-15+dthBodyX,y-9+dthBodyY,1,1,dthBodyAng,c_white,c_white,c_white,c_white,image_alpha)
}
