#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bConsoleOn=0
consoleAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
consoleAnim+=0.15

if bConsoleOn=1
{
  if oKeyCodes.kCodePressed[6]=1
  {
    resetKeyCodes()
    depth=50; oPlayer1.visible=1
    global.gamePaused=0
    bConsoleOn=0
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Metroid command console script.
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if bConsoleOn=0 {bConsoleOn=1}
  else {bConsoleOn=0}
  depth=0; oPlayer1.visible=0
  global.gamePaused=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,0,x,y)
draw_sprite(sGateItemLightsA,consoleAnim,x-13,y-14)
draw_sprite(sGateItemLightsB,consoleAnim,x-2,y-23)

if bConsoleOn=1
{
  mainX=view_xview[0]+96
  mainY=view_yview[0]+80

  draw_set_color(c_black)
  draw_set_alpha(1)
  draw_rectangle(mainX+1,mainY+1,mainX+270,mainY+182,0)

  draw_background_part(tileUtilColLoc,0,0,8,8,mainX,mainY) //top-left
  draw_background_part(tileUtilColLoc,16,0,8,8,mainX+264,mainY) //top-right
  draw_background_part(tileUtilColLoc,0,16,8,8,mainX,mainY+176) //bottom-left
  draw_background_part(tileUtilColLoc,16,16,8,8,mainX+264,mainY+176) //bottom-right
  for(i=0;i<32;i+=1) {draw_background_part(tileUtilColLoc,8,0,8,8,mainX+8+(i*8),mainY)} //top
  for(i=0;i<32;i+=1) {draw_background_part(tileUtilColLoc,8,16,8,8,mainX+8+(i*8),mainY+176)} //bottom
  for(i=0;i<21;i+=1) {draw_background_part(tileUtilColLoc,0,8,8,8,mainX,mainY+8+(i*8))} //left
  for(i=0;i<21;i+=1) {draw_background_part(tileUtilColLoc,16,8,8,8,mainX+264,mainY+8+(i*8))} //right

  draw_set_color(c_white)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  draw_text(mainX+136,mainY+11,"<<ITEMS IN THIS GATE>>")
  draw_line(mainX+14,mainY+20,mainX+258,mainY+20)
  draw_set_halign(fa_left)
  if gateNum=1 //----------------------------------------------------------------------
  {
    var indexCheck,item_NumA,item_NumB,item_NumC;
    item_NumA=0; item_NumB=0; item_NumC=0;
    indexCheck=string_char_at(global.heartPiece,3); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartPiece,4); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.chestMoney,2); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.chestMoney,56); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.chestMoney,62); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartPiece,5); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,3); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,4); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartPiece,6); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.chestMoney,5); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.chestMoney,63); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.arrowQuiver,25); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.walletBoost,19); if indexCheck="1" {item_NumC+=1}
    draw_text(mainX+14,mainY+24,">UP TO TOAD HUT")
    draw_text(mainX+14,mainY+40,">ROAD TO HAMMER BRO FORT")
    draw_text(mainX+14,mainY+56,">TO CACKLETTA CASTLE")
    draw_set_halign(fa_right)
    draw_text(mainX+258,mainY+32,string(item_NumA) +string("/5"))
    draw_text(mainX+258,mainY+48,string(item_NumB) +string("/3"))
    draw_text(mainX+258,mainY+64,string(item_NumC) +string("/5"))
  }
  else if gateNum=2 //----------------------------------------------------------------------
  {
    var indexCheck,item_NumA,item_NumB,item_NumC,item_NumD,item_NumE,item_NumF;
    item_NumA=0; item_NumB=0; item_NumC=0; item_NumD=0; item_NumE=0; item_NumF=0
    indexCheck=string_char_at(global.heartPiece,9); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.chestMoney,7); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.arrowQuiver,2); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.arrowQuiver,3); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.arrowQuiver,11); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartPiece,11); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,9); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,10); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.arrowQuiver,5); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.arrowQuiver,6); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.arrowQuiver,7); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.arrowQuiver,12); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.walletBoost,4); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartPiece,10); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.chestMoney,8); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.arrowQuiver,4); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.arrowQuiver,8); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.airUpgrade,1); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.airUpgrade,2); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.airUpgrade,3); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.airUpgrade,4); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.weaponLevels,1); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,2); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,3); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,4); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,11); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,12); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,13); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,14); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,21); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,22); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,23); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,24); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.weaponBoosts,2); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponBoosts,3); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponBoosts,4); if indexCheck="1" {item_NumD+=1}
    draw_text(mainX+14,mainY+24,">OVERWORLD A")
    draw_text(mainX+14,mainY+40,">OVERWORLD B")
    draw_text(mainX+14,mainY+56,">DESERT PALACE")
    draw_text(mainX+14,mainY+72,">FOREST PALACE")
    draw_text(mainX+14,mainY+88,">GREAT PALACE")
    draw_text(mainX+14,mainY+104,">WATER PALACE (ARGH)")
    draw_set_halign(fa_right)
    draw_text(mainX+258,mainY+32,string(item_NumA) +string("/9"))
    draw_text(mainX+258,mainY+48,string(item_NumB) +string("/12"))
    draw_text(mainX+258,mainY+64,string(item_NumC) +string("/1"))
    draw_text(mainX+258,mainY+80,string(item_NumD) +string("/5"))
    draw_text(mainX+258,mainY+96,string(item_NumE) +string("/4"))
    draw_text(mainX+258,mainY+112,string(item_NumF) +string("/5"))
  }
  else if gateNum=3 //----------------------------------------------------------------------
  {
    var indexCheck,item_NumA,item_NumB,item_NumC,item_NumD,item_NumE,item_NumF,item_NumG;
    item_NumA=0; item_NumB=0; item_NumC=0; item_NumD=0; item_NumE=0; item_NumF=0; item_NumF=0; item_NumG=0
    indexCheck=string_char_at(global.heartEnergy,4); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartEnergy,5); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartEnergy,19); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.chestMoney,20); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.heartEnergy,6); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.heartEnergy,13); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.heartPiece,13); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.chestMoney,15); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartEnergy,7); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartEnergy,8); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartEnergy,9); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartEnergy,10); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.airUpgrade,5); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartPiece,14); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.heartPiece,24); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.chestMoney,16); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.chestMoney,17); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.chestMoney,18); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.heartEnergy,11); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.heartEnergy,12); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.heartEnergy,14); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.chestMoney,19); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.chestMoney,42); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.arrowQuiver,13); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.heartEnergy,15); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.heartEnergy,16); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.heartEnergy,28); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.heartEnergy,17); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.heartEnergy,18); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.weaponLevels,31); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,32); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,33); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,34); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.weaponLevels,35); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.weaponLevels,41); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,42); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,43); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,44); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,45); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.weaponLevels,51); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,52); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,53); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,54); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,55); if indexCheck="1" {item_NumG+=1}
    draw_text(mainX+14,mainY+24,">CASTLE HALLS")
    draw_text(mainX+14,mainY+40,">CASTLE DUNGEON")
    draw_text(mainX+14,mainY+56,">CASTLE INNER SANCTUM")
    draw_text(mainX+14,mainY+72,">CASTLE CORRIDOR")
    draw_text(mainX+14,mainY+88,">CASTLE COURTYARD")
    draw_text(mainX+14,mainY+104,">SKY CASTLE")
    draw_text(mainX+14,mainY+120,">REAPER'S HALL")
    draw_set_halign(fa_right)
    draw_text(mainX+258,mainY+32,string(item_NumA) +string("/3"))
    draw_text(mainX+258,mainY+48,string(item_NumB) +string("/3"))
    draw_text(mainX+258,mainY+64,string(item_NumC) +string("/6"))
    draw_text(mainX+258,mainY+80,string(item_NumD) +string("/10"))
    draw_text(mainX+258,mainY+96,string(item_NumE) +string("/10"))
    draw_text(mainX+258,mainY+112,string(item_NumF) +string("/7"))
    draw_text(mainX+258,mainY+128,string(item_NumG) +string("/5"))
  }
  else if gateNum=5 //----------------------------------------------------------------------
  {
    var indexCheck,item_NumA,item_NumB,item_NumC,item_NumD,item_NumE;
    item_NumA=0; item_NumB=0; item_NumC=0; item_NumD=0; item_NumE=0
    indexCheck=string_char_at(global.missilePack,13); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.missilePack,15); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.missilePack,22); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponBoosts,6); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartPiece,28); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartPiece,30); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,43); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.chestMoney,44); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,1); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,2); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,4); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,16); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,17); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,18); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,19); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.missilePack,20); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponBoosts,10); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartPiece,29); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.missilePack,9); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.missilePack,10); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.missilePack,23); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.missilePack,24); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.chestMoney,45); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.missilePack,11); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.missilePack,14); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.missilePack,21); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.missilePack,25); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.airUpgrade,8); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponBoosts,7); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponBoosts,8); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponBoosts,9); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.heartPiece,31); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,91); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,92); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,93); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,94); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,95); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,96); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,101); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.weaponLevels,102); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,103); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,104); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,105); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,106); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.weaponLevels,111); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,112); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,113); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.weaponLevels,114); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.weaponLevels,115); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.weaponLevels,116); if indexCheck="1" {item_NumE+=1}
    if global.metSpringBall=1 {item_NumA+=1}
    draw_text(mainX+14,mainY+24,">CENTRAL FACILITY")
    draw_text(mainX+14,mainY+40,">SECTOR 1 (BRINSTAR)")
    draw_text(mainX+14,mainY+56,">SECTOR 2 (NORFAIR)")
    draw_text(mainX+14,mainY+72,">SECTOR 3 (MARIDIA)")
    draw_text(mainX+14,mainY+88,">TOURIAN")
    draw_set_halign(fa_right)
    draw_text(mainX+258,mainY+32,string(item_NumA) +string("/6"))
    draw_text(mainX+258,mainY+48,string(item_NumB) +string("/16"))
    draw_text(mainX+258,mainY+64,string(item_NumC) +string("/12"))
    draw_text(mainX+258,mainY+80,string(item_NumD) +string("/13"))
    draw_text(mainX+258,mainY+96,string(item_NumE) +string("/4"))
  }
  else if gateNum=6 //----------------------------------------------------------------------
  {
    var indexCheck,item_NumA,item_NumB,item_NumC,item_NumD,item_NumE,item_NumF,item_NumG,item_NumH,item_NumI;
    item_NumA=0; item_NumB=0; item_NumC=0; item_NumD=0; item_NumE=0; item_NumF=0; item_NumG=0; item_NumH=0; item_NumI=0
    indexCheck=string_char_at(global.chestMoney,65); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.kiEnergy,1); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.kiEnergy,2); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.kiEnergy,3); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.kiEnergy,4); if indexCheck="1" {item_NumA+=1}
    indexCheck=string_char_at(global.heartPiece,33); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,5); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,6); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,7); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,8); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,9); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,10); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,11); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.kiEnergy,12); if indexCheck="1" {item_NumB+=1}
    indexCheck=string_char_at(global.heartPiece,40); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.kiEnergy,13); if indexCheck="1" {item_NumC+=1}
    indexCheck=string_char_at(global.kiEnergy,14); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.kiEnergy,15); if indexCheck="1" {item_NumD+=1}
    indexCheck=string_char_at(global.kiEnergy,16); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,17); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,18); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,19); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,20); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,21); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,22); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,23); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,24); if indexCheck="1" {item_NumE+=1}
    indexCheck=string_char_at(global.kiEnergy,25); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.kiEnergy,26); if indexCheck="1" {item_NumF+=1}
    indexCheck=string_char_at(global.kiEnergy,27); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,28); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,29); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,30); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,31); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,32); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,33); if indexCheck="1" {item_NumG+=1}
    indexCheck=string_char_at(global.kiEnergy,34); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,35); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,36); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,37); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,38); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,39); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,40); if indexCheck="1" {item_NumH+=1}
    indexCheck=string_char_at(global.kiEnergy,41); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,42); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,43); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,44); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,45); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,46); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,47); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,48); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,49); if indexCheck="1" {item_NumI+=1}
    indexCheck=string_char_at(global.kiEnergy,50); if indexCheck="1" {item_NumI+=1}
    draw_text(mainX+14,mainY+24,">HERO PLAINS")
    draw_text(mainX+14,mainY+40,">EARTH TEMPLE")
    draw_text(mainX+14,mainY+56,">FIRE TEMPLE")
    draw_text(mainX+14,mainY+72,">WATER TEMPLE")
    draw_text(mainX+14,mainY+88,">WIND TEMPLE")
    draw_text(mainX+14,mainY+104,">DREAM WOODS")
    draw_text(mainX+14,mainY+120,">PARADISE ISLAND")
    draw_text(mainX+14,mainY+136,">CAVE OF TREASURE")
    draw_text(mainX+14,mainY+152,">CASTLE OF DOOM")
    draw_set_halign(fa_right)
    draw_text(mainX+258,mainY+32,string(item_NumA) +string("/5"))
    draw_text(mainX+258,mainY+48,string(item_NumB) +string("/9"))
    draw_text(mainX+258,mainY+64,string(item_NumC) +string("/2"))
    draw_text(mainX+258,mainY+80,string(item_NumD) +string("/2"))
    draw_text(mainX+258,mainY+96,string(item_NumE) +string("/9"))
    draw_text(mainX+258,mainY+112,string(item_NumF) +string("/2"))
    draw_text(mainX+258,mainY+128,string(item_NumG) +string("/7"))
    draw_text(mainX+258,mainY+144,string(item_NumH) +string("/7"))
    draw_text(mainX+258,mainY+160,string(item_NumI) +string("/10"))
  }
}
