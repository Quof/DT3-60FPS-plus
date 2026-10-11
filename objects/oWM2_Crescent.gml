#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II: a crescent wave sliding along the floor (the Phantom form's gold one, or the Saber form's green one,
//sWM2_CrescentZ, set by whoever makes it). Jump it.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
image_speed=0
dir=1        //1: right, -1: left
spd=6        //pixels per tick
scl=0.65     //size (the sprite is 57px tall)
glow=make_color_rgb(200,60,255)
sparkCol=make_color_rgb(255,190,60)
t=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tF;
if global.gamePaused=false
{
  t+=1*gDeltaTime
  x+=dir*spd*gDeltaTime
  image_xscale=dir*scl; image_yscale=scl
  //grows in, then holds its full frame
  if t<2 {image_index=0}
  else if t<4 {image_index=1}
  else {image_index=2}
  if gDeltaDoTicks and t>=4 //a spark trail, once per 30fps tick
  {
    if irandom(2)=0
    {
      tF=scrWM2_Fx(x-dir*8,y+random_range(-10,10)*scl*1.4,sWM2_Disc,0,sparkCol,1)
      tF.image_xscale=0.12; tF.image_yscale=0.12; tF.fade=0.12; tF.life=999; tF.vy=-0.6; tF.vx=-dir*0.5
    }
  }
  if x<36 or x>444
  {
    tF=scrWM2_Fx(x,y,sprite_index,0,c_white,1)
    tF.image_index=3; tF.image_xscale=image_xscale; tF.image_yscale=image_yscale; tF.fade=0.12; tF.life=999; tF.grow=0.04
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x-dir*3,y,image_xscale*1.15,image_yscale*1.1,0,glow,0.45)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)
