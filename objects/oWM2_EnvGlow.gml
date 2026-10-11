#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II's arena lights: the old arena's glowing lines (white copies of them, tinted here) in the colour of
//the form he's in, as set by oBTB_Ev_Warmaster2 (lightCol, lightLevel). kind 1-4: lines A-D (set by the instance's
//creation code), 9: drifting motes and the floor line (made by the room's code)
kind=1
t=random(100)
moteN=14
for(i=0;i<moteN;i+=1)
{
  moteX[i]=40+random(400)
  moteY[i]=60+random(244)
  moteS[i]=0.3+random(0.6)
  moteP[i]=random(6.28)
}
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//after the creation code has set kind
if kind=1 {sprite_index=sWM2_Env_GlowA; depth=999998}
else if kind=2 {sprite_index=sWM2_Env_GlowB; depth=999998}
else if kind=3 {sprite_index=sWM2_Env_GlowC; depth=999998}
else if kind=4 {sprite_index=sWM2_Env_GlowD; depth=1000010}
else {sprite_index=-1; depth=999997}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
t+=1*gDeltaTime
if kind=9
{
  for(i=0;i<moteN;i+=1)
  {
    moteY[i]-=moteS[i]*gDeltaTime
    if moteY[i]<56 {moteY[i]=300; moteX[i]=40+random(400)}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tCol,tLev,tA,i;
tCol=c_white; tLev=0.15
if instance_exists(oBTB_Ev_Warmaster2) {tCol=oBTB_Ev_Warmaster2.lightCol; tLev=oBTB_Ev_Warmaster2.lightLevel}
if tLev<=0 {exit}
draw_set_blend_mode(bm_add)
if kind=9
{
  for(i=0;i<moteN;i+=1)
  {
    tA=tLev*(0.25+0.25*sin(t*0.08+moteP[i]))
    draw_set_alpha(tA)
    draw_set_color(tCol)
    draw_circle(moteX[i]+sin(t*0.03+moteP[i])*6,moteY[i],1+moteS[i],false)
  }
  //the floor's edge lights up
  draw_set_alpha(tLev*(0.35+0.1*sin(t*0.1)))
  draw_line_width_color(32,304,448,304,2,tCol,tCol)
  draw_set_alpha(tLev*0.15)
  draw_rectangle_color(32,296,448,304,c_black,c_black,tCol,tCol,false)
  draw_set_alpha(1)
}
else if sprite_index>=0
{
  tA=tLev*(0.75+0.25*sin(t*0.07))
  draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,tCol,tA)
}
draw_set_blend_mode(bm_normal)
