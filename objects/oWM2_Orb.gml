#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II (Phantom form): the Dark Sphere. It forms over his hand, drifts after the player for a while (it can't
//be stopped), then collapses into a ring of kunai.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=0  //not while it forms
damageType="ELEMENTAL"
size=2
image_speed=0
owner=noone
st=0              //0: forming over the hand, 1: drifting, 2: collapsing
t=0
spd=1.8           //drift speed per tick
turn=2.5          //degrees per tick it can turn toward the player
lifeT=110         //ticks drifting
dir=270
burstN=8          //kunai in the ring
burstSpd=3.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tD,tDiff,i,tK,tF;
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if st=0
  {
    image_index=min(5,floor(t/20*6))
    if owner!=noone
    {
      if instance_exists(owner) {x=owner.x+owner.scaleForFacing*6; y=owner.y-74}
    }
    if t>=20
    {
      st=1; t=0; bCanDealDamage=1
      dir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      playSound(global.snd_OrbThrow,0,0.9,16000)
    }
  }
  else if st=1
  {
    image_index=6+(floor(t*0.5) mod 9)
    tD=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    tDiff=angle_difference(tD,dir)
    dir+=median(-turn*gDeltaTime,tDiff,turn*gDeltaTime)
    x+=lengthdir_x(spd*gDeltaTime,dir)
    y+=lengthdir_y(spd*gDeltaTime,dir)
    x=median(56,x,424); y=median(84,y,274)
    if gDeltaDoTicks and irandom(1)=0 //wisps, once per 30fps tick
    {
      tF=scrWM2_Fx(x+random_range(-22,22),y+random_range(-22,22),sWM2_Disc,0,make_color_rgb(150,60,230),1)
      tF.image_xscale=0.25; tF.image_yscale=0.25; tF.fade=0.06; tF.life=999; tF.vy=-0.4
    }
    if t>=lifeT {st=2; t=0}
  }
  else if st=2
  {
    image_index=min(18,15+floor(t/2))
    if t>=4 {bCanDealDamage=0}
    if t>=8
    {
      playSound(global.snd_LightballSpread,0,0.95,28000)
      for(i=0;i<burstN;i+=1)
      {
        tK=instance_create(x,y,oWM2_Star)
        tK.type=1; tK.atkPower=atkPower
        tK.image_xscale=0.55; tK.image_yscale=0.55; tK.tint=make_color_rgb(255,140,255)
        tK.vx=lengthdir_x(burstSpd,i*360/burstN+22.5); tK.vy=lengthdir_y(burstSpd,i*360/burstN+22.5)
      }
      tF=scrWM2_Fx(x,y,sWM2_Impact,0.4,make_color_rgb(200,90,255),1)
      tF.image_xscale=2; tF.image_yscale=2
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
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,1.25,1.25,0,make_color_rgb(110,30,200),0.35)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,1)
