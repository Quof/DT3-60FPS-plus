#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
plankX=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  sprite_index=sCHAOS_Rocketeer
  image_speed=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //CHAOS Shock Troop carrying wooden plank
{
  x+=2*image_xscale

  if image_index>=0 and image_index<=0.99 {plankX=0}
  else if image_index>=1 and image_index<=1.99 {plankX=1}
  else if image_index>=2 and image_index<=2.99 {plankX=2}
  else if image_index>=3 and image_index<=3.99 {plankX=1}
}
else if type=1 //CHAOS Rocketeer smoke effect
{
  var tEffect;
  tEffect=instance_create(x-(17*image_xscale),y-2,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
  tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
  tEffect.fadeSpd=0.05; tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  if image_xscale=1 {tEffect.direction=random_range(255,265)}
  else {tEffect.direction=random_range(275,285)}
}
else if type=2 //NPC walking
{
  x+=2*image_xscale
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sOBJ_End_PlankA,image_index,x+(plankX+8*image_xscale),y-48,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
else {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
