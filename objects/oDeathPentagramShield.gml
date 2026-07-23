#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=0.5
image_yscale=0.5
atkProg=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg>=1 and atkProg<=5
  {
    atkProg+=1
    image_xscale+=0.1
    image_yscale+=0.1
  }
  else if atkProg>=10
  {
    image_xscale-=0.19
    image_yscale-=0.19
    image_alpha-=0.1
    if image_alpha<=0.5 {instance_destroy()}
  }
}
#define Collision_oBelmontDagger
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewAttack,tPDirChk;
if oDeath.image_xscale=1
  tPDirChk=0
else
  tPDirChk=180

tNewAttack=instance_create(other.x,other.y,oPassBullet)
tNewAttack.sprite_index=other.sprite_index; tNewAttack.atkPower=4
tNewAttack.bulletSpeed=15; tNewAttack.decayTime=-100; tNewAttack.direction=tPDirChk

with other {instance_destroy()}
