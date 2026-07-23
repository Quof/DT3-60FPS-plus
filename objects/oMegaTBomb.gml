#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bDestroy=0
weight=50
bombProg=0
paraScale=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if yVel<4.7 {yVel+=0.3}

  if bombProg=0 //Fly out and search for player
  {
    if type=0
    {
      if point_distance(x,0,oPlayer1.x,0)<8 {bombProg=1}
    }
    else if type=1
    {
      if xVel>0
      {
        if x>oPlayer1.x+32 {bombProg=1}
      }
      else
      {
        if x<oPlayer1.x-32 {bombProg=1}
      }
    }
  }
  else if bombProg=1 //Stop
  {
    xVel=0
    yVel=0
    bombProg=2
  }
  else if bombProg=2 //Drop
  {
    if paraScale<1 {paraScale+=0.1}
  }

  if isCollisionTop(1)
    bDestroy=1
  if isCollisionBottom(1)
    bDestroy=1
  if isCollisionLeft(1)
    bDestroy=1
  if isCollisionRight(1)
    bDestroy=1
  moveTo(xVel,yVel)

  if bDestroy=1
  {
    newAttack=instance_create(x,y,oDamageExplosion)
    newAttack.atkPower=atkPower
    newAttack.sprite_index=sBombExplosion
    newAttack.decayTime=-100
    instance_destroy()
  }
  if y>room_height+32
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if paraScale>0 {draw_sprite_ext(sMTBombPara,image_index,x,y,paraScale,paraScale,image_angle,image_blend,image_alpha)}
draw_sprite(sprite_index,0,x,y)
