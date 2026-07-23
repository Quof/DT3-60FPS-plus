#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
rainY=0
backColorA=make_color_rgb(255,188,114)
backColorB=c_black
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
rainY+=6.27
if type=3 //Raindrops
{
  if room=rCh21_WastelandA
  {
    var tEffect;
    if oGame.time mod 2=0
    {
      tEffect=instance_create(random_range(752,784),280,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    for(i=0;i<6;i+=1)
    {
      tEffect=instance_create(random_range(0,752),304,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    for(i=0;i<2;i+=1)
    {
      tEffect=instance_create(random_range(784,room_width),304,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if room=rCh21_WastelandB
  {
    var tEffect;
    if oGame.time mod 2=0
    {
      tEffect=instance_create(random_range(224,256),280,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    for(i=0;i<2;i+=1)
    {
      tEffect=instance_create(random_range(0,224),304,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    for(i=0;i<7;i+=1)
    {
      tEffect=instance_create(random_range(256,room_width),304,oEffect)
      tEffect.sprite_index=sRaindropSplash; tEffect.image_alpha=0.33; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Clouds
{
  draw_background_ext(backWastelandClouds,0,0,1,1,0,c_white,1)
  draw_background_ext(backWastelandClouds,800,0,-1,1,0,c_white,1)
  draw_background_ext(backWastelandClouds,800,0,1,1,0,c_white,1)
  draw_background_ext(backWastelandClouds,1600,0,-1,1,0,c_white,1)
  draw_background_ext(backWastelandClouds,1600,0,1,1,0,c_white,1)
}
else if type=1 //Mountains
{
  for(i=0;i<6;i+=1)
  {
    draw_background_ext(backWastelandMountains,i*252,240,1,1,0,c_white,1)
  }
}
else if type=2 //Rain
{
  draw_background_tiled_ext(backWastelandRain,0,rainY,1,1,c_white,0.25)
}
else if type=3 //Fill color
{
  draw_set_alpha(1)
  draw_set_color(backColorA)
  draw_rectangle(0,129,room_width,240,0)
  draw_set_color(backColorB)
  draw_rectangle(0,282,room_width,room_height,0)
}
