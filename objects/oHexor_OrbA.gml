#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: atkDelay,orbDir,type
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=oHexor_Main.atkPower

bulletSpeed=8
atkProg=0
atkTime=0
orbDist=4

colorShift=255
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Spin outward
  {
    if orbDist<48 {orbDist+=1}

    orbDir+=3

    atkTime+=1
    if atkTime>=135
    {
      if type=0
      {
        atkTime=0; atkProg=11
      }
      else if type=1
      {
        atkTime=0; atkProg=21
      }
    }
  }
  else if atkProg=11 //-------------------- Attack 1A - Delay and Aim --------------------
  {
    atkDelay-=1
    if atkDelay<=22 {colorShift-=5; image_blend=make_color_rgb(255,colorShift,colorShift)}
    if atkDelay<=0
    {
      playSound(global.snd_Fireball,0,0.92,22050+random(22050))
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      atkProg+=1
    }
  }
  else if atkProg=12 //Attack 1B - To point
  {
    speed=bulletSpeed
    atkTime+=1
    if atkTime>=150 {instance_destroy()}
  }
  else if atkProg=21 //-------------------- Attack 2A - Delay --------------------
  {
    atkTime+=1
    if atkTime>=20 {atkTime=0; atkProg+=1}
  }
  else if atkProg=22 //Attack 2B - Move outward
  {
    orbDist+=2
    if orbDist>=88 {atkTime=0; atkProg+=1}
  }
  else if atkProg=23 //Attack 2C - Delay and Aim
  {
    atkDelay-=1
    if atkDelay<=22 {colorShift-=5; image_blend=make_color_rgb(255,colorShift,colorShift)}
    if atkDelay<=0
    {
      playSound(global.snd_Fireball,0,0.92,22050+random(22050))
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      atkProg+=1
    }
  }
  else if atkProg=24 //Attack 2D - To point
  {
    speed=bulletSpeed
    atkTime+=1
    if atkTime>=150 {instance_destroy()}
  }

  if atkProg=0 or atkProg=11 or atkProg=21 or atkProg=22
  {
    x=oHexor_Main.x+lengthdir_x(orbDist,orbDir)
    y=oHexor_Main.y+lengthdir_y(orbDist,orbDir)
  }
}
else {speed=0}
