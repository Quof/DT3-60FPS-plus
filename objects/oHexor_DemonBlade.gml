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
      image_angle+=31
      speed=moveSpd
      moveTime-=1
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
        image_angle=270; direction=270
        speed=0
        atkProg=1
      }
    }
    else if atkProg=1
    {
      atkTime+=1
      if atkTime>=20 {atkTime=0; atkProg=2}
    }
    else if atkProg=2
    {
      speed=moveSpd
      if y>=room_height+80 {instance_destroy()}
    }
  }
  else if type=1 //Straight line
  {
    speed=moveSpd
    atkTime+=1
  }
}
else {speed=0}
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
