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

_direction=0
_speed=0
turnAmt=0
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
    moveTime+=1*gDeltaTime
    if moveTime>=16 and moveTime<=999
    {
      _direction+=turnDir*gDeltaTime
     //if _direction>=270 and _direction<=290 {moveTime=1000}
      turnAmt+=abs(turnDir)*gDeltaTime //QWH addition; direction not looping properly was breaking this
      if turnAmt>=180 and turnAmt <=200 {moveTime=1000}
      else if turnAmt>=160 and turnAmt<=180 {moveTime=1000}
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
      moveTime+=1*gDeltaTime
      if moveTime=25
      {
        _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
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
        tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk._direction=270; tAtk.image_angle=270
        tAtk=instance_create(warTarget.xCenter+warTarget.roomSpan-16,0,oPassBullet)
        tAtk.sprite_index=sWarmasterB_AtkFireballA; tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.image_blend=image_blend
        tAtk.decayTime=-100; tAtk.damageType="EXPLOSION"; tAtk.image_speed=0.33; tAtk._direction=270; tAtk.image_angle=270
        x=xFall
        _direction=270
        bulletSpeed=12
        moveTime=1
      }
    }
    else if moveTime=1
    {
      if y>=room_height+32 {instance_destroy()}
    }
  }

  _speed=bulletSpeed
  image_angle=_direction
}
else {_speed=0}

correctSpeedDirection(self)

#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,image_blend,0.2)
