#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_blend=c_black
image_xscale=oShadowForm.image_xscale

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oShadowForm.x
  y=oShadowForm.y
  image_xscale=oShadowForm.image_xscale
  image_index+=atkSpd

  if image_index>=image_number
  {
    if sprite_index=sLinkSword {oShadowForm.sprite_index=sJerryIdle}
    else {oShadowForm.sprite_index=sClaireIdle}
    oShadowForm.image_speed=0.1
    instance_destroy()
  }
}
