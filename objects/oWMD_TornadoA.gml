#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Tornado - Move to side
event_inherited()
image_speed=0.33
image_alpha=0.9
image_xscale=0.8
image_yscale=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //moves, then slows down toward 0 (0.13 per tick in EX mode, else 0.15)
  var tA;
  if room=rWarshipZ_E3 {tA=0.13} else {tA=0.15}
  tA*=((moveSpd<-1)-(moveSpd>1))
  if gDeltaTime==1 {x+=moveSpd; moveSpd+=tA}
  else
  {
    //above 30fps the tick's change is spread over its frames before each move (scrTickAcc, scrTickAccBPre: moves first)
    moveSpd=scrTickAcc(moveSpd,tA,0)
    x+=(moveSpd+scrTickAccBPre(0))*gDeltaTime
  }

  image_alpha-=fadeSpd*gDeltaTime
  if image_alpha<=0.5 {instance_destroy()}
}
