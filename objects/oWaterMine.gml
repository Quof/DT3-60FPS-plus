#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false

mineProg=0
mineTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if mineProg=0 //Check if player is close
  {
    if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<64
      mineProg=1
  }
  else if mineProg=1
  {
    mineTime+=1
    if mineTime mod 5=0
    {
      if image_blend=c_white {image_blend=c_navy}
      else {image_blend=c_white}
    }

    if mineTime>=45
    {
      playSound(global.snd_PotShatter,0,0.92,14000)
      newExplode=instance_create(x,y,oTrapExplosion)
      newExplode.atkPower=atkPower; newExplode.sprite_index=sShipExplosion; newExplode.image_speed=0.5
      newExplode.image_xscale=1.5; newExplode.image_yscale=1.5; newExplode.decayTime=-100
      instance_destroy()
    }
  }
}
