#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkPower=oHexor_Main.atkPower

pulsate=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  pulsate+=1
  if pulsate>=1 and pulsate<=9 {image_yscale+=0.02}
  if pulsate>=10 and pulsate<=18
  {
    image_yscale-=0.02
    pulsate=0
  }
}
