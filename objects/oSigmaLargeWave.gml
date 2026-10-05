#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_yscale=0.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Go up
  {
    y-=6*gDeltaTime
    if y<=yAtk {atkProg=1}
  }
  else if atkProg=1 //Grow
  {
    image_yscale+=0.1*gDeltaTime
    if image_yscale>=1.7 {atkProg=2}
  }
  else if atkProg=2 //Fire
  {
    var tA;
    tA=0.2*((image_xscale=1 and moveSpd<7)-(image_xscale=-1 and moveSpd>-7))
    if gDeltaTime!=1 {moveSpd=scrTickAcc(moveSpd,tA,0)} //moves (copies the speed) first, then changes it: above 30fps the tick's change is spread before the move (scrTickAcc, scrTickAccBPre)
    x+=(moveSpd+scrTickAccBPre(0))*gDeltaTime
    if gDeltaTime==1 {moveSpd+=tA}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
