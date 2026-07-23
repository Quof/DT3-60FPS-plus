#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Fireball
event_inherited()
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"

moveTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Curve
  {
    moveTime+=1
    if moveTime>=16 and moveTime<=999
    {
      direction+=turnDir
      if direction>=270 and direction<=290 {moveTime=1000}
    }

    if y>=room_height+32 {instance_destroy()}
  }
  else if type=1 //Up and then aim
  {
    if moveTime=0
    {
      if y<=stopY {bulletSpeed=0; moveTime=1}
    }
    else if moveTime>=1
    {
      moveTime+=1
      if moveTime=25
      {
        direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        bulletSpeed=6
      }
      else if moveTime>=120 {instance_destroy()}
    }
  }
  else if type=2 //Up and back down
  {
    if moveTime=0
    {
      if y<=-32
      {
        var tAtk;
        tAtk=instance_create(warTarget.xCenter-warTarget.roomSpan+16,0,oPassBullet)
        tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.image_blend=image_blend
        tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=270; tAtk.image_angle=270
        tAtk=instance_create(warTarget.xCenter+warTarget.roomSpan-16,0,oPassBullet)
        tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.image_blend=image_blend
        tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk.direction=270; tAtk.image_angle=270
        x=xFall
        direction=270
        bulletSpeed=12
        moveTime=1
      }
    }
    else if moveTime=1
    {
      if y>=room_height+32 {instance_destroy()}
    }
  }

  speed=bulletSpeed
  image_angle=direction
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,image_blend,0.2)
