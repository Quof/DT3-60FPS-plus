#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: pushPower,drawType
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
image_speed=pushPower/4
hoverAlpha=-1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=2
{
  if pushPower>0
  {
    image_blend=make_color_rgb(220,220,255)
  }
  else if pushPower<0
  {
    image_blend=make_color_rgb(255,220,220)
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the character
if global.gamePaused=false
{
  var pDist;
  pDist=distance_to_object(oPlayer1)
  if pDist<600
  {
    if isCollisionCharacterTop(1,0)
    {
      with oPlayer1
        moveTo(oGame.collisionTempId.pushPower,0)
    }
  }
}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the character
if global.gamePaused=false
{
  var pDist;
  pDist=distance_to_object(oPlayer1)
  if pDist<600
  {
    if isCollisionCharacterTop(1,other)
    {
      with other
        moveTo(oGame.collisionTempId.pushPower,0)
    }
  }
}
#define Collision_oHealthPickup
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if other.sprite_index!=sMetroidHealthPickup
  {
    var pDist;
    pDist=distance_to_object(oPlayer1)
    if pDist<600
    {
      if isCollisionCharacterTop(1,other)
      {
        with other
          moveTo(oGame.collisionTempId.pushPower,0)
      }
    }
  }
}
#define Collision_oLinkBomb
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if isCollisionCharacterTop(1,other)
  {
    with other
      moveTo(oGame.collisionTempId.pushPower,0)
  }
}
#define Collision_oMoneyPickup
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  var pDist;
  pDist=distance_to_object(oPlayer1)
  if pDist<600
  {
    if isCollisionCharacterTop(1,other)
    {
      with other
        moveTo(oGame.collisionTempId.pushPower,0)
    }
  }
}
#define Collision_oWeaponPickup
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if other.sprite_index!=sMetroidMissile
  {
    var pDist;
    pDist=distance_to_object(oPlayer1)
    if pDist<600
    {
      if isCollisionCharacterTop(1,other)
      {
        with other
          moveTo(oGame.collisionTempId.pushPower,0)
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=0 //Central City
{
  if image_xscale>2
  {
    var ii;
    for(ii=1;ii<image_xscale-1;ii+=1)
    {
      draw_sprite(sConveyorA_Mid,image_index,x+(ii*16),y)
    }
  }
  draw_sprite(sConveyorA_Left,image_index,x,y)
  draw_sprite(sConveyorA_Right,image_index,x+(image_xscale*16)-16,y)
}
else if drawType=1 //MM Sigma Stage
{
  var ii;
  for(ii=0;ii<image_xscale;ii+=1)
  {
    draw_sprite(sConveyorB_Mid,image_index,x+(ii*16),y)
  }
  draw_sprite(sConveyorB_Left,image_index,x,y)
  draw_sprite(sConveyorB_Right,image_index,x+(image_xscale*16),y)
}
else if drawType=2 //Warship
{
  if image_xscale>2
  {
    var ii;
    for(ii=1;ii<image_xscale-1;ii+=1)
    {
      draw_sprite_ext(sConveyorC_Mid,image_index,x+(ii*16),y,1,1,0,image_blend,image_alpha)
    }
  }
  draw_sprite_ext(sConveyorC_Left,image_index,x,y,1,1,0,image_blend,image_alpha)
  draw_sprite_ext(sConveyorC_Right,image_index,x+(image_xscale*16)-16,y,1,1,0,image_blend,image_alpha)
}

if global.optShowHoverInfo=1 and hoverAlpha!=-1 //Hover info
{
  if place_meeting(x,y,oIdentifier) {hoverAlpha=1.5}
  if hoverAlpha>0 and oIdentifier.bCanScan=1
  {
    hoverAlpha-=0.05
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_center)
    draw_set_alpha(hoverAlpha)
    var tHoverX,tHoverY;
    tHoverX=floor(x+(image_xscale*8))
    tHoverY=floor(y)+32
    textDropShadow(string("Conveyor Speed: ") +string(pushPower),tHoverX,tHoverY,make_color_rgb(0,255,0),c_black,1)
  }
}
event_inherited()
