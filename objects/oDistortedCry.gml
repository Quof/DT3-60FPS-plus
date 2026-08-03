#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_alpha=0
bCanTakeDamage=0

//Enemy base statistics
eName="Distorted Cry"
eLevel=40
maxLife=12350
life=maxLife
pointWorth=110
atkPower=13
stunResist=50
affiliation=8
dieSound=0
dieEffect=0
inactiveDist=10000

enemyProg=0
runAcc=2.25
_speed=0
_direction=0

splittingDist=0
splitColor=make_color_rgb(240,240,255)

jeremyText=""
chaoText=""
devText=""
extraInfo=""

if x<oPlayer1.x {image_xscale=1}
else {image_xscale=-1}

deathAnim=0
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
    if enemyProg=0
    {
      image_alpha+=0.05*gDeltaTime
      if image_alpha>=1
      {
        bCanTakeDamage=1
        enemyProg=1
      }
    }
    else if enemyProg=1
    {
      _speed=runAcc
      _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)

      if point_distance(x,0,oPlayer1.x,0)>=16
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }

      if life<=maxLife/2 //Split off fake images when below half HP
      {
        life+=2000
        resType[1]=1; resType[5]=1
        _speed=0; bCanTakeDamage=0
        centerX=x; centerY=y
        angleDiff=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)+75
        enemyProg=2
      }
    }
    else if enemyProg=2
    {
      centerX=x+lengthdir_x(splittingDist,angleDiff-180)
      centerY=y+lengthdir_y(splittingDist,angleDiff-180)
      _speed=4
      _direction=angleDiff

      splittingDist+=4*gDeltaTime

      if splittingDist>=96
      {
        bCanTakeDamage=1
        _speed=0
        enemyProg=3
      }
    }
    else if enemyProg=3
    {
      centerX=x+lengthdir_x(splittingDist,angleDiff-180)
      centerY=y+lengthdir_y(splittingDist,angleDiff-180)

      _speed=runAcc
      _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)

      if point_distance(x,0,oPlayer1.x,0)>=16
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      image_speed=0
      playSound(global.snd_HardHit1,0,1,1)
      tEfCir=instance_create(x,y-24,oEfCircleBlast)
      tEfCir.image_alpha=0.8; tEfCir.myRad=4; tEfCir.radScl=5; tEfCir.fadeSpeed=0.08
    }

    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y-1-random(42),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else
{
  _speed=0
}

correctSpeedDirection(self)

#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if enemyProg>=2
{
  for(i=0;i<7;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,centerX+lengthdir_x(splittingDist,angleDiff+((i+1)*45)),centerY+lengthdir_y(splittingDist,angleDiff+((i+1)*45)),image_xscale,image_yscale,image_angle,splitColor,image_alpha-0.05)
  }
}
