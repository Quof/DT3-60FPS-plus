#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II (X form) buster shots.
//type 0: lemon, 1: half charge (green), 2: full charge (blue), 3: ricochet (pink, bounces), 4: hyper charge (huge blue),
//5: the Saber form's energy streak
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=1
type=0
vx=0          //per tick
vy=0
grav=0        //vy gained per tick (lemon debris)
bounces=0     //type 3: walls/floor/ceiling it bounces off before breaking
split=0       //type 2: breaks into 3 ricochets on the wall
t=0
init=0
image_speed=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tF,i,tS,tA,tBreak,tCol;
if global.gamePaused=false
{
  if init=0
  {
    init=1
    if type=0 {sprite_index=sWM2_Lemon; image_xscale=1.25; image_yscale=1.25}
    else if type=1 {sprite_index=sWM2_ShotG; image_xscale=1.25; image_yscale=1.25; size=2}
    else if type=2 {sprite_index=sWM2_ShotB; mask_index=sWM2_Disc; image_xscale=1.25; image_yscale=1.15; size=2}
    else if type=3 {sprite_index=sWM2_ShotP; image_xscale=1.25; image_yscale=1.25}
    else if type=4 {sprite_index=sWM2_ShotB; mask_index=sWM2_Disc; image_xscale=2; image_yscale=2.6; size=2}
    else if type=5 {sprite_index=sWM2_Streak; image_xscale=1; image_yscale=0.8; image_speed=0}
    image_index=0
  }
  t+=1*gDeltaTime
  if grav!=0 {vy=scrGravAcc(vy,grav,1)}
  x+=vx*gDeltaTime
  y+=vy*gDeltaTime
  if type=1 or type=2 or type=4 or type=5 {image_angle=point_direction(0,0,vx,vy)}

  tBreak=0
  if x<34 or x>446 //walls
  {
    if type=3 and bounces>0
    {
      bounces-=1; vx=-vx; x=median(34,x,446)
      playSound(global.snd_MMBulletDeflect,0,0.7,30000)
    }
    else if type=2 and split=1
    {
      //breaks into three ricochets fanning back out
      for(i=0;i<3;i+=1)
      {
        tA=180-20+i*20
        if vx<0 {tA=-20+i*20}
        tS=instance_create(median(40,x,440),y,oWM2_Shot)
        tS.type=3; tS.atkPower=atkPower; tS.bounces=1
        tS.vx=lengthdir_x(5,tA); tS.vy=lengthdir_y(5,tA)
      }
      tBreak=1
    }
    else {tBreak=1}
  }
  if y<52 or y>300 //ceiling and floor
  {
    if type=3 and bounces>0
    {
      bounces-=1; vy=-vy; y=median(52,y,300)
      playSound(global.snd_MMBulletDeflect,0,0.7,30000)
    }
    else if type=0 or type=3 {tBreak=1}
  }
  if t>300 {tBreak=1}
  if tBreak=1
  {
    tCol=make_color_rgb(120,220,255)
    if type=3 {tCol=make_color_rgb(255,150,200)}
    else if type=5 {tCol=make_color_rgb(90,255,160)}
    tF=scrWM2_Fx(median(34,x,446),median(52,y,300),sWM2_RingHit,0.5,tCol,1)
    if type=4 {tF.image_xscale=2.5; tF.image_yscale=2.5}
    else if type=1 or type=2 {tF.image_xscale=1.4; tF.image_yscale=1.4}
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tCol;
tCol=make_color_rgb(60,160,255)
if type=1 {tCol=make_color_rgb(80,255,120)}
else if type=3 {tCol=make_color_rgb(255,90,170)}
else if type=5 {tCol=make_color_rgb(60,230,140)}
else if type=0 {tCol=make_color_rgb(255,210,60)}
draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.25,image_yscale*1.35,image_angle,tCol,0.45)
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,1)
