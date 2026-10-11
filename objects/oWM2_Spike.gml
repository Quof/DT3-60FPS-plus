#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II (Saber form): an energy spike that bursts up out of the floor. The spot glows first (delay), then the
//spike stabs up for a moment and fades. Spike Line sets off a row of them one after another.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=0
size=2
image_speed=0
image_index=irandom(1)
image_xscale=choose(-1,1)*0.6
image_yscale=0.05
delay=8       //ticks of warning glow before it bursts
scl=0.5       //full height (the sprite is 92px tall)
loud=0        //1: plays the burst sound (only every fourth spike in a row does)
st=0          //0: warning, 1: up, 2: fading
t=0
glow=make_color_rgb(60,230,140)
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
  if st=0
  {
    if t>=delay
    {
      st=1; t=0; bCanDealDamage=1
      image_xscale=sign(image_xscale)*scl*1.2
      if loud=1 {playSound(global.snd_HardHit3,0,0.6,26000)}
      tF=scrWM2_Fx(x,y,sWM2_Smoke,0.5,glow,1)
      tF.image_alpha=0.6; tF.vy=-0.6
    }
  }
  else if st=1
  {
    image_yscale=scl*min(1,t/2)
    if t>=6 {st=2; t=0; bCanDealDamage=0}
  }
  else if st=2
  {
    image_alpha=1-t/6
    if t>=6 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tA;
draw_set_blend_mode(bm_add)
if st=0 //the warning: a glowing crack in the floor, brighter as it gets close
{
  tA=0.25+0.5*min(1,t/max(1,delay))
  draw_set_alpha(tA*(0.7+0.3*sin(t*1.2)))
  draw_set_color(glow)
  draw_rectangle(x-9,y-3,x+9,y-1,false)
  draw_line_width(x-5,y-2,x+5,y-2,2)
  draw_set_alpha(1)
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.25,image_yscale*1.08,0,glow,0.5*image_alpha)
}
draw_set_blend_mode(bm_normal)
if st>0 {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,image_alpha)}
