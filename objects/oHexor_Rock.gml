#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type, moveTime, moveSpd
event_inherited()
size=2
playSound(global.snd_MMRocks,0,0.96,20000+random(4000))

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=oHexor_Main.atkPower
if oHexor_Main.life<=0 {atkPower*=2}

atkProg=0
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Fall down
  {
    image_angle+=random_range(-3,3)
    y+=5.5
    if y>=room_height+80 {instance_destroy()}
  }
  else if type=1 //Across room
  {
    image_angle+=random_range(-3,3)
    speed=moveSpd
    atkTime+=1
  }
  else if type=2 //Aim at player
  {
    if atkProg=0
    {
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      atkProg=1
    }
    image_angle+=random_range(-3,3)
    speed=moveSpd
    atkTime+=1
  }
  else if type=3 //Aim and wait
  {
    if atkProg=0
    {
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      atkProg=1
    }
    image_angle+=random_range(-3,3)
    if atkProg<3 {speed=moveSpd}
    if atkProg=2
    {
      atkTime-=1
      if atkTime<=0
      {
        speed=0
        atkProg=3
      }
    }
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=3 and atkProg=1
{
  playSound(global.snd_Slam,0,0.88,33400+random(5000))
  atkTime=irandom_range(2,8)
  atkProg=2
}
else
{
  event_inherited()
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkTime>=90 {instance_destroy()}
