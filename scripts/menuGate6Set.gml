/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Ability Set submenu for Gate 6.
*/
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_left)
textDropShadow("Level",contentMenuX+14,contentMenuY+23,textColorMain,textColorShadow,1)
textDropShadow(global.stJGame_C[1],contentMenuX+14,contentMenuY+34,textColorMain,textColorShadow,1)

textDropShadow("Exp",contentMenuX+14,contentMenuY+56,textColorMain,textColorShadow,1)
if global.stJGame_C[1]<64
  textDropShadow(global.stJGame_C[2],contentMenuX+14,contentMenuY+67,textColorMain,textColorShadow,1)
else
  textDropShadow("-----",contentMenuX+14,contentMenuY+67,textColorMain,textColorShadow,1)

textDropShadow("Next",contentMenuX+14,contentMenuY+89,textColorMain,textColorShadow,1)
if global.stJGame_C[1]<64
  textDropShadow(global.stCGame_C[0],contentMenuX+14,contentMenuY+100,textColorMain,textColorShadow,1)
else
  textDropShadow("-----",contentMenuX+14,contentMenuY+100,textColorMain,textColorShadow,1)

textDropShadow("JERRY",contentMenuX+126,contentMenuY+23,textColorMain,textColorShadow,1)
if global.gameProgress>=3500
{
  textDropShadow("Spam Gun",contentMenuX+126,contentMenuY+34,textColorMain,textColorShadow,1)
  textDropShadow(string("Pwr:  ") +string((15+(global.stJGame_C[1]*2))),contentMenuX+224,contentMenuY+34,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if global.stJGame_A[2]>0 {tWepAcc=round((global.stJGame_A[1]/global.stJGame_A[2])*100)}
  textDropShadow(string("Accuracy:  ") +string(tWepAcc) +string("%     ") +string(global.stJGame_A[1]) +string("/") +string(global.stJGame_A[2]),contentMenuX+126,contentMenuY+45,textColorMain,textColorShadow,1)
}
if global.gameProgress>=3771
{
  textDropShadow("Bird Swarm",contentMenuX+126,contentMenuY+60,textColorMain,textColorShadow,1)
  textDropShadow(string("Pwr:  ") +string((25+round(global.stJGame_C[1]*1.5))),contentMenuX+224,contentMenuY+60,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if global.stJGame_B[2]>0 {tWepAcc=round((global.stJGame_B[1]/global.stJGame_B[2])*100)}
  textDropShadow(string("Accuracy:  ") +string(tWepAcc) +string("%     ") +string(global.stJGame_B[1]) +string("/") +string(global.stJGame_B[2]),contentMenuX+126,contentMenuY+71,textColorMain,textColorShadow,1)
}

textDropShadow("CLAIRE",contentMenuX+126,contentMenuY+101,textColorMain,textColorShadow,1)
textDropShadow("Blade Strike",contentMenuX+126,contentMenuY+112,textColorMain,textColorShadow,1)
textDropShadow(string("Pwr:  ") +string((110+(global.stJGame_C[1]*4))),contentMenuX+224,contentMenuY+112,textColorMain,textColorShadow,1)
var tWepAcc;
tWepAcc=0
if global.stCGame_A[2]>0 {tWepAcc=round((global.stCGame_A[1]/global.stCGame_A[2])*100)}
textDropShadow(string("Accuracy:  ") +string(tWepAcc) +string("%     ") +string(global.stCGame_A[1]) +string("/") +string(global.stCGame_A[2]),contentMenuX+126,contentMenuY+123,textColorMain,textColorShadow,1)

if global.gameProgress>=3771
{
  textDropShadow("Chainblade Storm",contentMenuX+126,contentMenuY+138,textColorMain,textColorShadow,1)
  textDropShadow(string("Pwr:  ") +string((25+(global.stJGame_C[1]*3))),contentMenuX+224,contentMenuY+138,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if global.stCGame_B[2]>0 {tWepAcc=round((global.stCGame_B[1]/global.stCGame_B[2])*100)}
  textDropShadow(string("Accuracy:  ") +string(tWepAcc) +string("%     ") +string(global.stCGame_B[1]) +string("/") +string(global.stCGame_B[2]),contentMenuX+126,contentMenuY+149,textColorMain,textColorShadow,1)
}
