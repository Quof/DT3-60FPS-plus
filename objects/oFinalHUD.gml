#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
posY=-24
lifeOffset=26
dashOffset=64

jeremyLife=0 //1000
hexorLife=0 //1000
jeremyLifebar=0
hexorLifebar=0

jeremyDash=0 //10000
hexorDash=0 //10000
jeremyDashbar=0
hexorDashbar=0

superPosY=room_height+24
superBar=1

colorUpR=0
colorUpG=0
colorUpB=0
chargeBarR=255
chargeBarG=255
chargeBarB=255

if room!=rDistortionF
{
  jeremyLife=global.pMaxLife
  hexorLife=global.finalBossHP

  jeremyDash=10000
  hexorDash=10000
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if posY<24 {posY+=1}
if superPosY>room_height-12 {superPosY-=1}

if colorUpR=0 //Charge Bar - Red
{
  chargeBarR-=1
  if chargeBarR<=145 {colorUpR=1}
}
else
{
  chargeBarR+=1
  if chargeBarR>=255 {colorUpR=0}
}
if colorUpG=0 //Charge Bar - Green
{
  chargeBarG-=2
  if chargeBarG<=123 {colorUpG=1}
}
else
{
  chargeBarG+=2
  if chargeBarG>=255 {colorUpG=0}
}
if colorUpB=0 //Charge Bar - Blue
{
  chargeBarB-=1
  if chargeBarB<=102 {colorUpB=1}
}
else
{
  chargeBarB+=1
  if chargeBarB>=255 {colorUpB=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Find targets
if room=rDistortionF
{
  playerTarget=oPlayer1
  enemyTarget=oHexor_Final
}
else if room=rDistFinal_Pong
{
  playerTarget=oFB_PlayerPaddle
  enemyTarget=oFB_HexorPaddle
}
else if room=rDistFinal_Round2
{
  playerTarget=oPlayer1
  enemyTarget=oHexor_Main_R2
}

//------------------------- Life -------------------------
jeremyLife=numRollValue(jeremyLife,playerTarget.life,2)
hexorLife=numRollValue(hexorLife,enemyTarget.life,2)

jeremyLifebar=(jeremyLife/playerTarget.maxLife)*200
hexorLifebar=(hexorLife/enemyTarget.maxLife)*200

if jeremyLifebar<0 {jeremyLifebar=0}
if hexorLifebar<0 {hexorLifebar=0}

draw_sprite(sJHFF_HUD,0,view_xview[0]+240,view_yview[0]+posY)
draw_sprite_ext(sJHFF_Bars,0,view_xview[0]+240-lifeOffset,view_yview[0]+posY,-jeremyLifebar,1,0,c_white,1)
draw_sprite_ext(sJHFF_Bars,1,view_xview[0]+240+lifeOffset,view_yview[0]+posY,hexorLifebar,1,0,c_white,1)

//------------------------- Dash -------------------------
jeremyDash=numRollValue(jeremyDash,playerTarget.dashEnergy,3)
hexorDash=numRollValue(hexorDash,enemyTarget.dashEnergy,3)

jeremyDashbar=(jeremyDash/playerTarget.dashMeterMax)*101
hexorDashbar=(hexorDash/enemyTarget.dashMeterMax)*101

if jeremyDashbar<0 {jeremyDashbar=0}
if hexorDashbar<0 {hexorDashbar=0}

draw_sprite_ext(sJHFF_Bars,2,view_xview[0]+240-dashOffset,view_yview[0]+posY+13,-jeremyDashbar,1,0,c_white,1)
draw_sprite_ext(sJHFF_Bars,2,view_xview[0]+240+dashOffset,view_yview[0]+posY+13,hexorDashbar,1,0,c_white,1)

//------------------------- Super -------------------------
draw_sprite(sJHFF_SuperHUD,0,view_xview[0]+6,view_yview[0]+superPosY)

superBar=(playerTarget.jeremySuperEnergy/playerTarget.jeremySuperMax)*100
draw_sprite_ext(sJHFF_SuperBars,0,view_xview[0]+9,view_yview[0]+superPosY,superBar,1,0,c_white,1)

var tSuperCharges,tChargeBlend;
tSuperCharges=floor(playerTarget.jeremySuperEnergy/300)
for(i=0;i<tSuperCharges;i+=1)
{
  tChargeBlend=make_color_rgb(chargeBarR-(i*10),chargeBarG-(i*10),chargeBarB-(i*10))
  draw_sprite_ext(sJHFF_SuperCharges,0,view_xview[0]+13+(i*10),view_yview[0]+superPosY,1,1,0,tChargeBlend,1)
}

//========== EXTRAS - DELETE ==========
/*
draw_set_alpha(1)
draw_set_color(c_white)
draw_set_font(fnt_NES)
draw_set_halign(fa_left)
for(i=0;i<10;i+=1)
{
  //draw_text(16+(12*i),80,oPlayer1.myDirPress[i])
  if oPlayer1.myDirPress[i]=1 {draw_sprite_ext(sKeyPressDisplay,0,16+(12*i),80,1,1,90,c_white,1)}
  else if oPlayer1.myDirPress[i]=2 {draw_sprite_ext(sKeyPressDisplay,0,16+(12*i),80,1,1,270,c_white,1)}
  else if oPlayer1.myDirPress[i]=3 {draw_sprite_ext(sKeyPressDisplay,0,16+(12*i),80,1,1,180,c_white,1)}
  else if oPlayer1.myDirPress[i]=4 {draw_sprite_ext(sKeyPressDisplay,0,16+(12*i),80,1,1,0,c_white,1)}
}
