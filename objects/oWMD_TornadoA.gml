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
  x+=moveSpd

  if room=rWarshipZ_E3 //EX MODE
  {
    if moveSpd>1 {moveSpd-=0.13}
    else if moveSpd<-1 {moveSpd+=0.13}
  }
  else
  {
    if moveSpd>1 {moveSpd-=0.15}
    else if moveSpd<-1 {moveSpd+=0.15}
  }

  image_alpha-=fadeSpd
  if image_alpha<=0.5 {instance_destroy()}
}
