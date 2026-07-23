/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Progress submenu.
*/

draw_set_font(fnt_PauseMenuText)
if mP_Page=1
{
  //----- Display program chips -----
  draw_sprite(sPauseM_ChipSlots,0,contentMenuX+15,contentMenuY+57)
  mP_Spinner+=global.programChips
  draw_sprite_ext(sPauseM_SlotSpin,1,contentMenuX+15,contentMenuY+57,1,1,mP_Spinner,c_white,1)
  var tPChipY; tPChipY=0
  for(i=0;i<global.programChips;i+=1)
  {
    draw_sprite(sPauseM_Chips,i,contentMenuX+15,contentMenuY+77+tPChipY)
    tPChipY+=16
  }

  var tInstrX,tInstrY;
  tInstrX=34; tInstrY=92
  //----- Display instrument slots -----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+tInstrX,contentMenuY+tInstrY,contentMenuX+tInstrX+79,contentMenuY+tInstrY+79,1)
  draw_set_color(colorFillInstr)
  draw_rectangle(contentMenuX+tInstrX+21,contentMenuY+tInstrY+3,contentMenuX+tInstrX+38,contentMenuY+tInstrY+20,0) //1
  draw_rectangle(contentMenuX+tInstrX+41,contentMenuY+tInstrY+3,contentMenuX+tInstrX+58,contentMenuY+tInstrY+20,0) //2
  draw_rectangle(contentMenuX+tInstrX+59,contentMenuY+tInstrY+21,contentMenuX+tInstrX+76,contentMenuY+tInstrY+38,0) //3
  draw_rectangle(contentMenuX+tInstrX+59,contentMenuY+tInstrY+41,contentMenuX+tInstrX+76,contentMenuY+tInstrY+58,0) //4
  draw_rectangle(contentMenuX+tInstrX+41,contentMenuY+tInstrY+59,contentMenuX+tInstrX+58,contentMenuY+tInstrY+76,0) //5
  draw_rectangle(contentMenuX+tInstrX+21,contentMenuY+tInstrY+59,contentMenuX+tInstrX+38,contentMenuY+tInstrY+76,0) //6
  draw_rectangle(contentMenuX+tInstrX+3,contentMenuY+tInstrY+41,contentMenuX+tInstrX+20,contentMenuY+tInstrY+58,0) //7
  draw_rectangle(contentMenuX+tInstrX+3,contentMenuY+tInstrY+21,contentMenuX+tInstrX+20,contentMenuY+tInstrY+38,0) //8
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+tInstrX+21,contentMenuY+tInstrY+3,contentMenuX+tInstrX+38,contentMenuY+tInstrY+20,1) //1
  draw_rectangle(contentMenuX+tInstrX+41,contentMenuY+tInstrY+3,contentMenuX+tInstrX+58,contentMenuY+tInstrY+20,1) //2
  draw_rectangle(contentMenuX+tInstrX+59,contentMenuY+tInstrY+21,contentMenuX+tInstrX+76,contentMenuY+tInstrY+38,1) //3
  draw_rectangle(contentMenuX+tInstrX+59,contentMenuY+tInstrY+41,contentMenuX+tInstrX+76,contentMenuY+tInstrY+58,1) //4
  draw_rectangle(contentMenuX+tInstrX+41,contentMenuY+tInstrY+59,contentMenuX+tInstrX+58,contentMenuY+tInstrY+76,1) //5
  draw_rectangle(contentMenuX+tInstrX+21,contentMenuY+tInstrY+59,contentMenuX+tInstrX+38,contentMenuY+tInstrY+76,1) //6
  draw_rectangle(contentMenuX+tInstrX+3,contentMenuY+tInstrY+41,contentMenuX+tInstrX+20,contentMenuY+tInstrY+58,1) //7
  draw_rectangle(contentMenuX+tInstrX+3,contentMenuY+tInstrY+21,contentMenuX+tInstrX+20,contentMenuY+tInstrY+38,1) //8

  if instrProg[0]="9"
    draw_sprite(sPauseM_Instruments,0,contentMenuX+tInstrX+30,contentMenuY+tInstrY+12) //Full Moon Cello
  if instrProg[1]="9"
    draw_sprite(sPauseM_Instruments,1,contentMenuX+tInstrX+50,contentMenuY+tInstrY+12) //Conch Horn
  if instrProg[2]="9"
    draw_sprite(sPauseM_Instruments,2,contentMenuX+tInstrX+68,contentMenuY+tInstrY+30) //Sea Lily's Bell
  if instrProg[3]="9"
    draw_sprite(sPauseM_Instruments,3,contentMenuX+tInstrX+68,contentMenuY+tInstrY+50) //Surf Harp
  if instrProg[4]="9"
    draw_sprite(sPauseM_Instruments,4,contentMenuX+tInstrX+50,contentMenuY+tInstrY+68) //Wind Marimba
  if instrProg[5]="9"
    draw_sprite(sPauseM_Instruments,5,contentMenuX+tInstrX+30,contentMenuY+tInstrY+68) //Coral Triangle
  if instrProg[6]="9"
    draw_sprite(sPauseM_Instruments,6,contentMenuX+tInstrX+12,contentMenuY+tInstrY+50) //Organ of Evening Calm
  if instrProg[7]="9"
    draw_sprite(sPauseM_Instruments,7,contentMenuX+tInstrX+12,contentMenuY+tInstrY+30) //Thunder Drum
  
  //----- Display weapon ammo -----
  draw_set_halign(fa_right)
  draw_rectangle(contentMenuX+34,contentMenuY+16,contentMenuX+103,contentMenuY+84,1)
  if global.hasAbilToken[1]>0
  {
    draw_sprite(sPauseM_StatArrow,0,contentMenuX+45,contentMenuY+27)
    textDropShadow(string(global.hudLink_Arrows[0]) +string("/") +string(global.hudLink_Arrows[1]),contentMenuX+100,contentMenuY+20,textColorMain,textColorShadow,1)
  }
  if global.hasAbilToken[2]>0
  {
    draw_sprite(sPauseM_StatHeart,0,contentMenuX+45,contentMenuY+43)
    textDropShadow(string(global.hudBelmont_WeaponEn[0]) +string("/") +string(global.hudBelmont_WeaponEn[1]),contentMenuX+100,contentMenuY+36,textColorMain,textColorShadow,1)
  }
  if global.hasAbilToken[4]>0
  {
    draw_sprite(sPauseM_StatMissile,0,contentMenuX+45,contentMenuY+58)
    textDropShadow(string(global.hudSamus_Missiles[0]) +string("/") +string(global.hudSamus_Missiles[1]),contentMenuX+100,contentMenuY+52,textColorMain,textColorShadow,1)
  }
  if global.hasAbilToken[5]>0 or global.hasAbilToken[6]>0
  {
    draw_sprite(sGamePower,0,contentMenuX+37,contentMenuY+67)
    textDropShadow(string(global.hudGame_WeaponEn[0]) +string("/") +string(global.hudGame_WeaponEn[1]),contentMenuX+100,contentMenuY+68,textColorMain,textColorShadow,1)
  }
  
  //----- Display Internetz-----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+117,contentMenuY+16,contentMenuX+253,contentMenuY+35,1)
  draw_sprite(sPauseM_Internetz,0,contentMenuX+128,contentMenuY+26)
  draw_set_halign(fa_left)
  textDropShadow(string(oPlayer1.currentMoney) +string(" / ") +string(global.pMoneyMax),contentMenuX+143,contentMenuY+20,textColorMain,textColorShadow,1)
  
  draw_set_halign(fa_right)
  var tIndexCheck,tMoneyBoostCheck;
  tIndexCheck=0; tMoneyBoostCheck=0
  for(i=0;i<20;i+=1) {indexCheck=string_char_at(global.walletBoost,i+1); if indexCheck="1" {tMoneyBoostCheck+=1}}
  tMoneyBoostCheck*=10
  textDropShadow(string(tMoneyBoostCheck) +string("%"),contentMenuX+249,contentMenuY+20,textColorMain,textColorShadow,1)
  
  //----- Display Item % and Amount -----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+117,contentMenuY+37,contentMenuX+253,contentMenuY+171,1)
  draw_line(contentMenuX+117,contentMenuY+49,contentMenuX+253,contentMenuY+49)
  draw_set_halign(fa_left)
  global.gamePercent=checkItemPercent(0)
  var tGameItemAmt,tGameItemMax;
  tGameItemAmt=checkItemPercent(1)
  tGameItemMax=checkItemPercent(2)
  if global.bNightmareMode=0
  {
    textDropShadow(string("Item % ") +string(global.gamePercent),contentMenuX+120,contentMenuY+37,textColorMain,textColorShadow,1)
  }
  else
  {
    textDropShadow(string("Cheese % ") +string(global.gamePercent),contentMenuX+120,contentMenuY+37,textColorMain,textColorShadow,1)
  }
  draw_set_halign(fa_right)
  textDropShadow(string(tGameItemAmt) +string(" / ") +string(tGameItemMax),contentMenuX+251,contentMenuY+37,textColorMain,textColorShadow,1)
  draw_set_halign(fa_left)
  checkItemPercent(3)
  if global.bNightmareMode=0
  {
    if itemC_HeartP=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+49,textColorMain,textColorShadow,1)}
    else {textDropShadow("Heart Pieces",contentMenuX+120,contentMenuY+49,textColorMain,textColorShadow,1)}
    if itemC_Chest=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+60,textColorMain,textColorShadow,1)}
    else {textDropShadow("Treasure Chests",contentMenuX+120,contentMenuY+60,textColorMain,textColorShadow,1)}
    if itemC_Arrow=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+71,textColorMain,textColorShadow,1)}
    else {textDropShadow("Quiver Upgrade",contentMenuX+120,contentMenuY+71,textColorMain,textColorShadow,1)}
    if itemC_HeartE=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+82,textColorMain,textColorShadow,1)}
    else {textDropShadow("Heart Energy",contentMenuX+120,contentMenuY+82,textColorMain,textColorShadow,1)}
    if itemC_Missile=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+93,textColorMain,textColorShadow,1)}
    else {textDropShadow("Missile Tanks",contentMenuX+120,contentMenuY+93,textColorMain,textColorShadow,1)}
    if itemC_Ki=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+104,textColorMain,textColorShadow,1)}
    else {textDropShadow("Game Power",contentMenuX+120,contentMenuY+104,textColorMain,textColorShadow,1)}
    if itemC_Air=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+115,textColorMain,textColorShadow,1)}
    else {textDropShadow("Air Upgrade",contentMenuX+120,contentMenuY+115,textColorMain,textColorShadow,1)}
    if itemC_Wallet=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+126,textColorMain,textColorShadow,1)}
    else {textDropShadow("Wallet Boost",contentMenuX+120,contentMenuY+126,textColorMain,textColorShadow,1)}
    if itemC_Weapon=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+137,textColorMain,textColorShadow,1)}
    else {textDropShadow("Weapon Boost",contentMenuX+120,contentMenuY+137,textColorMain,textColorShadow,1)}
    if itemC_AP=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+148,textColorMain,textColorShadow,1)}
    else {textDropShadow("Skill Boost",contentMenuX+120,contentMenuY+148,textColorMain,textColorShadow,1)}
    if itemC_Extra=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+159,textColorMain,textColorShadow,1)}
    else {textDropShadow("Extra Stuff",contentMenuX+120,contentMenuY+159,textColorMain,textColorShadow,1)}
    draw_set_halign(fa_right)
    textDropShadow(string(itemC_HeartP) +string("/44"),contentMenuX+251,contentMenuY+49,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Chest) +string("/77"),contentMenuX+251,contentMenuY+60,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Arrow) +string("/30"),contentMenuX+251,contentMenuY+71,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_HeartE) +string("/28"),contentMenuX+251,contentMenuY+82,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Missile) +string("/30"),contentMenuX+251,contentMenuY+93,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Ki) +string("/50"),contentMenuX+251,contentMenuY+104,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Air) +string("/10"),contentMenuX+251,contentMenuY+115,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Wallet) +string("/20"),contentMenuX+251,contentMenuY+126,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Weapon) +string("/120"),contentMenuX+251,contentMenuY+137,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_AP) +string("/100"),contentMenuX+251,contentMenuY+148,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Extra) +string("/13"),contentMenuX+251,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  else
  {
    var tNightCheeseX,tNightCheeseY;
    tNightCheeseX=contentMenuX+180
    tNightCheeseY=contentMenuY+104
    draw_sprite_ext(sNightmareCheese,0,tNightCheeseX,tNightCheeseY,1,1,0,c_white,0.2)
    draw_sprite_ext(sNightmareCheese,0,tNightCheeseX-40,tNightCheeseY-40,1,1,0,c_white,0.2)
    draw_sprite_ext(sNightmareCheese,0,tNightCheeseX+40,tNightCheeseY-40,1,1,0,c_white,0.2)
    draw_sprite_ext(sNightmareCheese,0,tNightCheeseX+40,tNightCheeseY+40,1,1,0,c_white,0.2)
    draw_sprite_ext(sNightmareCheese,0,tNightCheeseX-40,tNightCheeseY+40,1,1,0,c_white,0.2)
    
    if itemC_HeartP=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+49,textColorMain,textColorShadow,1)}
    else {textDropShadow("Parmesan Cheese",contentMenuX+120,contentMenuY+49,textColorMain,textColorShadow,1)}
    if itemC_Chest=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+60,textColorMain,textColorShadow,1)}
    else {textDropShadow("Monterey Jack",contentMenuX+120,contentMenuY+60,textColorMain,textColorShadow,1)}
    if itemC_Arrow=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+71,textColorMain,textColorShadow,1)}
    else {textDropShadow("Gouda Cheese",contentMenuX+120,contentMenuY+71,textColorMain,textColorShadow,1)}
    if itemC_HeartE=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+82,textColorMain,textColorShadow,1)}
    else {textDropShadow("Cheddar Cheese",contentMenuX+120,contentMenuY+82,textColorMain,textColorShadow,1)}
    if itemC_Missile=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+93,textColorMain,textColorShadow,1)}
    else {textDropShadow("Feta Cheese",contentMenuX+120,contentMenuY+93,textColorMain,textColorShadow,1)}
    if itemC_Ki=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+104,textColorMain,textColorShadow,1)}
    else {textDropShadow("Mozzarella",contentMenuX+120,contentMenuY+104,textColorMain,textColorShadow,1)}
    if itemC_Air=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+115,textColorMain,textColorShadow,1)}
    else {textDropShadow("Asiago Cheese",contentMenuX+120,contentMenuY+115,textColorMain,textColorShadow,1)}
    if itemC_Wallet=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+126,textColorMain,textColorShadow,1)}
    else {textDropShadow("Blue Cheese",contentMenuX+120,contentMenuY+126,textColorMain,textColorShadow,1)}
    if itemC_Weapon=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+137,textColorMain,textColorShadow,1)}
    else {textDropShadow("Cream Cheese",contentMenuX+120,contentMenuY+137,textColorMain,textColorShadow,1)}
    if itemC_AP=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+148,textColorMain,textColorShadow,1)}
    else {textDropShadow("Swiss Cheese",contentMenuX+120,contentMenuY+148,textColorMain,textColorShadow,1)}
    if itemC_Extra=0 {textDropShadow("?????",contentMenuX+120,contentMenuY+159,textColorMain,textColorShadow,1)}
    else {textDropShadow("Goat Cheese",contentMenuX+120,contentMenuY+159,textColorMain,textColorShadow,1)}
    draw_set_halign(fa_right)
    textDropShadow(string(itemC_HeartP) +string("/44"),contentMenuX+251,contentMenuY+49,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Chest) +string("/77"),contentMenuX+251,contentMenuY+60,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Arrow) +string("/30"),contentMenuX+251,contentMenuY+71,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_HeartE) +string("/28"),contentMenuX+251,contentMenuY+82,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Missile) +string("/30"),contentMenuX+251,contentMenuY+93,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Ki) +string("/50"),contentMenuX+251,contentMenuY+104,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Air) +string("/10"),contentMenuX+251,contentMenuY+115,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Wallet) +string("/20"),contentMenuX+251,contentMenuY+126,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Weapon) +string("/120"),contentMenuX+251,contentMenuY+137,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_AP) +string("/100"),contentMenuX+251,contentMenuY+148,textColorMain,textColorShadow,1)
    textDropShadow(string(itemC_Extra) +string("/13"),contentMenuX+251,contentMenuY+159,textColorMain,textColorShadow,1)
  }
  
  //----- Display Play Time -----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+257,contentMenuY+16,contentMenuX+315,contentMenuY+41,1)
  draw_set_halign(fa_center)
  textDropShadow("Play Time",contentMenuX+287,contentMenuY+17,textColorMain,textColorShadow,1)
  var tMinuteZ, tSecondZ;
  if global.playTimeMinute<10 {tMinuteZ="0"}
  else {tMinuteZ=""}
  if global.playTimeSecond<10 {tSecondZ="0"}
  else {tSecondZ=""}
  textDropShadow(string(global.playTimeHour) +string(":") +string(tMinuteZ) +string(global.playTimeMinute) +string(":") +string(tSecondZ) +string(global.playTimeSecond),contentMenuX+287,contentMenuY+28,textColorMain,textColorShadow,1)
  
  //----- Display Max Air -----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+257,contentMenuY+45,contentMenuX+315,contentMenuY+63,1)
  draw_sprite(sAirUpgrade,0,contentMenuX+265,contentMenuY+46)
  textDropShadow(round(global.pBreathMax/30),contentMenuX+300,contentMenuY+48,textColorMain,textColorShadow,1)
  
  //----- Display Heart Pieces and Keys -----
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+257,contentMenuY+67,contentMenuX+315,contentMenuY+94,1)
  draw_line(contentMenuX+286,contentMenuY+67,contentMenuX+286,contentMenuY+94)
  draw_sprite(sPauseM_HeartPiece,global.pHeartPieces,contentMenuX+272,contentMenuY+81)
  draw_sprite(sDoorKey,0,contentMenuX+300,contentMenuY+81)
  draw_set_halign(fa_left)
  textDropShadow(global.pKeys,contentMenuX+306,contentMenuY+81,textColorMain,textColorShadow,1)
  
  //----- Display Bestiary % -----
  /*
  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+257,contentMenuY+45,contentMenuX+315,contentMenuY+70,1)
  textDropShadow("Bestiary",contentMenuX+287,contentMenuY+46,textColorMain,textColorShadow,1)
  var tBestiaryCheck;
  tBestiaryCheck=0
  textDropShadow(string("-") +string(tBestiaryCheck) +string("%-"),contentMenuX+287,contentMenuY+57,textColorMain,textColorShadow,1)*/
  
  //----- Recognitions (Ba-Donks) -----
  /*draw_set_color(textColorShadow)
  draw_set_halign(fa_center)
  draw_rectangle(contentMenuX+257,contentMenuY+127,contentMenuX+315,contentMenuY+152,1)
  textDropShadow("Ba-Donks",contentMenuX+287,contentMenuY+128,textColorMain,textColorShadow,1)
  var tRecognitionCheck;
  tRecognitionCheck=0
  for(i=0;i<50;i+=1)
  {
    indexCheck=string_char_at(global.tokenRecognitions,i+1); if indexCheck="1" {tRecognitionCheck+=1}
  }
  textDropShadow(string(tRecognitionCheck) +string(" / 50"),contentMenuX+287,contentMenuY+139,textColorMain,textColorShadow,1)*/
}
