#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
topDraw=16
splashDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
topDraw-=2
if topDraw<=0 {topDraw=16}

splashDelay+=1
if splashDelay mod 9=0
{
  var tEffect;
  tEffect=instance_create(x+20,y+(image_yscale*16),oEffect)
  tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_blend=make_color_rgb(50,50,220)
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.1

  tEffect=instance_create(x-4,y+(image_yscale*16),oEffect)
  tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_blend=make_color_rgb(50,50,220); tEffect.image_xscale=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<image_yscale;i+=1)
{
  draw_sprite_part(sG6Waterfall,0,1,topDraw,16,16,x,y+(i*16))
}
