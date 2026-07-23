#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
transition_steps=10
transition_kind=21
image_speed=0.33
placerFrm=0
instance_create(0,0,oScreenCutIn)
colorText=make_color_rgb(0,255,0)
global.pLife=global.pMaxLife

if global.gameProgress=1841 {global.gameProgress+=1}

cursorPos=1
cursorX=136
cursorY=72
placerX=267
placerY=214
updateCheck=1
itemCheck=0

text_Full=""
text_New=""
text_Pos=0

maverick[0]=string_char_at(global.gameGate4Prog,1)
maverick[1]=string_char_at(global.gameGate4Prog,2)
maverick[2]=string_char_at(global.gameGate4Prog,3)

choiceMade=0
flashWhite=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if choiceMade=0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    text_New=""; text_Pos=0
    if cursorPos=4 {cursorPos=1}
    else if cursorPos=5 {cursorPos=2}
    else if cursorPos=6 {cursorPos=3}
    else if cursorPos=7 {cursorPos=1}
    else if cursorPos=8 {cursorPos=3}
    updateCheck=1
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    text_New=""; text_Pos=0
    if cursorPos=1 {cursorPos=4}
    else if cursorPos=2 {cursorPos=5}
    else if cursorPos=3 {cursorPos=6}
    else if cursorPos=7 {cursorPos=4}
    else if cursorPos=8 {cursorPos=6}
    updateCheck=1
  }
  else if oKeyCodes.kCodePressed[1]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    text_New=""; text_Pos=0
    if cursorPos=1 {cursorPos=7}
    else if cursorPos=2 {cursorPos=1}
    else if cursorPos=3 {cursorPos=2}
    else if cursorPos=4 {cursorPos=7}
    else if cursorPos=5 {cursorPos=4}
    else if cursorPos=6 {cursorPos=5}
    else if cursorPos=8 {cursorPos=7}
    updateCheck=1
  }
  else if oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    text_New=""; text_Pos=0
    if cursorPos=1 {cursorPos=2}
    else if cursorPos=2 {cursorPos=3}
    else if cursorPos=3 {cursorPos=8}
    else if cursorPos=4 {cursorPos=5}
    else if cursorPos=5 {cursorPos=6}
    else if cursorPos=6 {cursorPos=8}
    else if cursorPos=7 {cursorPos=8}
    updateCheck=1
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    global.newMapX=cursorPos
    if cursorPos=1
    {
      choiceMade=1; stopAllMusic()
    }
    else if cursorPos=2
    {
      choiceMade=1; stopAllMusic()
    }
    else if cursorPos=3
    {
      choiceMade=1; stopAllMusic()
    }
    else if cursorPos=4
    {
      if global.gameProgress>=1850
      {
        choiceMade=1; stopAllMusic()
      }
    }
    else if cursorPos=5
    {
      if global.gameProgress>=1900
      {
        choiceMade=1; stopAllMusic()
      }
    }
    else if cursorPos=6
    {
      if global.gameProgress>=1950
      {
        choiceMade=1; stopAllMusic()
      }
    }
    else if cursorPos=7
    {
      choiceMade=1; stopAllMusic()
    }
    else if cursorPos=8
    {
      choiceMade=1
    }
  }
}

