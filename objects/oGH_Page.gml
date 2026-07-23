#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: noteType,noteToRead
showControls=0
helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)

showPage=0
pageAlpha=0
textAlpha=0
pageX=0
pageY=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  showControls=2
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_PageFlip,0,0.95,1)
    if global.gateHProg=3 and noteType=1
    {
      (428014).y-=256
      global.gateHProg=4
    }
    else if global.gateHProg=5 and noteType=2
    {
      global.gateHProg=6
    }
    else if global.gateHProg=7 and noteType=3
    {
      (428145).y-=256
      global.gateHProg=8
    }
    else if global.gateHProg=9 and noteType=4
    {
      global.gateHProg=10
    }
    else if global.gateHProg=12 and noteType=5
    {
      global.gateHProg=13
      global.tempAction[0]=1
    }
    else if global.gateHProg=14 and noteType=6
    {
      (428262).y-=256
      global.gateHProg=15
    }
    else if global.gateHProg=16 and noteType=7
    {
      (428270).y-=256
      global.gateHProg=17
    }
    else if global.gateHProg=18 and noteType=8
    {
      global.gateHProg=19
      global.tempAction[0]=1
    }
    else if global.gateHProg=19 and noteType=9
    {
      global.gateHLamps="011100101"
      (428253).bOpened=0
      global.gateHProg=20
    }
    else if global.gateHProg=21 and noteType=10
    {
      (428274).y-=256
      global.gateHProg=22
    }
    else if global.gateHProg=24 and noteType=11
    {
      (428277).y-=256
      global.gateHProg=25
      global.tempAction[0]=1
    }
    else if global.gateHProg=26 and noteType=12
    {
      (428280).y-=256
      global.gateHProg=27
    }
    else if global.gateHProg=28 and noteType=13
    {
      (428283).y-=256
      global.gateHProg=29
    }
    else if global.gateHProg=30 and noteType=14
    {
      (428381).y-=256
      global.gateHProg=31
      global.tempAction[0]=1
    }

    showPage=1
    oPlayer1.visible=0
    depth=0
    global.gamePaused=true
  }
}
else
{
  if oKeyCodes.kCodePressed[5]=1 or oKeyCodes.kCodePressed[6]=1
  {
    showPage=0
    oPlayer1.visible=1
    depth=55
    global.gamePaused=false
  }
}

if showPage=1
{
  if pageAlpha<1 {pageAlpha+=0.05}
  else
  {
    if textAlpha<1 {textAlpha+=0.04}
  }
}
else
{
  pageAlpha=0
  textAlpha=0
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
  draw_sprite_ext(sGateH_UI_Arrow,0,x-21,320,1,1,90,c_white,1)
  textDropShadow("READ",x-12,317,helpTextInner,helpTextOuter,4)
}

if showPage=1
{
  pageX=view_xview[0]+180
  pageY=view_yview[0]+78
  draw_sprite_ext(sHHouse_NotePaper,image_index,pageX,pageY,image_xscale,image_yscale,image_angle,image_blend,pageAlpha)

  draw_set_color(c_black)
  draw_set_alpha(textAlpha)
  draw_set_font(fnt_GateHPage)
  draw_set_halign(fa_left)
  draw_text_ext(pageX+19,pageY+11,noteToRead,10,136)
}
