#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: progCheck
spriteUse=0
if variable_local_exists("spriteChange")
{
  spriteUse=spriteChange
  if spriteUse=1 //Split Party
  {
    progCheck=9000000
    sprite_index=sInvisibleSolidMask
  }
  else if spriteUse=2 //Castlevania Slide Door
    sprite_index=sInvisibleSolidMask
  else if spriteUse=3 //Bike Barrier
  {
    progCheck=9000000
    sprite_index=sInvisibleSolidMask
  }
  else if spriteUse=4 //Bike Blockage
  {
    animTop=16
    progCheck=9000000
    sprite_index=sInvisibleSolidMask
    myBikeDestroy=instance_create(x-16,y,oBikeDestroyer)
    myBikeDestroy.image_yscale=image_yscale
  }
  else if spriteUse=5 //Reach Ring Barrier
  {
    progCheck=9000000
    sprite_index=sInvisibleSolidMask
  }
  else if spriteUse=6 //Metroid Barrier
  {
    sprite_index=sInvisibleSolidMask
    depth=10
  }
  else if spriteUse=7 //Optional Barrier
  {
    sprite_index=sInvisibleSolidMask
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress>=progCheck
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if spriteUse=0
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if spriteUse=1 //Split Party
{
  if image_angle=0
  {
    for(i=0;i<image_yscale;i+=1)
    {
      draw_background_part(tileLostVikingsA,128,96,16,16,x,y+(i*16))
    }
  }
  else if image_angle=90
  {
    for(i=0;i<image_yscale;i+=1)
    {
      draw_background_part(tileLostVikingsA,128,96,16,16,x+(i*16),y-16)
    }
  }
}
else if spriteUse=2 //Castlevania Slide Door
{
  draw_sprite(sCVSlideDoor,0,x,y)
  for(i=0;i<image_yscale-1;i+=1)
  {
    if i mod 2=0
      draw_sprite(sCVSlideDoor,1,x,y+(i*16)+16)
    else
      draw_sprite(sCVSlideDoor,2,x,y+(i*16)+16)
  }
  draw_sprite(sCVSlideDoor,3,x,y+(i*16))
}
else if spriteUse=3 //Bike Barrier
{
  for(i=0;i<image_yscale/2;i+=1)
  {
    draw_background_part(tileMM_ODOstrichA,32,144,16,32,x,y+(i*32))
  }
}
else if spriteUse=4 //Bike Blockage
{
  if instance_exists(doorID)
  {
    animTop-=2
    if animTop=0 {animTop=16}
    for(i=0;i<image_yscale;i+=1)
    {
      draw_sprite_ext(sMotorBlockageA,image_index,x,y+(i*16),1,1,0,doorID.image_blend,1)
      draw_sprite_part_ext(sMotorBlockageB,0,0,animTop,6,16,x+10,y+(i*16),1,1,doorID.image_blend,1)
    }
  }
  else
  {
    for(i=0;i<image_yscale;i+=1)
    {
      tEffect=instance_create(x+8,y+8+(i*16),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    with myBikeDestroy {instance_destroy()}
    instance_destroy()
  }
}
else if spriteUse=5 //Reach Ring Barrier
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_background_part(tileFarreachesA,96,112,16,16,x,y+(i*16))
  }
}
else if spriteUse=6 //Metroid Barrier
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_background_part_ext(tileMetC,32,304,16,16,x,y+(i*16),1,1,make_color_rgb(255,140,140),1)
  }
}
else if spriteUse=7 //Optional Barrier
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_sprite(sOptionalBarrier,1,x,y+(i*16))
  }
}