if updateCheck=1 //---------- STORM EAGLE ----------
{
  if cursorPos=1
  {
    cursorX=136; cursorY=72
    placerX=267; placerY=214
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.heartPiece,19); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,27); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,28); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,36); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,62); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,65); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,71); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,81); if indexCheck="1" {itemCheck+=1}
    if maverick[0]="9"
      text_Full=string("Location: Newtype Airport#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/8")
    else
      text_Full=string("Location: Newtype Airport#Target: Storm Eagle#Items Obtained: ") +string(itemCheck) +string("/8")
  }
  else if cursorPos=2 //---------- OVERDRIVE OSTRICH ----------
  {
    cursorX=241; cursorY=72
    placerX=148; placerY=204
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.heartPiece,20); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,29); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.heartEnergy,24); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,63); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,72); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,75); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,82); if indexCheck="1" {itemCheck+=1}
    itemCheck+=global.hasBoostedXCharge
    if maverick[1]="9"
      text_Full=string("Location: Motor Desert#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/8")
    else
      text_Full=string("Location: Motor Desert#Target: Overdrive Ostrich#Items Obtained: ") +string(itemCheck) +string("/8")
  }
  else if cursorPos=3 //---------- GRAVITY BEETLE ----------
  {
    cursorX=346; cursorY=72
    placerX=232; placerY=238
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.heartPiece,21); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,30); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.chestMoney,31); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.missilePack,6); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,73); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,83); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,84); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,85); if indexCheck="1" {itemCheck+=1}
    if maverick[2]="9"
      text_Full=string("Location: Toxic Jungle#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/8")
    else
      text_Full=string("Location: Toxic Jungle#Target: Toxic Seahorse?#Items Obtained: ") +string(itemCheck) +string("/8")
  }
  else if cursorPos=4 //---------- SIGMA STAGE 1 ----------
  {
    cursorX=136; cursorY=280
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.heartPiece,22); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.arrowQuiver,16); if indexCheck="1" {itemCheck+=1}
    if global.gameProgress>=1900
    {
      placerX=212; placerY=212
      text_Full=string("Location: Sigma's Fortress Outer#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else if global.gameProgress>=1850 and global.gameProgress<=1890
    {
      placerX=212; placerY=212
      text_Full=string("Location: Sigma's Fortress Outer#Target: -Unknown-#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else
    {
      placerX=-16; placerY=-16
      text_Full=string("Location: -Unknown-#Target: -Unknown-#Items Obtained: -Unknown-")
    }
  }
  else if cursorPos=5 //---------- SIGMA STAGE 2 ----------
  {
    cursorX=241; cursorY=280
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.chestMoney,32); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,64); if indexCheck="1" {itemCheck+=1}
    if global.gameProgress>=1950
    {
      placerX=212; placerY=200
      text_Full=string("Location: Sigma's Fortress Inner#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else if global.gameProgress>=1900 and global.gameProgress<=1940
    {
      placerX=212; placerY=200
      text_Full=string("Location: Sigma's Fortress Inner#Target: -Unknown-#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else
    {
      placerX=-16; placerY=-16
      text_Full=string("Location: -Unknown-#Target: -Unknown-#Items Obtained: -Unknown-")
    }
  }
  else if cursorPos=6 //---------- SIGMA STAGE 3 ----------
  {
    cursorX=346; cursorY=280
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.walletBoost,6); if indexCheck="1" {itemCheck+=1}
    indexCheck=string_char_at(global.weaponLevels,74); if indexCheck="1" {itemCheck+=1}
    if global.gameProgress>=1990
    {
      placerX=212; placerY=188
      text_Full=string("Location: Sigma's Fortress Core#Target: -Defeated-#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else if global.gameProgress>=1950 and global.gameProgress<=1989
    {
      placerX=212; placerY=188
      text_Full=string("Location: Sigma's Fortress Core#Target: Sigma#Items Obtained: ") +string(itemCheck) +string("/2")
    }
    else
    {
      placerX=-16; placerY=-16
      text_Full=string("Location: -Unknown-#Target: -Unknown-#Items Obtained: -Unknown-")
    }
  }
  else if cursorPos=7
  {
    cursorX=88; cursorY=176
    placerX=247; placerY=196
    itemCheck=0
    var indexCheck;
    indexCheck=string_char_at(global.weaponLevels,61); if indexCheck="1" {itemCheck+=1}
    text_Full=string("Location: Robot Factory#Target: None#Items Obtained: ") +string(itemCheck) +string("/1")
  }
  else if cursorPos=8
  {
    cursorX=393; cursorY=176
    placerX=325; placerY=240
    text_Full="Location: Mega Shop#Target: None#Items Obtained: n/a"
  }
  updateCheck=0
}

if choiceMade>=1 //After choice is made
{
  if choiceMade=1
  {
    playSound(global.snd_MMVictoryShine,0,0.95,1)
    flashWhite=1
  }
  choiceMade+=1
  if choiceMade=45
  {
    if global.newMapX=1
    {
      if maverick[0]="9"
      {
        global.newMapX=80; global.newMapY=192; room_goto(rMega4_StormA)
      }
      else {room_goto(rMega4_StageIntro)}
    }
    else if global.newMapX=2
    {
      if maverick[1]="9"
      {
        global.newMapX=128; global.newMapY=160; room_goto(rMega4_OstrichA)
      }
      else {room_goto(rMega4_StageIntro)}
    }
    else if global.newMapX=3
    {
      if maverick[2]="9"
      {
        global.newMapX=80; global.newMapY=272; room_goto(rMega4_ToxicJungleA)
      }
      else {room_goto(rMega4_StageIntro)}
    }
    else if global.newMapX=4
    {
      if global.gameProgress<=1890 {global.gamePaused=true; global.tempAction[0]=4}
      global.newMapX=80; global.newMapY=592; room_goto(rMega4_SigmaA1)
    }
    else if global.newMapX=5
    {
      if global.gameProgress<=1940 {global.gamePaused=true; global.tempAction[0]=5}
      global.newMapX=80; global.newMapY=640; room_goto(rMega4_SigmaB1)
    }
    else if global.newMapX=6
    {
      if global.gameProgress<=1980 {global.gamePaused=true; global.tempAction[0]=6}
      global.newMapX=96; global.newMapY=304; room_goto(rMega4_SigmaC1)
    }
    else if global.newMapX=7
    {
      global.newMapX=208; global.newMapY=304; room_goto(rMega4_Gate)
    }
    else if global.newMapX=8
    {
      global.newMapX=160; global.newMapY=312; room_goto(rMega4_Shop)
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Display map
draw_sprite(sMMMapMap,0,240,176)

//Display pipes
draw_sprite(sMMMapThingB,0,188,71)
draw_sprite(sMMMapThingB,0,293,71)
draw_sprite_ext(sMMMapThingB,0,187,279,1,1,180,c_white,1)
draw_sprite_ext(sMMMapThingB,0,292,279,1,1,180,c_white,1)
draw_sprite_ext(sMMMapThingC,0,95,106,-1,1,0,c_white,1)
draw_sprite(sMMMapThingC,0,386,106)
draw_sprite_ext(sMMMapThingC,0,94,244,1,1,180,c_white,1)
draw_sprite_ext(sMMMapThingC,0,385,244,-1,1,180,c_white,1)

//Display boss icons
if maverick[0]="9" {draw_sprite_ext(sMMMapBoss,0,136,72,1,1,0,c_gray,1)}
else {draw_sprite(sMMMapBoss,0,136,72)}
if maverick[1]="9" {draw_sprite_ext(sMMMapBoss,1,241,72,1,1,0,c_gray,1)}
else {draw_sprite(sMMMapBoss,1,241,72)}
if maverick[2]="9" {draw_sprite_ext(sMMMapBoss,2,346,72,1,1,0,c_gray,1)}
else {draw_sprite(sMMMapBoss,2,346,72)}
draw_sprite(sMMMapBoss,4,88,176)
draw_sprite(sMMMapBoss,5,393,176)

draw_set_alpha(1)
draw_set_font(fnt_GameOver)
draw_set_halign(fa_center)
if global.gameProgress>=1850 {draw_sprite(sMMMapBoss,3,136,280)}
else
{
  draw_set_color(c_black)
  draw_rectangle(114,258,158,302,0)
  draw_set_color(c_white)
  draw_text(136,260,"?")
}
if global.gameProgress>=1900 {draw_sprite(sMMMapBoss,3,241,280)}
else
{
  draw_set_color(c_black)
  draw_rectangle(219,258,263,302,0)
  draw_set_color(c_white)
  draw_text(241,260,"?")
}
if global.gameProgress>=1950 {draw_sprite(sMMMapBoss,3,346,280)}
else
{
  draw_set_color(c_black)
  draw_rectangle(324,258,368,302,0)
  draw_set_color(c_white)
  draw_text(346,260,"?")
}

//Display thingies
draw_sprite(sMMMapThingA,0,135,71)
draw_sprite(sMMMapThingA,0,240,71)
draw_sprite(sMMMapThingA,0,345,71)
draw_sprite(sMMMapThingA,0,87,175)
draw_sprite(sMMMapThingA,0,392,175)
draw_sprite(sMMMapThingA,0,135,279)
draw_sprite(sMMMapThingA,0,240,279)
draw_sprite(sMMMapThingA,0,345,279)

//Display map icon and info text
draw_set_alpha(1)
draw_set_font(fnt_StatRender)
draw_set_halign(fa_left)
if cursorPos=1 {draw_sprite(sMMMapLIcon,0,156,133)}
else if cursorPos=2 {draw_sprite(sMMMapLIcon,1,156,133)}
else if cursorPos=3 {draw_sprite(sMMMapLIcon,2,156,133)}
else {draw_sprite(sMMMapLIcon,3,156,133)}

if text_Pos<string_length(text_Full)
{
  textDropShadow(text_New,194,108,colorText,c_black,1)
  for(i=0;i<2;i+=1)
  {
    text_Pos+=1
    text_New+=string_char_at(text_Full,text_Pos)
  }
}
else {textDropShadow(text_Full,194,108,colorText,c_black,1)}

//Display cursor
placerFrm+=0.3
draw_sprite(sMMMapPlacer,placerFrm,placerX,placerY)
draw_sprite(sMMMapCursor,image_index,cursorX,cursorY)

//Flash white when level is chosen
if flashWhite>0
{
  draw_set_alpha(flashWhite)
  draw_set_color(c_white)
  draw_rectangle(-1,-1,room_width+1,room_height+1,0)
  flashWhite-=0.08
}
