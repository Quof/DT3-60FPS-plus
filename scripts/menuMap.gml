/*
This script is called in the HUD pause menu and is an extension of it
It is used to display the map submenu
argument0: Display type
-- 0: From pause menu
-- 1: From teleport menu
*/
var tMenuType; tMenuType=argument0

if tMenuType=1
{
  contentMenuX=view_xview[0]+69
  contentMenuY=view_yview[0]+82
}

draw_sprite(sPauseM_MapGrid,0,contentMenuX-3,contentMenuY+14)
draw_sprite(sPauseM_MapTop,0,contentMenuX-3,contentMenuY+14)
draw_sprite_ext(sPauseM_MapTop,0,contentMenuX+325,contentMenuY+14,-1,1,0,c_white,1)
draw_sprite(sPauseM_MapBottom,0,contentMenuX-3,contentMenuY+166)
draw_sprite_ext(sPauseM_MapBottom,0,contentMenuX+325,contentMenuY+166,-1,1,0,c_white,1)
draw_sprite(sPauseM_MapSide,0,contentMenuX-3,contentMenuY+27)
draw_sprite_ext(sPauseM_MapSide,0,contentMenuX+325,contentMenuY+27,-1,1,0,c_white,1)
draw_set_color(c_black)
draw_set_alpha(1)
draw_line(contentMenuX+101,contentMenuY+174,contentMenuX+229,contentMenuY+174)
if tMenuType=0 //-------------------- Display map controls --------------------
{
  if subMenu=4
  {
    draw_set_font(fnt_StatRender)
    draw_set_halign(fa_left)
    draw_text(contentMenuX+1,contentMenuY+13,"U")
    draw_text(contentMenuX+21,contentMenuY+13,"Prev")
    draw_text(contentMenuX+316,contentMenuY+13,"I")
    draw_text(contentMenuX+281,contentMenuY+13,"Next")

    draw_set_color(make_color_rgb(255,248,155))
    draw_set_halign(fa_center)
    var tTopMapLoc;
    tTopMapLoc=""
    if mMap_Submenu=1 {tTopMapLoc="MAINLAND"}
    else if mMap_Submenu=2 or mMap_Submenu=3 {tTopMapLoc="GATE 2 - HYRULE"}
    draw_text(contentMenuX+160,contentMenuY+14,tTopMapLoc)
  }
}

