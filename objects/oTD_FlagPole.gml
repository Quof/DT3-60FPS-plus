#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flagAnim=0
bWaveStart=0
waveCountdown=1800
holdDown=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flagAnim+=0.25
if global.gamePaused=false
{
  waveCountdown-=1
  if scrController(4) and oPlayer1.idleTime>2
  {
    waveCountdown-=10
    holdDown+=1
    if holdDown>=30 {room_speed=global.gameFrameRate*2}
  }
  else {room_speed=global.gameFrameRate; holdDown=0}

  if waveCountdown<=0 and bWaveStart=0
  {
    event_user(0)
  }
  //----- Check player distance -----
  myDist=point_distance(x,y+32,oPlayer1.x,oPlayer1.y-16)
  if myDist<160 {oTD_HUD.bCanConstruct=0}
}
else {room_speed=global.gameFrameRate}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tFlash,tEffect;
tFlash=instance_create(0,0,oScreenFlash)
tFlash.image_alpha=0.8; tFlash.image_blend=c_red; tFlash.fadeSpeed=0.2
var tEffect;
tEffect=instance_create(x,y+32,oEffect)
tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
oTD_HUD.tdStat_Stability-=other.stabilityDmg
with other
{
  instance_destroy()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oTD_EnemySpawner
{
  bCanSpawn=1
}

with oTD_FlagPole
{
  waveCountdown=0
  bWaveStart=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sTD_Flag,flagAnim,x+5,y+6,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bWaveStart=0
{
  draw_set_alpha(1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_middle)
  textDropShadow(string("Time Till Next Wave#<") +string(waveCountdown) +string(">"),view_xview[0]+240,view_yview[0]+312,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  if room_speed=global.gameFrameRate
  {
    textDropShadow("Hold [Down] to speed up the 'Next Wave' timer.",view_xview[0]+240,view_yview[0]+336,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  }
}
