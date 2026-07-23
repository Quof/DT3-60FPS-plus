#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.75
image_xscale=6
image_yscale=8
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_PotShatter,0,0.94,37000)
playSound(global.snd_RupeeBounce,0,0.85,37000)
for(i=0;i<3;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    for(iii=0;iii<4;iii+=1)
    {
      tEffect=instance_create(x+16+(i*32)+random_range(-3,3),y+16+(ii*32)+random_range(-3,3),oEffect)
      tEffect.sprite_index=sMMGlassBreak; tEffect.image_speed=0.2+random(0.1); tEffect.image_angle=iii*90
      tEffect.direction=45+(iii*90); tEffect.speed=1+random(1)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
}
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_ext(backMM_SigmaAGlass,x,y,1.33,1.33,0,image_blend,image_alpha)
