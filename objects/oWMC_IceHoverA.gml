#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Ice Hover - Orbit
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

moveProg=0
moveTime=0
bOrbit=1
EX_MODE=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if moveProg=0
  {
    myDist+=2
    if myDist>=68 {moveProg=1}
  }
  else if moveProg=1
  {
    moveTime+=1
    if moveTime>=165
    {
      bOrbit=0
      moveTime=0; moveProg=2
    }
  }
  else if moveProg=2
  {
    if EX_MODE=0
    {
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      image_angle=direction
      moveTime+=1
      if moveTime>=fireDelay
      {
        var tAtk;
        tAtk=instance_create(x,y,oWMC_IceHoverB)
        tAtk.atkPower=atkPower; tAtk.direction=direction; tAtk.image_angle=direction
        instance_destroy()
      }
    }
    else
    {
      if EX_MODE=1
      {
        direction=point_direction(warTarget.x,warTarget.y-26,oPlayer1.x,returnPlayerYCenter())
        image_angle=direction
        EX_MODE=2
      }
      moveTime+=1
      if moveTime>=fireDelay
      {
        var tAtk;
        tAtk=instance_create(x,y,oWMC_IceHoverB)
        tAtk.atkPower=atkPower; tAtk.direction=direction; tAtk.image_angle=direction
        instance_destroy()
      }
    }
  }

  if bOrbit=1
  {
    myDir+=3
    x=warTarget.x+lengthdir_x(myDist,myDir)
    y=warTarget.y-26+lengthdir_y(myDist,myDir)
    image_angle=myDir
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,image_blend,0.2)
