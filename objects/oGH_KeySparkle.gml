#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: keyNum
image_speed=0.15
showControls=0
helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  showControls=2
  if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_BirdsA,0,0.9,30000)
    if keyNum=1
    {
      global.gateHProg=5
      myKeyText="Claire picked up the [BUTTERFLY KEY]."
    }
    else if keyNum=2
    {
      global.gateHProg=7
      instance_create(1552,144,oGH_CR_Barrier)
      myKeyText="Claire picked up the [PASSION KEY]."
      global.gateHLamps="111110111"
      (428251).bOpened=1; (428252).bOpened=1; (428256).bOpened=0
      (428282).y-=256
    }
    else if keyNum=3
    {
      global.gateHProg=9
      myKeyText="Claire picked up the [HAND KEY]."
    }
    else if keyNum=4
    {
      global.gateHProg=12
      myKeyText="Claire picked up the [ENTHUSIASM KEY]."
      global.gateHLamps="101001111"
    }
    else if keyNum=5
    {
      global.gateHProg=16
      myKeyText="Claire picked up the [ESKIMO KEY]."
    }
    else if keyNum=6
    {
      global.gateHProg=21
      myKeyText="Claire picked up the [DEVOTION KEY]."
    }
    else if keyNum=7
    {
      global.gateHProg=23
      myKeyText="Claire picked up the [CHEEK KEY]."
    }
    else if keyNum=8
    {
      global.gateHProg=24
      myKeyText="Claire picked up the [FOREHEAD KEY]."
    }
    else if keyNum=9
    {
      global.gateHProg=26
      myKeyText="Claire picked up the [AIR KEY]."
    }
    else if keyNum=10
    {
      global.gateHProg=28
      myKeyText="Claire picked up the [CARE KEY]."
      global.gateHLamps="111101110"
    }
    else if keyNum=11
    {
      global.gateHProg=30
      myKeyText="Claire picked up the [ANGEL KEY]."
    }
    else if keyNum=12
    {
      global.gateHProg=32
      myKeyText="Claire picked up the [HEART KEY]."
      global.gateHLamps="101101101"
    }
    createScreenText(70,100,80,fnt_ScreenText,fa_left,myKeyText,3,c_white,1,0)
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if showControls>0
{
  showControls-=1
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_left)
  draw_sprite_ext(sGateH_UI_Arrow,0,x-26,320,1,1,270,c_white,1)
  textDropShadow("PICK UP",x-16,317,helpTextInner,helpTextOuter,4)
}
