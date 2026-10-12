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
tdSyncOff=0 //td speed change (added): vsync is off for the speed-up (User Event 1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flagAnim+=0.25*gDeltaTime
if global.gamePaused=false
{
  waveCountdown-=1*gDeltaTime
  if scrController(4) and oPlayer1.idleTime>2
  {
    waveCountdown-=10*gDeltaTime
    holdDown+=1*gDeltaTime
    //if holdDown>=30 {room_speed=global.gameFrameRate*2}
    if holdDown>=30 {room_speed=global.gameFrameRate*2; event_user(1)} //td speed change: event_user(1) lets it reach that speed (see there)
  }
  //else {room_speed=global.gameFrameRate; holdDown=0}
  else {room_speed=global.gameFrameRate; holdDown=0; event_user(2)} //td speed change: vsync back as it was

  if waveCountdown<=0 and bWaveStart=0
  {
    event_user(0)
  }
  //----- Check player distance -----
  myDist=point_distance(x,y+32,oPlayer1.x,oPlayer1.y-16)
  if myDist<160 {oTD_HUD.bCanConstruct=0}
}
//else {room_speed=global.gameFrameRate}
else {room_speed=global.gameFrameRate; event_user(2)} //td speed change: vsync back as it was
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
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//td speed change (added): the speed-up runs twice as many steps a second (room_speed), as in the original. With vsync on,
//GameMaker can't go faster than the monitor's refresh rate, so above 30fps (120 or 240 steps a second) it sped up little
//or not at all (none at 60fps on a 60Hz monitor). vsync is turned off while it lasts, when the monitor can't keep up,
//and put back by User Event 2. (Doubling the time each step covers instead would make timers that wait for an exact
//value skip it, partway through their count.)
if tdSyncOff=0 and global.optVSync=1 and global.gameFrameRate*2>display_get_frequency()
{
  set_synchronization(0)
  tdSyncOff=1
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//td speed change (added): vsync back as it was after the speed-up (see User Event 1)
if tdSyncOff=1
{
  set_synchronization(global.optVSync)
  tdSyncOff=0
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//td speed change (added): leaving the room during the speed-up puts vsync back as it was
event_user(2)
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
  //textDropShadow(string("Time Till Next Wave#<") +string(waveCountdown) +string(">"),view_xview[0]+240,view_yview[0]+312,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  textDropShadow(string("Time Till Next Wave#<") +string(ceil(waveCountdown)) +string(">"),view_xview[0]+240,view_yview[0]+312,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3) //60fps change: whole numbers (it counts down a fraction of a tick per frame above 30fps, which showed decimals); rounded up, so it counts down to 0 the same way as at 30fps
  if room_speed=global.gameFrameRate
  {
    global.inputAlign=fa_center //input text change (added): centered, for the gamepad icon (scrDrawInput)
    textDropShadow("Hold [Down] to speed up the 'Next Wave' timer.",view_xview[0]+240,view_yview[0]+336,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  }
}
