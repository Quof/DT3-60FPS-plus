#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II: a shadow copy of him for his big attacks (Phantom Cross, Twin Overdrive). It can't be hurt. Warmaster II
//sets what it does: mode 0 holds a pose, 1 dashes along the floor, 2 jumps up and hangs there, 3 dives at tx,ty,
//9 vanishes.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
image_speed=0
image_xscale=1.25
image_yscale=1.25
scaleForFacing=1
form=1         //1: Phantom, 2: X, 3: Saber
mode=0
t=0
dir=1
dashSpd=12
stopX=240
echoGroup=0    //Phantom: leaves echoes (oWM2_Echo) of this group behind while dashing
echoTick=0
vy=0
hoverY=150
tx=240; ty=304
diveSpd=13
diveDir=270
tint=make_color_rgb(150,70,230)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tE,i;
if global.gamePaused=false
{
  t+=1*gDeltaTime
  scaleForFacing=sign(image_xscale)
  if form=2 {tint=make_color_rgb(60,140,255)}
  else if form=3 {tint=make_color_rgb(50,210,130)}
  if mode=1 //dash
  {
    x+=dir*dashSpd*gDeltaTime
    if form=1 {sprite_index=sWM2P_DashSlash; image_index=1+(floor(t*0.5) mod 3)}
    else {sprite_index=sWM2X_Dash; image_index=floor(t*0.25) mod 2}
    if gDeltaDoTicks
    {
      scrWM2_Ghost(0.5,0.1,tint,1)
      if echoGroup>0
      {
        echoTick+=1
        if echoTick mod 3=0
        {
          tE=instance_create(x,y,oWM2_Echo)
          tE.group=echoGroup; tE.image_xscale=image_xscale; tE.image_yscale=image_yscale; tE.atkPower=atkPower
        }
      }
    }
    if (dir=1 and x>=stopX) or (dir=-1 and x<=stopX)
    {
      x=stopX; mode=0
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      if form=1 {sprite_index=sWM2P_DashEnd; image_index=2}
      else {sprite_index=sWM2X_DashEnd; image_index=2}
    }
  }
  else if mode=2 //jump up, then hang
  {
    vy=scrGravAcc(vy,0.6,1)
    y+=vy*gDeltaTime
    if form=1 {sprite_index=sWM2P_Jump; image_index=min(5,floor(t*0.4))}
    else {sprite_index=sWM2X_Jump; image_index=min(2,floor(t*0.3))}
    if vy>=0 or y<=hoverY
    {
      vy=0; mode=0
      if form=1 {sprite_index=sWM2P_AirSlash; image_index=0}
      else {sprite_index=sWM2X_JumpShoot; image_index=0}
    }
  }
  else if mode=3 //dive
  {
    x+=lengthdir_x(diveSpd*gDeltaTime,diveDir)
    y+=lengthdir_y(diveSpd*gDeltaTime,diveDir)
    if form=1 {sprite_index=sWM2P_RollSlash; image_index=floor(t*0.5) mod 11}
    else {sprite_index=sWM2X_Dash; image_index=1}
    if gDeltaDoTicks {scrWM2_Ghost(0.5,0.1,tint,1)}
    if y>=304 or x<40 or x>440
    {
      y=min(y,304)
      playSound(global.snd_HardHit3,0,0.85,26000)
      scrWM2_Smoke(x,y,tint)
      instance_destroy(); exit
    }
  }
  else if mode=9 //vanish
  {
    scrWM2_Smoke(x,y,tint)
    instance_destroy(); exit
  }
  //its slash boxes move with it
  with oWM2_HitBox {if owner=other.id {x=other.x+relX; y=other.y+relY}}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,make_color_rgb(70,40,110),0.9)
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,tint,0.55+0.2*sin(t*0.6))
draw_set_blend_mode(bm_normal)
