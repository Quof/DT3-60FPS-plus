#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type, moveTime, moveSpd
event_inherited()
size=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=oHexor_Main.atkPower

atkProg=0
atkTime=0
_speed=0
_direction=0

playSound(global.snd_HardHit3,0,0.88,32000+random(2000))
playSound(global.snd_KnightSwordSwing,0,0.9,11025+random(1000))
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Line up and go down
  {
    if atkProg=0
    {
      image_angle+=31*gDeltaTime
      _speed=moveSpd
      moveTime-=1*gDeltaTime
      x += cos(degtorad(_direction)) * _speed * gDeltaTime
      y -= sin(degtorad(_direction)) * _speed * gDeltaTime
      if moveTime=0
      {
        var tHexPart,tPartDir;
        tPartDir=0
        for(i=0;i<12;i+=1)
        {
          tHexPart=instance_create(x+lengthdir_x(48,tPartDir),y+lengthdir_y(48,tPartDir),oEf_HexorPart)
          tHexPart.partDelay=0
          tPartDir+=30
        }
        image_angle=270; _direction=270
        _speed=0
        atkProg=1
      }
    }
    else if atkProg=1
    {
      atkTime+=1*gDeltaTime
      if atkTime>=20 {atkTime=0; atkProg=2}
    }
    else if atkProg=2
    {
      _speed=moveSpd
      x += cos(degtorad(_direction)) * _speed * gDeltaTime
      y -= sin(degtorad(_direction)) * _speed * gDeltaTime
      if y>=room_height+80 {instance_destroy()}
    }
  }
  else if type=1 //Straight line
  {
    _speed=moveSpd
    atkTime+=1*gDeltaTime
    x += cos(degtorad(_direction)) * _speed * gDeltaTime
    y -= sin(degtorad(_direction)) * _speed * gDeltaTime
  }
}
else {_speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 and atkProg=1 and atkTime>=60
{
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle+random_range(-1.5,1.5),image_blend,image_alpha)