if mMap_Submenu=1
{
  if subMenu=4 //-------------------- Find map slot info --------------------
  {
    if tMenuType=0
    {
      area_Name=""
      item_Num=0
      item_Max=0
      menuInfoText=""
      mapDetails=0
      coll_HeartP=0
      coll_Chest=0
      coll_Arrow=0
      coll_HeartE=0
      coll_Missile=0
      coll_Ki=0
      coll_Air=0
      coll_Wallet=0
      coll_Weapon=0
      coll_AP=0
      coll_Extra=0
      max_HeartP=0
      max_Chest=0
      max_Arrow=0
      max_HeartE=0
      max_Missile=0
      max_Ki=0
      max_Air=0
      max_Wallet=0
      max_Weapon=0
      max_AP=0
      max_Extra=0
      if mapIndexCheck[1]="1" and mMap_CurX=7 and mMap_CurY>=7 and mMap_CurY<=9
      {
        mapDetails=1
        max_HeartP=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.heartPiece,1); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,1); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Grand Rising"
        menuInfoText="A tower that reaches high into the skies. Great treasures are said to lie in wait at the top of this tower, now in ruin due to time."
      }
      else if mapIndexCheck[2]="1" and mMap_CurX>=8 and mMap_CurX<=9 and mMap_CurY=9
      {
        mapDetails=2
        max_HeartP=1; max_AP=1; max_Weapon=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.heartPiece,2); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,84); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,6); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Initiate's Pass - West"
        menuInfoText="A stretch of land nearly untouched. It holds the remains of the Grand Rising after its fall."
      }
      else if mapIndexCheck[3]="1" and mMap_CurX=10 and mMap_CurY>=8 and mMap_CurY<=9
      {
        mapDetails=3
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,39); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Initiate's Pass - Central"
        menuInfoText="A small tower like structure in the heart of the Initiate's Pass."
      }
      else if mapIndexCheck[4]="1" and mMap_CurX>=11 and mMap_CurX<=12 and mMap_CurY>=8 and mMap_CurY<=9
      {
        mapDetails=4
        max_AP=2
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,40); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,85); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Initiate's Pass - East"
        menuInfoText="A piece of the Initiate's Pass which holds magical properties... Actually all of the Pass holds magical properties."
      }
      else if mapIndexCheck[5]="1" and mMap_CurX>=13 and mMap_CurX<=15 and mMap_CurY>=8 and mMap_CurY<=9
      {
        mapDetails=5
        max_Chest=1; max_Arrow=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,1); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,10); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,27); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        area_Name="Stratum Steppe"
        menuInfoText="An expansive layered field laying to the west of the main quint. It has many qualities of the Initiate's Pass."
      }
      else if mapIndexCheck[6]="1" and mMap_CurX=14 and mMap_CurY=7
      {
        mapDetails=6
        max_Chest=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.chestMoney,14); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        area_Name="Stratum Steppe Alcove"
        menuInfoText="A small area near the top of the Stratum Steppe that's not really an alcove."
      }
      else if mapIndexCheck[7]="1" and mMap_CurX=13 and mMap_CurY=7
      {
        mapDetails=7
        max_HeartP=4; max_Chest=7; max_Arrow=1; max_Wallet=1
        var indexCheck; item_Max=13
        indexCheck=string_char_at(global.heartPiece,3); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,4); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,5); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,6); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,2); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,3); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,4); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,5); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,56); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,62); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,63); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,25); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.walletBoost,19); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Access Gate 1"
        menuInfoText="The Mushroom Kingdom, home to the Mario brothers, Princess Peach, and Bowser."
      }
      else if mapIndexCheck[8]="1" and mMap_CurX>=16 and mMap_CurX<=19 and mMap_CurY>=7 and mMap_CurY<=9
      {
        mapDetails=8
        max_HeartP=1; max_Chest=1; max_Arrow=1; max_AP=2; max_Weapon=1
        var indexCheck; item_Max=6
        indexCheck=string_char_at(global.heartPiece,7); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,6); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,1); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.apBoost,2); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,23); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,87); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Greatest Stretch"
        menuInfoText="A large and majestic stretch of land that reaches far and wide. Even reaching out to the legendary Starry Skies to the north."
      }
      else if mapIndexCheck[9]="1" and mMap_CurX>=19 and mMap_CurX<=20 and mMap_CurY=10
      {
        mapDetails=9
        max_HeartP=2; max_Chest=1; max_Arrow=1; max_HeartE=1; max_Wallet=3; max_AP=6; max_Weapon=1
        var indexCheck; item_Max=15
        indexCheck=string_char_at(global.heartPiece,8); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,34); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,11); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,24); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.heartEnergy,1); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.walletBoost,5); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.walletBoost,9); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.walletBoost,15); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,20); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,21); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,22); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,51); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,52); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,53); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,77); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Central City - North"
        menuInfoText="A grand city which lies in the center of the digital mainland and home to both humans and bots. The north is largely a residentally zoned area."
      }
      else if mapIndexCheck[10]="1" and mMap_CurX=15 and mMap_CurY=7
      {
        mapDetails=10
        max_HeartP=3; max_Chest=4; max_Arrow=9; max_Air=4; max_Wallet=1; max_Weapon=12; max_Extra=3
        var indexCheck; item_Max=36
        indexCheck=string_char_at(global.heartPiece,9); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,10); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,11); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,7); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,8); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,9); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,10); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,2); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,3); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,4); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,5); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,6); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,7); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,8); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,11); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,12); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.airUpgrade,1); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.airUpgrade,2); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.airUpgrade,3); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.airUpgrade,4); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.walletBoost,4); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.weaponLevels,1); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,2); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,3); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,4); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,11); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,12); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,13); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,14); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,21); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,22); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,23); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,24); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponBoosts,2); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,3); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,4); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        area_Name="Access Gate 2"
        menuInfoText="Hyrule, a kingdom of peace and prosperity ruled over by the watchful eye of Princess Zelda."
      }
      else if mapIndexCheck[11]="1" and mMap_CurX>=20 and mMap_CurX<=23 and mMap_CurY>=8 and mMap_CurY<=9
      {
        mapDetails=11
        max_Chest=1; max_HeartE=1; max_AP=3; max_Weapon=1
        var indexCheck; item_Max=6
        indexCheck=string_char_at(global.chestMoney,12); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.heartEnergy,3); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.apBoost,4); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,5); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,24); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,16); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Magical Hills - West"
        menuInfoText="A magical array of hills and trees that hide many secrets both above and below the clouds."
      }
      else if mapIndexCheck[12]="1" and mMap_CurX>=24 and mMap_CurX<=25 and mMap_CurY=8
      {
        mapDetails=12
        max_Arrow=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.arrowQuiver,9); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.apBoost,87); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Treetops"
        menuInfoText="A set of magical tree tops and stumps serving as a pathway leading deeper into the forest."
      }
      else if mapIndexCheck[13]="1" and mMap_CurX=26 and mMap_CurY>=7 and mMap_CurY<=8
      {
        mapDetails=13
        max_HeartP=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.heartPiece,12); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,6); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Tree Tower"
        menuInfoText="These large branches stretch high above the Magical Hills. It is said that one of the three dark secrets are close by."
      }
      else if mapIndexCheck[14]="1" and mMap_CurX>=27 and mMap_CurX<=28 and mMap_CurY>=7 and mMap_CurY<=8
      {
        mapDetails=14
        max_HeartP=1; max_Chest=1; max_AP=2
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.heartPiece,41); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,66); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,7); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,76); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Canopy"
        menuInfoText="This small canopy holds perilous traps and a few secrety secrets. Not many come to this place."
      }
      else if mapIndexCheck[15]="1" and mMap_CurX=29 and mMap_CurY=7
      {
        mapDetails=15
        max_HeartP=3; max_Chest=7; max_Arrow=1; max_HeartE=17; max_Air=1; max_Weapon=15
        var indexCheck; item_Max=44
        indexCheck=string_char_at(global.heartPiece,13); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,14); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,24); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,15); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,16); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,17); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,18); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,19); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,20); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,42); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,13); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.heartEnergy,4); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,5); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,6); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,7); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,8); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,9); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,10); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,11); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,12); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,13); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,14); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,15); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,16); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,17); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,18); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,19); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,28); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.airUpgrade,5); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.weaponLevels,31); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,32); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,33); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,34); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,35); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,41); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,42); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,43); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,44); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,45); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,51); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,52); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,53); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,54); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,55); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Access Gate 3"
        menuInfoText="Transylvania is home to Dracula's castle, a large formidable fortress. Though the formidable part is questionable considering how many times it has been successfully infiltrated by vampire hunters."
      }
      else if mapIndexCheck[16]="1" and mMap_CurX>=26 and mMap_CurX<=28 and mMap_CurY=9
      {
        mapDetails=16
        max_Chest=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.chestMoney,13); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        area_Name="Magical Underbrush"
        menuInfoText="A little area under the woods which holds a cursed secret. Not many find this mythical place."
      }
      else if mapIndexCheck[17]="1" and mMap_CurX>=24 and mMap_CurX<=25 and mMap_CurY>=9 and mMap_CurY<=10
      {
        mapDetails=17
        max_HeartE=1; max_Missile=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.heartEnergy,20); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.missilePack,27); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        area_Name="Magical Hills - East"
        menuInfoText="An area of the Magical Woods that holds nothing all that substantial other than leading to a place known as the Farreaches."
      }
      else if mapIndexCheck[18]="1" and mMap_CurX>=10 and mMap_CurX<=12 and mMap_CurY=7
      {
        mapDetails=18
        max_Missile=2; max_Air=1; max_AP=4; max_Wallet=1
        var indexCheck; item_Max=8
        indexCheck=string_char_at(global.missilePack,3); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,29); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.airUpgrade,10); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.apBoost,3); if indexCheck="1" {item_Num+=1;coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,75); if indexCheck="1" {item_Num+=1;coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,77); if indexCheck="1" {item_Num+=1;coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,80); if indexCheck="1" {item_Num+=1;coll_AP+=1}
        indexCheck=string_char_at(global.walletBoost,20); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Initiate's Overpass"
        menuInfoText="A stretch of land laying north of the central pass at the top of a small tower. Here lies a secret awaiting discovery."
      }
      else if mapIndexCheck[19]="1" and mMap_CurX>=13 and mMap_CurX<=14 and mMap_CurY=10
      {
        mapDetails=19
        max_Chest=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.chestMoney,21); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        area_Name="Lost Entrance"
        menuInfoText="The lost entrance to a great and forgotten temple which holds the secrets behind a most fearsome beast."
      }
      else if mapIndexCheck[20]="1" and mMap_CurX>=15 and mMap_CurX<=18 and mMap_CurY>=10 and mMap_CurY<=12
      {
        mapDetails=20
        max_Chest=1; max_Arrow=1; max_Air=1; max_Wallet=1; max_AP=3; max_Weapon=1
        var indexCheck; item_Max=8
        indexCheck=string_char_at(global.chestMoney,22); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,18); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.airUpgrade,6); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.walletBoost,17); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,9); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,10); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,25); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,26); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Begonia - Beach"
        menuInfoText="A not-very-classy beach located just next to Central City. Quite a convenient location... if only going to the beach didn't include a 61 ft drop."
      }
      else if mapIndexCheck[21]="1" and mMap_CurX>=13 and mMap_CurX<=14 and mMap_CurY=11
      {
        mapDetails=21
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,11); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Dividing Pass"
        menuInfoText="A stretch of land which divides the beach from the mountains."
      }
      else if mapIndexCheck[22]="1" and mMap_CurX>=11 and mMap_CurX<=12 and mMap_CurY>=11 and mMap_CurY<=12
      {
        mapDetails=22
        max_HeartP=1; max_Arrow=1; max_AP=1; max_Weapon=1
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.heartPiece,16); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.arrowQuiver,15); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.apBoost,12); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,37); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Begonia - East Mountain"
        menuInfoText="The nice mountain overrun by monkeys and scorpions... Really, why would anyone come here?"
      }
      else if mapIndexCheck[23]="1" and mMap_CurX>=9 and mMap_CurX<=10 and mMap_CurY>=11 and mMap_CurY<=12
      {
        mapDetails=23
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,13); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - West Mountain"
        menuInfoText="A not so spectacular formation of rocks. In some cases, falling rocks and rock slides have been known to occur."
      }
      else if mapIndexCheck[24]="1" and mMap_CurX=8 and mMap_CurY=12
      {
        mapDetails=24
        max_Chest=2; max_HeartE=2; max_Air=1; max_Wallet=1; max_AP=1
        var indexCheck; item_Max=7
        indexCheck=string_char_at(global.chestMoney,23); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,24); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.heartEnergy,22); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.heartEnergy,23); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.airUpgrade,7); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.walletBoost,1); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,56); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Mountain Temple"
        menuInfoText="A non-forgotten temple that many simply don't visit... because it sucks."
      }
      else if mapIndexCheck[25]="1" and mMap_CurX>=16 and mMap_CurX<=18 and mMap_CurY=13
      {
        mapDetails=25
        max_HeartP=1; max_Chest=1; max_HeartE=1; max_AP=2
        var indexCheck; item_Max=5
        indexCheck=string_char_at(global.heartPiece,17); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,25); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.heartEnergy,2); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.apBoost,14); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,15); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Waterway Passage"
        menuInfoText="The waters of the Begonia beach aren't quite as peaceful as one would hope for. But hey, many treasures lay hidden."
      }
      else if mapIndexCheck[26]="1" and mMap_CurX=15 and mMap_CurY=13
      {
        mapDetails=26
        max_Wallet=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.walletBoost,3); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,16); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Watery Cave"
        menuInfoText="An incredibly moist cave holding a valuable secret."
      }
      else if mapIndexCheck[27]="1" and mMap_CurX>=13 and mMap_CurX<=14 and mMap_CurY>=12 and mMap_CurY<=13
      {
        mapDetails=27
        max_Chest=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,35); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,17); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,18); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Waterfront Blockage"
        menuInfoText="The place where the beach water awkwardly ends. The Virus placed a lock which blocks access to the western Floating Isles region."
      }
      else if mapIndexCheck[28]="1" and mMap_CurX>=10 and mMap_CurX<=12 and mMap_CurY>=13 and mMap_CurY<=14
      {
        mapDetails=28
        max_HeartP=1; max_Chest=1; max_Missile=1; max_AP=2
        var indexCheck; item_Max=5
        indexCheck=string_char_at(global.heartPiece,18); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,26); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.missilePack,5); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.apBoost,19); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,99); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Begonia - Floating Isles"
        menuInfoText="These magical floating isles used to be one giant land mass until a massive fissure caused it to break apart."
      }
      else if mapIndexCheck[29]="1" and mMap_CurX=9 and mMap_CurY=13
      {
        mapDetails=29
        max_HeartP=4; max_Chest=7; max_Arrow=1; max_HeartE=1; max_Missile=1; max_Wallet=1; max_Weapon=15; max_Extra=1
        var indexCheck; item_Max=31
        indexCheck=string_char_at(global.heartPiece,19); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,20); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,21); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,22); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,27); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,28); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,29); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,30); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,31); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,32); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,36); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,16); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.heartEnergy,24); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.missilePack,6); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.walletBoost,6); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.weaponLevels,61); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,62); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,63); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,64); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,65); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,71); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,72); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,73); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,74); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,75); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,81); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,82); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,83); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,84); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,85); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        item_Num+=global.hasBoostedXCharge; coll_Extra+=global.hasBoostedXCharge
        area_Name="Access Gate 4"
        menuInfoText="A massive city on an island just out of the mainland's reach. A once great zone, populated only by bots, now suffers from the Virus which strikes at the program's systems."
      }
      else if mapIndexCheck[30]="1" and mMap_CurX=26 and mMap_CurY=10
      {
        mapDetails=30
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,8); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Hills - Overstep"
        menuInfoText="The final step between the Farreaches and the world connecting to Central City. The area was previously unreachable by anything other than bots due to a data scrambling caused by the distortions from the Vault nearby."
      }
      else if mapIndexCheck[31]="1" and mMap_CurX>=27 and mMap_CurX<=28 and mMap_CurY=10
      {
        mapDetails=31
        max_AP=1; max_Weapon=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,26); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,47); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Farreaches - Extrapolate"
        menuInfoText="The first stretch of land known as the Farreaches. These lands are home to creatures who stand as guards to the Vault, though their numbers have dwindled as of late."
      }
      else if mapIndexCheck[32]="1" and mMap_CurX>=29 and mMap_CurX<=30 and mMap_CurY>=10 and mMap_CurY<=11
      {
        mapDetails=32
        max_HeartP=1; max_Chest=1; max_AP=2
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.heartPiece,37); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,33); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,27); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,28); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Anticipate"
        menuInfoText="A somewhat magical set of hills filled with secrets. Some secrets cursed and forbidden."
      }
      else if mapIndexCheck[33]="1" and mMap_CurX=28 and mMap_CurY=11
      {
        mapDetails=33
        max_Chest=1; max_Wallet=1; max_AP=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,34); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.walletBoost,8); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,29); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Perception"
        menuInfoText="A small grotto with a terrible secret, hidden away. Those unfortunate and perceptive enough to find it may or may not reap many rewards."
      }
      else if mapIndexCheck[34]="1" and mMap_CurX>=31 and mMap_CurX<=32 and mMap_CurY>=9 and mMap_CurY<=10
      {
        mapDetails=34
        max_Chest=1; max_Arrow=1; max_Missile=1; max_AP=3
        var indexCheck; item_Max=6
        indexCheck=string_char_at(global.chestMoney,64); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,17); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.missilePack,8); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.apBoost,30); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,31); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,32); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Bubble Tower"
        menuInfoText="In these plains and hills of the Farreaches lies a massive tower full of hidden treasures collected by the creatures who watch the Vault."
      }
      else if mapIndexCheck[35]="1" and mMap_CurX=32 and mMap_CurY>=11 and mMap_CurY<=12
      {
        mapDetails=35
        max_HeartP=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.heartPiece,23); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,33); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Contemplate"
        menuInfoText="These hills would often have been the cause of many broken ligaments if not for the world having no fall damage."
      }
      else if mapIndexCheck[36]="1" and mMap_CurX>=28 and mMap_CurX<=31 and mMap_CurY=12
      {
        mapDetails=36
        max_AP=2
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,34); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,35); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Envisage"
        menuInfoText="A long stretch of land with the nickname 'Lovers Trail'. The Guardians often used it for recreational purposes."
      }
      else if mapIndexCheck[37]="1" and mMap_CurX=31 and mMap_CurY=11
      {
        mapDetails=37
        max_Chest=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.chestMoney,51); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,36); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Foresight"
        menuInfoText="This hidden grotto lies above the breath taking view of the Envisage."
      }
      else if mapIndexCheck[38]="1" and mMap_CurX>=26 and mMap_CurX<=27 and mMap_CurY>=11 and mMap_CurY<=12
      {
        mapDetails=38
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,37); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Conceptualize"
        menuInfoText="A blob of mixed up land pieces all joined together creating a mini maze. The land used to be built in a kinder fashion, but the recent shortcomings on the Vault's lock have distorted this land."
      }
      else if mapIndexCheck[39]="1" and mMap_CurX=25 and mMap_CurY>=11 and mMap_CurY<=12
      {
        mapDetails=39
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,38); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Consciousness"
        menuInfoText="A near lifeless place whose data the Vault has jumbled up. Most do not come to this place as many have not returned."
      }
      else if mapIndexCheck[40]="1" and mMap_CurX=24 and mMap_CurY=11
      {
        mapDetails=40
        max_HeartP=1; max_Chest=2; max_Arrow=2; max_HeartE=1; max_Wallet=1
        var indexCheck; item_Max=7
        indexCheck=string_char_at(global.heartPiece,25); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,37); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,38); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,19); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.arrowQuiver,20); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.heartEnergy,25); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.walletBoost,10); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="The Vault"
        menuInfoText="The place where the program put all malicious and rogue bots. Due to the Virus, the Vault has not been functioning as intended, allowing bots to escape.#No further data is accessible for this area..."
      }
      else if mapIndexCheck[41]="1" and mMap_CurX>=19 and mMap_CurX<=20 and mMap_CurY=11
      {
        mapDetails=41
        max_HeartP=1; max_Chest=2; max_Arrow=1; max_HeartE=1; max_Missile=1; max_AP=2; max_Extra=1
        var indexCheck; item_Max=9
        indexCheck=string_char_at(global.heartPiece,27); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,39); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,40); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,21); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.heartEnergy,26); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.missilePack,12); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.apBoost,42); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,55); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        item_Num+=global.itemFinder; coll_Extra+=global.itemFinder
        area_Name="Central City - South"
        menuInfoText="A largely commercial-zoned district of Central City bustling with activity. Many have taken to riding the economic opportunities that have recently risen due to the restraints lifted in the program."
      }
      else if mapIndexCheck[42]="1" and mMap_CurX>=19 and mMap_CurX<=23 and mMap_CurY>=12 and mMap_CurY<=13
      {
        mapDetails=42
        max_HeartP=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.heartPiece,26); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,41); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,54); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Mid Waste"
        menuInfoText="What was once a large temple, is now covered in sand. Some of its ruin can still be seen laying about."
      }
      else if mapIndexCheck[43]="1" and mMap_CurX>=21 and mMap_CurX<=23 and mMap_CurY>=10 and mMap_CurY<=11
      {
        mapDetails=43
        max_Chest=2; max_Arrow=1; max_Missile=1; max_Weapon=1
        var indexCheck; item_Max=5
        indexCheck=string_char_at(global.chestMoney,41); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,71); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,30); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.missilePack,30); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.weaponLevels,67); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Barrens - Upper Waste"
        menuInfoText="Part of the large covered temple stretches to even the Upper Waste. Some long stretch of secrets lay here, a few unbroken rocks there."
      }
      else if mapIndexCheck[44]="1" and mMap_CurX>=19 and mMap_CurX<=23 and mMap_CurY>=14 and mMap_CurY<=15
      {
        mapDetails=44
        max_Chest=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.chestMoney,48); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,43); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Lower Waste"
        menuInfoText="Like the rest of the Wastes, this area houses a temple covered in sand. It is said there is an entrance to a cursed secret here."
      }
      else if mapIndexCheck[45]="1" and mMap_CurX>=17 and mMap_CurX<=18 and mMap_CurY>=14 and mMap_CurY<=15
      {
        mapDetails=45
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,45); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Twin Rocks"
        menuInfoText="A seemingly endless sea of sand that many have found themselves lost in and not able to cross. If someone went through the doors in a specific order..."
      }
      else if mapIndexCheck[46]="1" and mMap_CurX>=13 and mMap_CurX<=16 and mMap_CurY>=14 and mMap_CurY<=15
      {
        mapDetails=46
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,44); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Simmering Stretch"
        menuInfoText="A simple stretch of sand with unstable footing. There are no remarkable traits or landmarks about this place. Deserts are boring."
      }
      else if mapIndexCheck[47]="1" and mMap_CurX>=13 and mMap_CurX<=16 and mMap_CurY>=16 and mMap_CurY<=17
      {
        mapDetails=47
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,46); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Great Falloff"
        menuInfoText="A recent disturbance has caused the sands to fall into a hole in the world. The problem seems related to more than just the Virus."
      }
      else if mapIndexCheck[48]="1" and mMap_CurX>=17 and mMap_CurX<=20 and mMap_CurY>=16 and mMap_CurY<=17
      {
        mapDetails=48
        max_AP=1; max_Weapon=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,47); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,57); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Barrens - Oasis"
        menuInfoText="A great stretch of water lays about this area that causes problems for the Sand Crawler. It is often a place for travellers to rest without worry."
      }
      else if mapIndexCheck[49]="1" and mMap_CurX=21 and mMap_CurY=17
      {
        mapDetails=49
        max_HeartP=4; max_Chest=3; max_Missile=19; max_Air=1; max_Weapon=18; max_Extra=6
        var indexCheck; item_Max=51
        indexCheck=string_char_at(global.heartPiece,28); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,29); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,30); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,31); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,43); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,44); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,45); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.missilePack,1); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,2); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,4); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,9); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,10); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,11); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,13); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,14); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,15); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,16); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,17); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,18); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,19); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,20); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,21); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,22); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,23); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,24); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.missilePack,25); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.airUpgrade,8); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        indexCheck=string_char_at(global.weaponBoosts,6); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,7); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,8); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,9); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponBoosts,10); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        indexCheck=string_char_at(global.weaponLevels,91); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,92); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,93); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,94); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,95); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,96); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,101); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,102); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,103); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,104); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,105); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,106); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,111); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,112); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,113); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,114); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,115); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,116); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        item_Num+=global.metSpringBall; coll_Extra+=global.metSpringBall
        area_Name="Access Gate 5"
        menuInfoText="A large research facility housing seperate, yet connected, domes. A Program Chip is secured in the lowest depths of the facility behind a great door with 3 locks."
      }
      else if mapIndexCheck[50]="1" and mMap_CurX>=24 and mMap_CurX<=25 and mMap_CurY>=13 and mMap_CurY<=15
      {
        mapDetails=50
        max_Chest=2; max_Arrow=1; max_Wallet=1; max_AP=4
        var indexCheck; item_Max=8
        indexCheck=string_char_at(global.chestMoney,46); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,47); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,22); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.walletBoost,11); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,48); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,49); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,64); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,65); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Barrens - Deserted Tower"
        menuInfoText="The purpose of this tower was originally to calm the desert. Though what is meant by that is unknown."
      }
      else if mapIndexCheck[51]="1" and mMap_CurX>=26 and mMap_CurX<=29 and mMap_CurY=15
      {
        mapDetails=51
        max_HeartE=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.heartEnergy,27); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        area_Name="Burning Stretch - West"
        menuInfoText="A lush stretch of land divided from the Barrens by a large stone tower. This place is now under control of a militant bot group who call themselves CHAOS. No one knows what the acronym really means... They also attack on sight."
      }
      else if mapIndexCheck[52]="1" and mMap_CurX>=30 and mMap_CurX<=31 and mMap_CurY=15
      {
        mapDetails=52
        max_Wallet=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.walletBoost,12); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,50); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,97); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Burning Stretch - Mid"
        menuInfoText="A small sublet of housing just outside of Neo Grime. Bots used to live here until CHAOS took over."
      }
      else if mapIndexCheck[53]="1" and mMap_CurX>=31 and mMap_CurX<=34 and mMap_CurY=14
      {
        mapDetails=53
        max_HeartP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.heartPiece,32); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        area_Name="Neo Grime - Rooftops"
        menuInfoText="The grimy rooftops of Neo Grime that are now heavily patrolled by CHAOS since they got word that two gamers were in their territory. They better watch out."
      }
      else if mapIndexCheck[54]="1" and mMap_CurX>=31 and mMap_CurX<=34 and mMap_CurY=16
      {
        mapDetails=54
        max_Arrow=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.arrowQuiver,23); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.apBoost,98); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Neo Grime - Slums"
        menuInfoText="A large open tunnel that is part of Neo Grime. Some call it a bridge. This place was used by the bots after CHAOS took over the area as Neo Grime was too dangerous to go through."
      }
      else if mapIndexCheck[55]="1" and mMap_CurX>=33 and mMap_CurX<=35 and mMap_CurY=15
      {
        mapDetails=55
        max_Wallet=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.walletBoost,13); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Burning Stretch - East"
        menuInfoText="Another lush stretch of land between Neo Grime City and Land's End."
      }
      else if mapIndexCheck[56]="1" and mMap_CurX=36 and mMap_CurY=15
      {
        mapDetails=56
        max_Chest=1; max_AP=1
        var indexCheck; item_Max=2
        area_Name="Burning Stretch - Land's End"
        indexCheck=string_char_at(global.chestMoney,69); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,81); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        menuInfoText="A huge gapping chasm that leads to nowhere. Though just before it lies a portal to another world."
      }
      else if mapIndexCheck[57]="1" and mMap_CurX=32 and mMap_CurY=15
      {
        mapDetails=57
        max_Chest=2; max_Extra=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,49); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,50); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.weaponBoosts,1); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        area_Name="Neo Grime City"
        menuInfoText="A massive city housing many bots. The city is now under full control by CHAOS."
      }
      else if mapIndexCheck[58]="1" and mMap_CurX=36 and mMap_CurY=16
      {
        mapDetails=58
        max_HeartP=2; max_Chest=1; max_Ki=50
        var indexCheck; item_Max=53
        indexCheck=string_char_at(global.heartPiece,33); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.heartPiece,40); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,65); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        for(i=0;i<50;i+=1)
        {
          indexCheck=string_char_at(global.kiEnergy,i+1); if indexCheck="1" {item_Num+=1; coll_Ki+=1}
        }
        area_Name="Access Gate 6"
        menuInfoText="A prototype game built by the program's designers to test a few of the early systems and mechanics."
      }
      else if mapIndexCheck[59]="1" and mMap_CurX=4 and mMap_CurY=10
      {
        mapDetails=59
        max_HeartP=1; max_Chest=3; max_Arrow=1; max_Missile=1; max_Wallet=1; max_AP=1; max_Weapon=1
        var indexCheck; item_Max=9
        indexCheck=string_char_at(global.heartPiece,35); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,52); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,53); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,54); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.arrowQuiver,26); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.missilePack,26); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.walletBoost,16); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.apBoost,57); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,29); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Hidden Program Facility"
        menuInfoText="This facility lies hidden underneath Central City. Within its chambers is an access point capable of accessing some of the lower level functions of the program. Not many of these exist."
      }
      else if mapIndexCheck[60]="1" and mMap_CurX>=11 and mMap_CurX<=12 and mMap_CurY=10
      {
        mapDetails=60
        max_Weapon=3
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.weaponLevels,7); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,17); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,27); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Initiate's Pass - Secret Land"
        menuInfoText="A small alcove of land that's hidden secret from the eyes above. A few treasures lie here awaiting someone to claim them."
      }
      else if mapIndexCheck[61]="1" and mMap_CurX>=20 and mMap_CurX<=23 and mMap_CurY>=6 and mMap_CurY<=7
      {
        mapDetails=61
        max_AP=1; max_Weapon=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,58); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,8); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Snowy Mountains"
        menuInfoText="The mountain range that can be seen from Central City is home to very little."
      }
      else if mapIndexCheck[62]="1" and mMap_CurX>=24 and mMap_CurX<=25 and mMap_CurY>=5 and mMap_CurY<=7
      {
        mapDetails=62
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,59); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Starry Skies - Windy Hills"
        menuInfoText="The harsh terrain used to be home to many other bots, but since CHAOS's invasion on the mainland, many have been pushed out."
      }
      else if mapIndexCheck[63]="1" and mMap_CurX=26 and mMap_CurY=5
      {
        mapDetails=63
        max_AP=1; max_Weapon=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,60); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,118); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Secret Mountainside"
        menuInfoText="A secret place up high where it is said some bots go to hide away for awhile."
      }
      else if mapIndexCheck[64]="1" and mMap_CurX>=20 and mMap_CurX<=23 and mMap_CurY>=4 and mMap_CurY<=5
      {
        mapDetails=64
        max_Arrow=1; max_Chest=1; max_AP=5; max_Weapon=1
        var indexCheck; item_Max=8
        indexCheck=string_char_at(global.arrowQuiver,29); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.chestMoney,70); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,61); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,66); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,67); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,82); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,83); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,78); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Rolling Hills"
        menuInfoText="Many travellers get blown off these hills by the great northern winds. Luckily they simply faceplant into the snow."
      }
      else if mapIndexCheck[65]="1" and mMap_CurX>=18 and mMap_CurX<=19 and mMap_CurY>=4 and mMap_CurY<=5
      {
        mapDetails=65
        max_Weapon=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.weaponLevels,58); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - East Great Mountain"
        menuInfoText="A long slope leads to the near-top of the mountain in the Starry Skies."
      }
      else if mapIndexCheck[66]="1" and mMap_CurX>=16 and mMap_CurX<=17 and mMap_CurY>=4 and mMap_CurY<=5
      {
        mapDetails=66
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,62); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Starry Skies - West Great Mountain"
        menuInfoText="There are legends about the snowballs rolling up hill. Legends only among those who haven't figured out that it's just a bug."
      }
      else if mapIndexCheck[67]="1" and mMap_CurX>=12 and mMap_CurX<=15 and mMap_CurY>=4 and mMap_CurY<=5
      {
        mapDetails=67
        max_Chest=1; max_AP=1; max_Weapon=2
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.chestMoney,55); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,63); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,28); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,98); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Windy Slopes"
        menuInfoText="Atop the mountain is a secret weapons facility. No bots unaffiliated with CHAOS dare go near it."
      }
      else if mapIndexCheck[68]="1" and mMap_CurX>=12 and mMap_CurX<=19 and mMap_CurY=6
      {
        mapDetails=68
        max_Weapon=2
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.weaponLevels,18); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,48); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Fierce Skies"
        menuInfoText="Previously empty skies that are now home to a large tube built by CHAOS for transport before they had built aerial transport ships. Some equipment was left behind though."
      }
      else if mapIndexCheck[69]="1" and mMap_CurX=11 and mMap_CurY=4
      {
        mapDetails=69
        max_HeartP=1; max_AP=1; max_Weapon=3
        var indexCheck; item_Max=5
        indexCheck=string_char_at(global.heartPiece,36); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.apBoost,68); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponLevels,38); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,68); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,88); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="CHAOS Weapons Facility"
        menuInfoText="A large secret facility created by CHAOS to build their weapons. The Warmaster uses it as a home base for all his operations."
      }
      else if mapIndexCheck[70]="1" and mMap_CurX=11 and mMap_CurY=5
      {
        mapDetails=70
        max_HeartP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.heartPiece,42); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        area_Name="Lava Cave"
        menuInfoText="A lava cave deep under the mainland, where the program often throws buggy logic."
      }
      else if mapIndexCheck[71]="1" and mMap_CurX>=24 and mMap_CurX<=25 and mMap_CurY>=3 and mMap_CurY<=4
      {
        mapDetails=71
        max_Weapon=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.weaponLevels,108); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Starry Skies - Lava Peak"
        menuInfoText="Apparently there's a lava geyser here!"
      }
      else if mapIndexCheck[72]="1" and mMap_CurX>=8 and mMap_CurX<=9 and mMap_CurY>=6 and mMap_CurY<=7
      {
        mapDetails=72
        max_Chest=1; max_AP=1; max_Extra=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,72); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,86); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.weaponBoosts,5); if indexCheck="1" {item_Num+=1; coll_Extra+=1}
        area_Name="Grand Impediment"
        menuInfoText="Travellers travel up the tower in hopes of easy treasure, but soon found themselves frustrated when trying to reach a certain collectible they were missing."
      }
      else if mapIndexCheck[73]="1" and mMap_CurX>=8 and mMap_CurX<=9 and mMap_CurY=8
      {
        mapDetails=73
        max_Wallet=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.walletBoost,18); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Grand Lower Cavity"
        menuInfoText="A small cavern like structure just below the grand annoyance above it."
      }
      else if mapIndexCheck[74]="1" and mMap_CurX>=6 and mMap_CurX<=7 and mMap_CurY>=5 and mMap_CurY<=6
      {
        mapDetails=74
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,69); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Grand High Grounds"
        menuInfoText="Not many come here. Only peace is allowed."
      }
      else if mapIndexCheck[75]="1" and mMap_CurX>=21 and mMap_CurX<=25 and mMap_CurY=16
      {
        mapDetails=75
        max_Chest=1; max_Missile=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.chestMoney,57); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.missilePack,28); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        area_Name="Barrens - Colossal Encroachment"
        menuInfoText="This odd structure leads only to death they say. A great amount of energy gathers at its end, energy that is coveted by a creature capable of consuming the world."
      }
      else if mapIndexCheck[76]="1" and mMap_CurX>=26 and mMap_CurX<=27 and mMap_CurY>=16 and mMap_CurY<=17
      {
        mapDetails=76
        max_Chest=2
        var indexCheck; item_Max=2
        area_Name="Great Colossal Falloff"
        indexCheck=string_char_at(global.chestMoney,76); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.chestMoney,77); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        menuInfoText="A great colossal beast hides here, waiting for the right moment to rise up and destroy everything. Once it begins its rampage, nothing will stop its consumption of the world."
      }
      else if mapIndexCheck[77]="1" and mMap_CurX>=29 and mMap_CurX<=30 and mMap_CurY>=8 and mMap_CurY<=9
      {
        mapDetails=77
        max_HeartP=1; max_Chest=1; max_AP=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.heartPiece,38); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,58); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,100); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Floating Branches"
        menuInfoText="Just a short route through what leads to a treeless place. Some say there were onlookers to the creation of this world."
      }
      else if mapIndexCheck[78]="1" and mMap_CurX>=31 and mMap_CurX<=32 and mMap_CurY>=7 and mMap_CurY<=8
      {
        mapDetails=78
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,70); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Magical Treeless Pass"
        menuInfoText="The entrance to a castle most have forgotten. It holds a piece of a great treasure which was used by a familiar face."
      }
      else if mapIndexCheck[79]="1" and mMap_CurX>=26 and mMap_CurX<=27 and mMap_CurY=6
      {
        mapDetails=79
        max_Chest=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.chestMoney,59); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,93); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Highlands - Odyssey"
        menuInfoText="A brightly colored field inappropriately close to the snowy peaks of the Starry Skies. Bots like to come out to the Highlands to play."
      }
      else if mapIndexCheck[80]="1" and mMap_CurX>=28 and mMap_CurX<=29 and mMap_CurY>=5 and mMap_CurY<=6
      {
        mapDetails=80
        max_Arrow=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.arrowQuiver,28); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.apBoost,71); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,96); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Highlands - Super Falls"
        menuInfoText="Many come here to partake in its wonder and many stayed for long periods of time. Some wish they could come back, but those days are over now."
      }
      else if mapIndexCheck[81]="1" and mMap_CurX>=30 and mMap_CurX<=32 and mMap_CurY>=5 and mMap_CurY<=6
      {
        mapDetails=81
        max_Chest=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.chestMoney,60); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        area_Name="Highlands - Woods of Genesis"
        menuInfoText="The woods may be clunky and not as fondly thought of as the falls to its side, but these woods still hold a special place for many."
      }
      else if mapIndexCheck[82]="1" and mMap_CurX=30 and mMap_CurY=7
      {
        mapDetails=82
        max_AP=2
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.apBoost,72); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,94); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Highlands - Forgotten Virtual Growth"
        menuInfoText="Simply a quick pass between two worlds. Good for a quick glance, but not much else."
      }
      else if mapIndexCheck[83]="1" and mMap_CurX>=28 and mMap_CurX<=30 and mMap_CurY=4
      {
        mapDetails=83
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,73); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Highlands - Upper Dream Path"
        menuInfoText="Here is a path that not many travelled. It was overlooked by most, but loved by those who walked its beautiful roads."
      }
      else if mapIndexCheck[84]="1" and mMap_CurX>=31 and mMap_CurX<=33 and mMap_CurY=4
      {
        mapDetails=84
        max_Chest=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.chestMoney,61); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        area_Name="Highlands - Upper Crossroad"
        menuInfoText="An often dividing road, but where many will inevitably meet. Does this lead to our future?"
      }
      else if mapIndexCheck[85]="1" and mMap_CurX=34 and mMap_CurY=4
      {
        mapDetails=85
        area_Name="Tranquil Serenity"
        menuInfoText="A special place made for a special person who never got to experience it."
      }
      else if mapIndexCheck[86]="1" and mMap_CurX=35 and mMap_CurY=4
      {
        mapDetails=86
        area_Name="Hidden Bot Village"
        menuInfoText="A small congregation of bots that live hidden away from the rest of the world. The bots remain peaceful to both bots and humans, but wish to keep humans out."
      }
      else if mapIndexCheck[87]="1" and mMap_CurX>=11 and mMap_CurX<=12 and mMap_CurY=16
      {
        mapDetails=87
        area_Name="Barrens - Rock Blockage"
        menuInfoText="A large blockade of rocks keeps out most intruders from a place that wishes to stay hidden."
      }
      else if mapIndexCheck[88]="1" and mMap_CurX=10 and mMap_CurY=16
      {
        mapDetails=88
        area_Name="The Discombobulated"
        menuInfoText="A buggy location which is easily modified. Most bots do not come here."
      }
      else if mapIndexCheck[89]="1" and mMap_CurX>=26 and mMap_CurX<=27 and mMap_CurY=13
      {
        mapDetails=89
        max_AP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.apBoost,74); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Determine"
        menuInfoText="A small, sort of not that secret, passage blocked off by rocks to hide away a great treasure."
      }
      else if mapIndexCheck[90]="1" and mMap_CurX=28 and mMap_CurY=13
      {
        mapDetails=90
        max_Weapon=7
        var indexCheck; item_Max=7
        indexCheck=string_char_at(global.weaponLevels,9); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,49); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,59); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,79); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,99); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,109); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,119); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Displaced Construction Site"
        menuInfoText="A location constructed entirely by bots introduced into the program early on. Most bots now no longer frequent it, but it does entice a few with its secrets."
      }
      else if mapIndexCheck[91]="1" and mMap_CurX=4 and mMap_CurY=9
      {
        mapDetails=91
        area_Name="Subconscious Filter"
        menuInfoText="A place in the program that doesn't exist, yet does, made possible through flukes in the code."
      }
      else if mapIndexCheck[92]="1" and mMap_CurX=33 and mMap_CurY=9
      {
        mapDetails=92
        area_Name="Farreaches - Envision"
        menuInfoText="A closed off grove, used as a quiet spot to meet."
      }
      else if mapIndexCheck[93]="1" and mMap_CurX=33 and mMap_CurY=7
      {
        mapDetails=93
        max_HeartP=1; max_Weapon=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.heartPiece,39); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.weaponLevels,39); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,89); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Magical Castle"
        menuInfoText="A magical place which houses many treasures. One treasure in particular is special to a certain bot."
      }
      else if mapIndexCheck[94]="1" and mMap_CurX=4 and mMap_CurY=8
      {
        mapDetails=94
        area_Name="Skies of Dragoon"
        menuInfoText="The skies over the Mainland."
      }
      else if mapIndexCheck[95]="1" and mMap_CurX=24 and mMap_CurY=12
      {
        mapDetails=95
        max_Chest=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,67); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,78); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,79); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Aversion"
        menuInfoText="A section of the Farreaches that have been corrupted due to its proximity to the Vault. Strange occurrences have occured here."
      }
      else if mapIndexCheck[96]="1" and mMap_CurX=33 and mMap_CurY=5
      {
        mapDetails=96
        max_Chest=1; max_Weapon=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.chestMoney,68); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.weaponLevels,19); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,69); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Highlands - The One Four You"
        menuInfoText="A hard to reach, yet not so hard to reach, area above."
      }
      else if mapIndexCheck[97]="1" and mMap_CurX=33 and mMap_CurY=11
      {
        mapDetails=97
        max_Chest=1; max_AP=1
        var indexCheck; item_Max=2
        indexCheck=string_char_at(global.chestMoney,73); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,92); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Farreaches - Hypothesis"
        menuInfoText="A secret clearing that was used as a hiding place for goodies. You might want to feel bad for taking their stuff... or not, it's not your problem is it?"
      }
      else if mapIndexCheck[98]="1" and mMap_CurX>=10 and mMap_CurX<=11 and mMap_CurY=6
      {
        mapDetails=98
        max_HeartP=1; max_Chest=1; max_AP=1
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.heartPiece,43); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,74); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.apBoost,95); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        area_Name="Grand Not Hidden Well"
        menuInfoText="A somewhat secret place that most would rather not exist, but there's no fighting it, it exists."
      }
      else if mapIndexCheck[99]="1" and mMap_CurX>=3 and mMap_CurX<=4 and mMap_CurY>=5 and mMap_CurY<=6
      {
        mapDetails=99
        max_HeartP=1; max_Chest=1; max_Weapon=12
        var indexCheck; item_Max=14
        indexCheck=string_char_at(global.heartPiece,44); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        indexCheck=string_char_at(global.chestMoney,75); if indexCheck="1" {item_Num+=1; coll_Chest+=1}
        indexCheck=string_char_at(global.weaponLevels,10); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,20); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,30); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,40); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,50); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,60); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,70); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,80); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,90); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,100); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,110); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,120); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="CHAOS Warship"
        menuInfoText="A large ship constructed deep under the Mainland by CHAOS. Hex now controls it and is using it to threaten everyone on the Mainland, and eventually, the entire program."
      }
      else if mapIndexCheck[101]="1" and mMap_CurX=3 and mMap_CurY=13
      {
        mapDetails=101
        max_HeartP=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.heartPiece,15); if indexCheck="1" {item_Num+=1; coll_HeartP+=1}
        area_Name="Nightmare Gate A"
        if instrProg[0]="9" {menuInfoText="A great beast came down from the heavens. Seemingly sent by the gods. It wandered the land, tearing it asunder beneath its impressive might."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[102]="1" and mMap_CurX=5 and mMap_CurY=13
      {
        mapDetails=102
        max_Arrow=1; max_Weapon=3
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.arrowQuiver,14); if indexCheck="1" {item_Num+=1; coll_Arrow+=1}
        indexCheck=string_char_at(global.weaponLevels,5); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,15); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,25); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Nightmare Gate B"
        if instrProg[1]="9" {menuInfoText="The people rallied against the beast, which sent it into a frenzy. They cried out for help, for none could stop it."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[103]="1" and mMap_CurX=6 and mMap_CurY=14
      {
        mapDetails=103
        max_HeartE=1; max_Weapon=3
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.heartEnergy,21); if indexCheck="1" {item_Num+=1; coll_HeartE+=1}
        indexCheck=string_char_at(global.weaponLevels,36); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,46); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,56); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Nightmare Gate C"
        if instrProg[2]="9" {menuInfoText="The gods extended a hand of mercy and imprisoned the beast within a dark empty cage, where it now sleeps."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[104]="1" and mMap_CurX=6 and mMap_CurY=16
      {
        mapDetails=104
        max_Wallet=1; max_Weapon=3
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.walletBoost,7); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        indexCheck=string_char_at(global.weaponLevels,66); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,76); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,86); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Nightmare Gate D"
        if instrProg[3]="9" {menuInfoText="The beast lay cursed in its dark imprisonment, now awaiting its moment to rise again, eager and hungry for destruction."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[105]="1" and mMap_CurX=5 and mMap_CurY=17
      {
        mapDetails=105
        max_Air=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.apBoost,88); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,89); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.airUpgrade,9); if indexCheck="1" {item_Num+=1; coll_Air+=1}
        area_Name="Nightmare Gate E"
        if instrProg[4]="9" {menuInfoText="It is said a song with the power to drive away nightmares can calm the beast. A song that could only be heard within ones dreams."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[106]="1" and mMap_CurX=3 and mMap_CurY=17
      {
        mapDetails=106
        max_Missile=1; max_Weapon=3
        var indexCheck; item_Max=4
        indexCheck=string_char_at(global.missilePack,7); if indexCheck="1" {item_Num+=1; coll_Missile+=1}
        indexCheck=string_char_at(global.weaponLevels,97); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,107); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        indexCheck=string_char_at(global.weaponLevels,117); if indexCheck="1" {item_Num+=1; coll_Weapon+=1}
        area_Name="Nightmare Gate F"
        if instrProg[5]="9" {menuInfoText="If one could find the magical instruments passed down through the ages to play the song, they could free the beast from its curse."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[107]="1" and mMap_CurX=2 and mMap_CurY=16
      {
        mapDetails=107
        max_Wallet=1; max_AP=2
        var indexCheck; item_Max=3
        indexCheck=string_char_at(global.apBoost,90); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.apBoost,91); if indexCheck="1" {item_Num+=1; coll_AP+=1}
        indexCheck=string_char_at(global.walletBoost,14); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Nightmare Gate G"
        if instrProg[6]="9" {menuInfoText="They now slumber, lost in time, awaiting for those that would bring them to perform their destiny."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[108]="1" and mMap_CurX=2 and mMap_CurY=14
      {
        mapDetails=108
        area_Name="Nightmare Gate H"
        if instrProg[7]="9" {menuInfoText="I implore you, gamer. Free me from this wretched curse placed upon me by the disease which spreads across this land."}
        else {menuInfoText="A dark zone..."}
      }
      else if mapIndexCheck[109]="1" and mMap_CurX=4 and mMap_CurY=15
      {
        mapDetails=109
        max_Wallet=1
        var indexCheck; item_Max=1
        indexCheck=string_char_at(global.walletBoost,2); if indexCheck="1" {item_Num+=1; coll_Wallet+=1}
        area_Name="Sacred Temple"
        menuInfoText="A place created by ghosts left in the machine. A safe storage housing a method to fix a travesty within the system."
      }
      else if mapIndexCheck[110]="1" and mMap_CurX>=35 and mMap_CurX<=36 and mMap_CurY>=10 and mMap_CurY<=11
      {
        mapDetails=110
        area_Name="The Distortion"
        menuInfoText="Unable to find data..."
      }
    }
  }

  var tShowMap;
  tShowMap=1

  if tMenuType=1 //Do not display map when in the teleport menu and a gate.
  {
    if global.location=7 or global.location=10 or global.location=15
      tShowMap=0
  }

  if tShowMap=1 {draw_sprite(sPauseM_MapMain,0,contentMenuX+21,contentMenuY+71)}

  //-------------------- Black out areas the player has not gone to --------------------
  draw_set_color(make_color_rgb(8,184,112))
  var tMcX,tMcY,tMapX,tMapY,tMSpc;
  tMapX=13
  tMapY=23
  tMcX=contentMenuX+tMapX
  tMcY=contentMenuY+tMapY
  tMSpc=8
  if mapIndexCheck[2]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*7),tMcY+(tMSpc*8))
  if mapIndexCheck[3]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc*2,tMcX+(tMSpc*9),tMcY+(tMSpc*7))
  if mapIndexCheck[4]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*10),tMcY+(tMSpc*7))
  if mapIndexCheck[5]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc*2,tMcX+(tMSpc*12),tMcY+(tMSpc*7))
  if mapIndexCheck[6]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*13),tMcY+(tMSpc*6))
  if mapIndexCheck[7]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*12),tMcY+(tMSpc*6))
  if mapIndexCheck[8]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*3,tMcX+(tMSpc*15),tMcY+(tMSpc*6))
  if mapIndexCheck[9]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*18),tMcY+(tMSpc*9))
  if mapIndexCheck[10]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*14),tMcY+(tMSpc*6))
  if mapIndexCheck[11]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*19),tMcY+(tMSpc*7))
  if mapIndexCheck[12]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*23),tMcY+(tMSpc*7))
  if mapIndexCheck[13]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc*2,tMcX+(tMSpc*25),tMcY+(tMSpc*6))
  if mapIndexCheck[14]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*26),tMcY+(tMSpc*6))
  if mapIndexCheck[15]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*28),tMcY+(tMSpc*6))
  if mapIndexCheck[16]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*8))
  if mapIndexCheck[17]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*23),tMcY+(tMSpc*8))
  if mapIndexCheck[18]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*9),tMcY+(tMSpc*6))
  if mapIndexCheck[19]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*12),tMcY+(tMSpc*9))
  if mapIndexCheck[20]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*3,tMcX+(tMSpc*14),tMcY+(tMSpc*9))
  if mapIndexCheck[21]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*12),tMcY+(tMSpc*10))
  if mapIndexCheck[22]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*10),tMcY+(tMSpc*10))
  if mapIndexCheck[23]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*8),tMcY+(tMSpc*10))
  if mapIndexCheck[24]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*7),tMcY+(tMSpc*11))
  if mapIndexCheck[25]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*15),tMcY+(tMSpc*12))
  if mapIndexCheck[26]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*14),tMcY+(tMSpc*12))
  if mapIndexCheck[27]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*12),tMcY+(tMSpc*11))
  if mapIndexCheck[28]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc*2,tMcX+(tMSpc*9),tMcY+(tMSpc*12))
  if mapIndexCheck[29]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*8),tMcY+(tMSpc*12))
  if mapIndexCheck[30]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*9))
  if mapIndexCheck[31]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*26),tMcY+(tMSpc*9))
  if mapIndexCheck[32]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*28),tMcY+(tMSpc*9))
  if mapIndexCheck[33]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*27),tMcY+(tMSpc*10))
  if mapIndexCheck[34]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*30),tMcY+(tMSpc*8))
  if mapIndexCheck[35]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc*2,tMcX+(tMSpc*31),tMcY+(tMSpc*10))
  if mapIndexCheck[36]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc,tMcX+(tMSpc*27),tMcY+(tMSpc*11))
  if mapIndexCheck[37]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*30),tMcY+(tMSpc*10))
  if mapIndexCheck[38]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*25),tMcY+(tMSpc*10))
  if mapIndexCheck[39]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc*2,tMcX+(tMSpc*24),tMcY+(tMSpc*10))
  if mapIndexCheck[40]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*23),tMcY+(tMSpc*10))
  if mapIndexCheck[41]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*18),tMcY+(tMSpc*10))
  if mapIndexCheck[42]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*5,tMSpc*2,tMcX+(tMSpc*18),tMcY+(tMSpc*11))
  if mapIndexCheck[43]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc*2,tMcX+(tMSpc*20),tMcY+(tMSpc*9))
  if mapIndexCheck[44]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*5,tMSpc*2,tMcX+(tMSpc*18),tMcY+(tMSpc*13))
  if mapIndexCheck[45]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*16),tMcY+(tMSpc*13))
  if mapIndexCheck[46]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*12),tMcY+(tMSpc*13))
  if mapIndexCheck[47]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*12),tMcY+(tMSpc*15))
  if mapIndexCheck[48]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*16),tMcY+(tMSpc*15))
  if mapIndexCheck[49]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*16))
  if mapIndexCheck[50]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*3,tMcX+(tMSpc*23),tMcY+(tMSpc*12))
  if mapIndexCheck[51]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*14))
  if mapIndexCheck[52]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*29),tMcY+(tMSpc*14))
  if mapIndexCheck[53]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc,tMcX+(tMSpc*30),tMcY+(tMSpc*13))
  if mapIndexCheck[54]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc,tMcX+(tMSpc*30),tMcY+(tMSpc*15))
  if mapIndexCheck[55]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*32),tMcY+(tMSpc*14))
  if mapIndexCheck[56]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*35),tMcY+(tMSpc*14))
  if mapIndexCheck[57]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*31),tMcY+(tMSpc*14))
  if mapIndexCheck[58]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*35),tMcY+(tMSpc*15))
  if mapIndexCheck[59]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*3),tMcY+(tMSpc*9))
  if mapIndexCheck[60]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*10),tMcY+(tMSpc*9))
  if mapIndexCheck[61]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*19),tMcY+(tMSpc*5))
  if mapIndexCheck[62]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*3,tMcX+(tMSpc*23),tMcY+(tMSpc*4))
  if mapIndexCheck[63]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*4))
  if mapIndexCheck[64]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*19),tMcY+(tMSpc*3))
  if mapIndexCheck[65]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*17),tMcY+(tMSpc*3))
  if mapIndexCheck[66]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*15),tMcY+(tMSpc*3))
  if mapIndexCheck[67]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*4,tMSpc*2,tMcX+(tMSpc*11),tMcY+(tMSpc*3))
  if mapIndexCheck[68]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*8,tMSpc,tMcX+(tMSpc*11),tMcY+(tMSpc*5))
  if mapIndexCheck[69]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*10),tMcY+(tMSpc*3))
  if mapIndexCheck[70]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*10),tMcY+(tMSpc*4))
  if mapIndexCheck[71]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*23),tMcY+(tMSpc*2))
  if mapIndexCheck[72]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*7),tMcY+(tMSpc*5))
  if mapIndexCheck[73]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*7),tMcY+(tMSpc*7))
  if mapIndexCheck[74]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*5),tMcY+(tMSpc*4))
  if mapIndexCheck[75]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*5,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*15))
  if mapIndexCheck[76]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*25),tMcY+(tMSpc*15))
  if mapIndexCheck[77]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*28),tMcY+(tMSpc*7))
  if mapIndexCheck[78]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*30),tMcY+(tMSpc*6))
  if mapIndexCheck[79]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*5))
  if mapIndexCheck[80]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*27),tMcY+(tMSpc*4))
  if mapIndexCheck[81]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc*2,tMcX+(tMSpc*29),tMcY+(tMSpc*4))
  if mapIndexCheck[82]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*29),tMcY+(tMSpc*6))
  if mapIndexCheck[83]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*27),tMcY+(tMSpc*3))
  if mapIndexCheck[84]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*3,tMSpc,tMcX+(tMSpc*30),tMcY+(tMSpc*3))
  if mapIndexCheck[85]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*33),tMcY+(tMSpc*3))
  if mapIndexCheck[86]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*34),tMcY+(tMSpc*3))
  if mapIndexCheck[87]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*10),tMcY+(tMSpc*15))
  if mapIndexCheck[88]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*9),tMcY+(tMSpc*15))
  if mapIndexCheck[89]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*25),tMcY+(tMSpc*12))
  if mapIndexCheck[90]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*27),tMcY+(tMSpc*12))
  if mapIndexCheck[91]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*3),tMcY+(tMSpc*8))
  if mapIndexCheck[92]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*32),tMcY+(tMSpc*8))
  if mapIndexCheck[93]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*32),tMcY+(tMSpc*6))
  if mapIndexCheck[94]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*3),tMcY+(tMSpc*7))
  if mapIndexCheck[95]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*23),tMcY+(tMSpc*11))
  if mapIndexCheck[96]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*32),tMcY+(tMSpc*4))
  if mapIndexCheck[97]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*32),tMcY+(tMSpc*10))
  if mapIndexCheck[98]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*9),tMcY+(tMSpc*5))
  if mapIndexCheck[99]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*2),tMcY+(tMSpc*4))
  if mapIndexCheck[101]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*2),tMcY+(tMSpc*12))
  if mapIndexCheck[102]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*4),tMcY+(tMSpc*12))
  if mapIndexCheck[103]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*5),tMcY+(tMSpc*13))
  if mapIndexCheck[104]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*5),tMcY+(tMSpc*15))
  if mapIndexCheck[105]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*4),tMcY+(tMSpc*16))
  if mapIndexCheck[106]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*2),tMcY+(tMSpc*16))
  if mapIndexCheck[107]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*1),tMcY+(tMSpc*15))
  if mapIndexCheck[108]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*1),tMcY+(tMSpc*13))
  if mapIndexCheck[109]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*3),tMcY+(tMSpc*14))
  if mapIndexCheck[110]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*34),tMcY+(tMSpc*9))

  if tShowMap=0
  {
    //draw_set_font(fnt_Chapter)
    //draw_set_halign(fa_center)
    //textDropShadow("NO MAP AVAILABLE",contentMenuX+164,contentMenuY+80,c_black,textColorMain,4)
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_left)
    textDropShadowExt("NO MAP AVAILABLE!! At least that's what they say. Is there truly a map? Is it that we simply can't see it? Do we have the cognitive capacity to even comprehend the map if it were to exist? But wait, we just said it could exist, but we simply don't see it... or was that a question? Do things truly exist if we can't percieve them with our own eyes? Does this mean we don't exist if we aren't looking at ourselves through a mirror or a clean stream of water? Perhaps we don't exist at all and are mere fragments of thought in a greater being's mind. Despite all this, there is no map available for this region.",contentMenuX+18,contentMenuY+32,textColorMain,c_black,4,12,298)
  }

  //---------------------------------------- Display location ----------------------------------------
  mMap_FrameCount+=1
  if mMap_FrameCount mod 6=0
  {
    mMap_CurFrame+=1
    if mMap_CurFrame=4 {mMap_CurFrame=0}
  }
  var tMapLocX,tMapLocY;
  tMapLocX=tMapX
  tMapLocY=tMapY
  if global.location=1 {tMapLocX+=tMSpc*7; tMapLocY+=tMSpc*8}
  else if global.location=2 {tMapLocX+=tMSpc*8+4; tMapLocY+=tMSpc*9}
  else if global.location=3 {tMapLocX+=tMSpc*10; tMapLocY+=tMSpc*8+4}
  else if global.location=4 {tMapLocX+=tMSpc*11+4; tMapLocY+=tMSpc*8+4}
  else if global.location=5 {tMapLocX+=tMSpc*14; tMapLocY+=tMSpc*8+4}
  else if global.location=6 {tMapLocX+=tMSpc*14; tMapLocY+=tMSpc*7}
  else if global.location=7 {tMapLocX+=tMSpc*13; tMapLocY+=tMSpc*7}
  else if global.location=8 {tMapLocX+=tMSpc*17+4; tMapLocY+=tMSpc*8}
  else if global.location=9 {tMapLocX+=tMSpc*19+4; tMapLocY+=tMSpc*10}
  else if global.location=10 {tMapLocX+=tMSpc*15; tMapLocY+=tMSpc*7}
  else if global.location=11 {tMapLocX+=tMSpc*21+4; tMapLocY+=tMSpc*8+4}
  else if global.location=12 {tMapLocX+=tMSpc*24+4; tMapLocY+=tMSpc*8}
  else if global.location=13 {tMapLocX+=tMSpc*26; tMapLocY+=tMSpc*7+4}
  else if global.location=14 {tMapLocX+=tMSpc*27+4; tMapLocY+=tMSpc*7+4}
  else if global.location=15 {tMapLocX+=tMSpc*29; tMapLocY+=tMSpc*7}
  else if global.location=16 {tMapLocX+=tMSpc*27; tMapLocY+=tMSpc*9}
  else if global.location=17 {tMapLocX+=tMSpc*24+4; tMapLocY+=tMSpc*9+4}
  else if global.location=18 {tMapLocX+=tMSpc*11; tMapLocY+=tMSpc*7}
  else if global.location=19 {tMapLocX+=tMSpc*13+4; tMapLocY+=tMSpc*10}
  else if global.location=20 {tMapLocX+=tMSpc*16+4; tMapLocY+=tMSpc*11}
  else if global.location=21 {tMapLocX+=tMSpc*13+4; tMapLocY+=tMSpc*11}
  else if global.location=22 {tMapLocX+=tMSpc*11+4; tMapLocY+=tMSpc*11+4}
  else if global.location=23 {tMapLocX+=tMSpc*9+4; tMapLocY+=tMSpc*11+4}
  else if global.location=24 {tMapLocX+=tMSpc*8; tMapLocY+=tMSpc*12}
  else if global.location=25 {tMapLocX+=tMSpc*17; tMapLocY+=tMSpc*13}
  else if global.location=26 {tMapLocX+=tMSpc*15; tMapLocY+=tMSpc*13}
  else if global.location=27 {tMapLocX+=tMSpc*13+4; tMapLocY+=tMSpc*12+4}
  else if global.location=28 {tMapLocX+=tMSpc*11; tMapLocY+=tMSpc*13+4}
  else if global.location=29 {tMapLocX+=tMSpc*9; tMapLocY+=tMSpc*13}
  else if global.location=30 {tMapLocX+=tMSpc*26; tMapLocY+=tMSpc*10}
  else if global.location=31 {tMapLocX+=tMSpc*27+4; tMapLocY+=tMSpc*10}
  else if global.location=32 {tMapLocX+=tMSpc*29+4; tMapLocY+=tMSpc*10+4}
  else if global.location=33 {tMapLocX+=tMSpc*28; tMapLocY+=tMSpc*11}
  else if global.location=34 {tMapLocX+=tMSpc*31+4; tMapLocY+=tMSpc*9+4}
  else if global.location=35 {tMapLocX+=tMSpc*32; tMapLocY+=tMSpc*11+4}
  else if global.location=36 {tMapLocX+=tMSpc*29+4; tMapLocY+=tMSpc*12}
  else if global.location=37 {tMapLocX+=tMSpc*31; tMapLocY+=tMSpc*11}
  else if global.location=38 {tMapLocX+=tMSpc*26+4; tMapLocY+=tMSpc*11+4}
  else if global.location=39 {tMapLocX+=tMSpc*25; tMapLocY+=tMSpc*11+4}
  else if global.location=40 {tMapLocX+=tMSpc*24; tMapLocY+=tMSpc*11}
  else if global.location=41 {tMapLocX+=tMSpc*19+4; tMapLocY+=tMSpc*11}
  else if global.location=42 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*12+4}
  else if global.location=43 {tMapLocX+=tMSpc*22; tMapLocY+=tMSpc*10+4}
  else if global.location=44 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*14+4}
  else if global.location=45 {tMapLocX+=tMSpc*17+4; tMapLocY+=tMSpc*14+4}
  else if global.location=46 {tMapLocX+=tMSpc*14+4; tMapLocY+=tMSpc*14+4}
  else if global.location=47 {tMapLocX+=tMSpc*14+4; tMapLocY+=tMSpc*16+4}
  else if global.location=48 {tMapLocX+=tMSpc*18+4; tMapLocY+=tMSpc*16+4}
  else if global.location=49 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*17}
  else if global.location=50 {tMapLocX+=tMSpc*24+4; tMapLocY+=tMSpc*14}
  else if global.location=51 {tMapLocX+=tMSpc*27+4; tMapLocY+=tMSpc*15}
  else if global.location=52 {tMapLocX+=tMSpc*30+4; tMapLocY+=tMSpc*15}
  else if global.location=53 {tMapLocX+=tMSpc*32+4; tMapLocY+=tMSpc*14}
  else if global.location=54 {tMapLocX+=tMSpc*32+4; tMapLocY+=tMSpc*16}
  else if global.location=55 {tMapLocX+=tMSpc*34; tMapLocY+=tMSpc*15}
  else if global.location=56 {tMapLocX+=tMSpc*36; tMapLocY+=tMSpc*15}
  else if global.location=57 {tMapLocX+=tMSpc*32; tMapLocY+=tMSpc*15}
  else if global.location=58 {tMapLocX+=tMSpc*36; tMapLocY+=tMSpc*16}
  else if global.location=59 {tMapLocX+=tMSpc*4; tMapLocY+=tMSpc*10}
  else if global.location=60 {tMapLocX+=tMSpc*11+4; tMapLocY+=tMSpc*10}
  else if global.location=61 {tMapLocX+=tMSpc*21+4; tMapLocY+=tMSpc*6+4}
  else if global.location=62 {tMapLocX+=tMSpc*24+4; tMapLocY+=tMSpc*6}
  else if global.location=63 {tMapLocX+=tMSpc*26; tMapLocY+=tMSpc*5}
  else if global.location=64 {tMapLocX+=tMSpc*21+4; tMapLocY+=tMSpc*4+4}
  else if global.location=65 {tMapLocX+=tMSpc*18+4; tMapLocY+=tMSpc*4+4}
  else if global.location=66 {tMapLocX+=tMSpc*16+4; tMapLocY+=tMSpc*4+4}
  else if global.location=67 {tMapLocX+=tMSpc*13+4; tMapLocY+=tMSpc*4+4}
  else if global.location=68 {tMapLocX+=tMSpc*15+4; tMapLocY+=tMSpc*6}
  else if global.location=69 {tMapLocX+=tMSpc*11; tMapLocY+=tMSpc*4}
  else if global.location=70 {tMapLocX+=tMSpc*11; tMapLocY+=tMSpc*5}
  else if global.location=71 {tMapLocX+=tMSpc*24+4; tMapLocY+=tMSpc*3+4}
  else if global.location=72 {tMapLocX+=tMSpc*8+4; tMapLocY+=tMSpc*6+4}
  else if global.location=73 {tMapLocX+=tMSpc*8+4; tMapLocY+=tMSpc*8}
  else if global.location=74 {tMapLocX+=tMSpc*6+4; tMapLocY+=tMSpc*5+4}
  else if global.location=75 {tMapLocX+=tMSpc*23; tMapLocY+=tMSpc*16}
  else if global.location=76 {tMapLocX+=tMSpc*26+4; tMapLocY+=tMSpc*16+4}
  else if global.location=77 {tMapLocX+=tMSpc*29+4; tMapLocY+=tMSpc*8+4}
  else if global.location=78 {tMapLocX+=tMSpc*31+4; tMapLocY+=tMSpc*7+4}
  else if global.location=79 {tMapLocX+=tMSpc*26+4; tMapLocY+=tMSpc*6}
  else if global.location=80 {tMapLocX+=tMSpc*28+4; tMapLocY+=tMSpc*5+4}
  else if global.location=81 {tMapLocX+=tMSpc*31; tMapLocY+=tMSpc*5+4}
  else if global.location=82 {tMapLocX+=tMSpc*30; tMapLocY+=tMSpc*7}
  else if global.location=83 {tMapLocX+=tMSpc*29; tMapLocY+=tMSpc*4}
  else if global.location=84 {tMapLocX+=tMSpc*32; tMapLocY+=tMSpc*4}
  else if global.location=85 {tMapLocX+=tMSpc*34; tMapLocY+=tMSpc*4}
  else if global.location=86 {tMapLocX+=tMSpc*35; tMapLocY+=tMSpc*4}
  else if global.location=87 {tMapLocX+=tMSpc*11+4; tMapLocY+=tMSpc*16}
  else if global.location=88 {tMapLocX+=tMSpc*10; tMapLocY+=tMSpc*16}
  else if global.location=89 {tMapLocX+=tMSpc*26+4; tMapLocY+=tMSpc*13}
  else if global.location=90 {tMapLocX+=tMSpc*28; tMapLocY+=tMSpc*13}
  else if global.location=91 {tMapLocX+=tMSpc*4; tMapLocY+=tMSpc*9}
  else if global.location=92 {tMapLocX+=tMSpc*33; tMapLocY+=tMSpc*9}
  else if global.location=93 {tMapLocX+=tMSpc*33; tMapLocY+=tMSpc*7}
  else if global.location=94 {tMapLocX+=tMSpc*4; tMapLocY+=tMSpc*8}
  else if global.location=95 {tMapLocX+=tMSpc*24; tMapLocY+=tMSpc*12}
  else if global.location=96 {tMapLocX+=tMSpc*33; tMapLocY+=tMSpc*5}
  else if global.location=97 {tMapLocX+=tMSpc*33; tMapLocY+=tMSpc*11}
  else if global.location=98 {tMapLocX+=tMSpc*10+4; tMapLocY+=tMSpc*6}
  else if global.location=99 {tMapLocX+=tMSpc*3; tMapLocY+=tMSpc*5}
  else if global.location=101 {tMapLocX+=tMSpc*3; tMapLocY+=tMSpc*13}
  else if global.location=102 {tMapLocX+=tMSpc*5; tMapLocY+=tMSpc*13}
  else if global.location=103 {tMapLocX+=tMSpc*6; tMapLocY+=tMSpc*14}
  else if global.location=104 {tMapLocX+=tMSpc*6; tMapLocY+=tMSpc*16}
  else if global.location=105 {tMapLocX+=tMSpc*5; tMapLocY+=tMSpc*17}
  else if global.location=106 {tMapLocX+=tMSpc*3; tMapLocY+=tMSpc*17}
  else if global.location=107 {tMapLocX+=tMSpc*2; tMapLocY+=tMSpc*16}
  else if global.location=108 {tMapLocX+=tMSpc*2; tMapLocY+=tMSpc*14}
  else if global.location=109 {tMapLocX+=tMSpc*4; tMapLocY+=tMSpc*15}
  else if global.location=110 {tMapLocX+=tMSpc*35+4; tMapLocY+=tMSpc*10+4}

  if tMenuType=1 //-------------------- Display available teleport spots --------------------
  {
    if area=0 and init=1
    {
      tMcX-=8; tMcY-=8
      if warpIndexCheck[0]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*8,tMcY+tMSpc*9)
      if warpIndexCheck[1]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*13,tMcY+tMSpc*8)
      if warpIndexCheck[2]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*17,tMcY+tMSpc*7)
      if warpIndexCheck[3]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*19,tMcY+tMSpc*10)
      if warpIndexCheck[4]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*28,tMcY+tMSpc*7)
      if warpIndexCheck[5]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*10,tMcY+tMSpc*13)
      if warpIndexCheck[6]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*31,tMcY+tMSpc*10)
      if warpIndexCheck[7]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*25,tMcY+tMSpc*11)
      if warpIndexCheck[8]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*20,tMcY+tMSpc*17)
      if warpIndexCheck[9]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*36,tMcY+tMSpc*15)
      if warpIndexCheck[10]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*12,tMcY+tMSpc*4)
      if warpIndexCheck[11]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*33,tMcY+tMSpc*4)
      if warpIndexCheck[12]>0
        draw_sprite(sPauseM_MapTele,0,tMcX+tMSpc*32,tMcY+tMSpc*7)
    }
  }

  if tShowMap=1 {draw_sprite(sPauseM_MapLoc,mMap_CurFrame,contentMenuX+tMapLocX-4,contentMenuY+tMapLocY-4)}

  if subMenu=4
  {
    //-------------------- Display cursor --------------------
    mSAP_FrameCount+=1
    if mSAP_FrameCount mod 8=0
    {
      if mSAP_CurFrame=0 {mSAP_CurFrame=1}
      else {mSAP_CurFrame=0}
    }
    draw_sprite(sPauseM_MapCursor,mSAP_CurFrame,contentMenuX+9+(mMap_CurX*8),contentMenuY+19+(mMap_CurY*8))

    //Display map slot info
    if tMenuType=0 //Pause menu
    {
      if area_Name!=""
      {
        draw_set_color(textColorMain)
        draw_set_font(fnt_PauseMenuText)
        draw_set_halign(fa_left)
        draw_text(infoMenuX+87,infoMenuY+2,">>" +string(area_Name))
        draw_text(infoMenuX+314,infoMenuY+2,"Items: " +string(item_Num) +string("/") +string(item_Max))
      }
    }
  }
}
else
{
  menuExtraMaps(mMap_Submenu)
}
