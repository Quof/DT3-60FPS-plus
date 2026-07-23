#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moltenAshEfDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moltenAshEfDelay+=1
if moltenAshEfDelay mod 3=0 //General ash particles
{
  var tFFScl,tEffect,tXX,tYY;
  tFFScl=random(0.2)
  tXX=(view_xview[0]-16)+random(view_wview[0]+64)
  tYY=view_yview[0]+random(view_hview[0])
  tEffect=instance_create(tXX,tYY,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfLavaAsh; tEffect.newBlend=-1; tEffect.image_speed=0.1+random(0.15)
  tEffect.image_alpha=0.5; tEffect.image_xscale=0.4+tFFScl; tEffect.image_yscale=0.4+tFFScl
  tEffect.direction=random(360); tEffect.speed=random(0.4)+0.4; tEffect.friction=random(0.015)+0.015
  tEffect.fadeSpd=0.01; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}

if moltenAshEfDelay mod 4=0 //Ash particles from the lava
{
  var tFFScl,tEffect,tXX,tYY;
  tFFScl=random(0.3)
  tXX=(view_xview[0]-16)+random(view_wview[0]+64)
  tYY=oCh18LavaFloor.y+8
  tEffect=instance_create(tXX,tYY,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfLavaAsh; tEffect.newBlend=-1; tEffect.image_speed=0.1+random(0.15)
  tEffect.image_alpha=0.5; tEffect.image_xscale=0.5+tFFScl; tEffect.image_yscale=0.5+tFFScl; tEffect.depth=11
  tEffect.direction=random_range(70,110); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
  tEffect.fadeSpd=0.01; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}
