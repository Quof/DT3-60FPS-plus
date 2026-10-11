#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II (Phantom form): a shadow left behind by Phantom Rush. It hangs there harmlessly until it's triggered
//(fireT), flashes white, then slashes where it stands. Every shadow of one rush is triggered together.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=0  //the slash is a separate box (scrWM2_Hit)
size=2
image_speed=0
image_index=2
group=0           //the rush it came from
fireT=-1          //ticks till it slashes (-1: not triggered yet)
fired=0
t=0
scaleForFacing=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  t+=1*gDeltaTime
  scaleForFacing=sign(image_xscale)
  if fireT>=0 and fired=0
  {
    fireT-=1*gDeltaTime
    if fireT<=0
    {
      fired=1; t=0
      scrWM2_Hit(-20,-42,40,40,4,0)
    }
  }
  if fired=1 and t>=8 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tA;
if fired=1 //the slash, fading
{
  tA=1-t/8
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,2,x,y,image_xscale*1.1,image_yscale*1.1,0,make_color_rgb(255,120,255),tA)
  draw_set_blend_mode(bm_normal)
  draw_sprite_ext(sprite_index,2,x,y,image_xscale,image_yscale,0,c_white,tA)
}
else if fireT>=0 //about to slash: flashes
{
  draw_sprite_ext(sprite_index,2,x,y,image_xscale,image_yscale,0,make_color_rgb(150,60,220),0.6)
  draw_set_blend_mode(bm_add)
  if (floor(fireT/2) mod 2)=0
  {
    draw_sprite_ext(sprite_index,2,x,y,image_xscale,image_yscale,0,c_white,0.9)
    draw_sprite_ext(sprite_index,2,x,y,image_xscale,image_yscale,0,c_white,0.9)
  }
  draw_set_blend_mode(bm_normal)
}
else //waiting
{
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,2,x,y,image_xscale,image_yscale,0,make_color_rgb(120,40,200),0.35+0.1*sin(t*0.4))
  draw_set_blend_mode(bm_normal)
}
