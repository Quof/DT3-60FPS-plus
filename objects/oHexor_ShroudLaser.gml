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
  pulsate+=1*gDeltaTime
  //if pulsate>=1 and pulsate<=9 {image_yscale+=0.02*gDeltaTime}
  //if pulsate>=(10-(1-gDeltaTime)) and pulsate<=18
  //{
  //  image_yscale-=0.02*gDeltaTime
  //  pulsate=0
  //}
  if pulsate>0 and pulsate<=9 {image_yscale+=0.02*gDeltaTime} //60fps change: every frame of ticks 1-9
  if pulsate>9 and pulsate<=18 //60fps change: every frame of tick 10 shrinks, and the reset waits for the end of tick 10, so the cycle is 10 ticks like 30fps (it was 9.5/9.25, and the beam, which is the hitbox, grew a little faster)
  {
    image_yscale-=0.02*gDeltaTime
    if pulsate>=10 {pulsate=0}
  }
}
