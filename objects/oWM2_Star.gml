#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II (Phantom form): type 0 is a thrown shuriken that sticks in the floor and bursts a moment later; type 1 is
//a small kunai (from the Dark Sphere's burst) that breaks on anything it touches.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=1
type=0
vx=0         //per tick
vy=0
st=0         //0: flying, 1: stuck in the floor
t=0
burstT=14    //ticks stuck before it bursts
tint=make_color_rgb(220,170,255)
image_speed=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tF,tH;
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if st=0
  {
    x+=vx*gDeltaTime
    y+=vy*gDeltaTime
    image_angle=point_direction(0,0,vx,vy)
    if image_index<1 {image_index=1} //skips the tiny first frame once it's flying
    if x<34 or x>446 or y<50 or (type=1 and y>300)
    {
      tF=scrWM2_Fx(median(34,x,446),median(50,y,300),sWM2_Impact,0.5,tint,1)
      tF.image_xscale=0.5; tF.image_yscale=0.5
      instance_destroy(); exit
    }
    if type=0 and y>=298
    {
      //sticks in the floor
      y=298; st=1; t=0; vx=0; vy=0
      image_speed=0; image_index=2
      playSound(global.snd_DaggerHit,0,0.9,1)
    }
  }
  else if st=1
  {
    if t>=burstT
    {
      playSound(global.snd_HardHit3,0,0.6,30000)
      tF=scrWM2_Fx(x,y-4,sWM2_Impact,0.5,tint,1)
      tF.image_xscale=1.3; tF.image_yscale=1.3
      tF=scrWM2_Fx(x,y,sWM2_StarFade,0.4,tint,1)
      tH=instance_create(x-18,y-22,oWM2_HitBox)
      tH.image_xscale=36; tH.image_yscale=24; tH.hitTime=4; tH.atkPower=atkPower
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tA;
tA=1
if st=1 {tA=0.55+0.45*abs(sin(t*0.8))} //blinks while stuck
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,make_color_rgb(150,40,220),0.6*tA)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,tint,tA)
