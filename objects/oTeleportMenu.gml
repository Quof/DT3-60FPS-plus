#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mMap_Submenu=1
subMenu=4
textColorMain=make_color_rgb(240,240,240)
textColorShadow=make_color_rgb(0,120,72)
mMap_CurX=-1000
mMap_CurY=-1000
mMap_FrameCount=0
mMap_CurFrame=0
mSAP_FrameCount=0
mSAP_CurFrame=0
listFirst=-1
listLast=-1
for(i=0;i<=110;i+=1)
{
  mapIndexCheck[i]=string_char_at(global.mapAreas,i)
}

init=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if area=0 //Main
{
  maxIndex=13
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpMain,i+1)
    event_user(0)
  }
}
else if area=1 //Gate 1: Mario
{
  maxIndex=4
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate1,i+1)
    event_user(0)
  }
}
else if area=2 //Gate 2: Zelda
{
  maxIndex=8
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate2,i+1)
    event_user(0)
  }
}
else if area=3 //Gate 3: Belmont
{
  maxIndex=7
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate3,i+1)
    event_user(0)
  }
}
else if area=4 //Gate 4: Mega Man (Not used)
{
  maxIndex=1
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate4,i+1)
    event_user(0)
  }
}
else if area=5 //Gate 5: Samus (Not used)
{
  maxIndex=1
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate5,i+1)
    event_user(0)
  }
}
else if area=6 //Gate 6: Video Games
{
  maxIndex=1
  for(i=0;i<maxIndex;i+=1)
  {
    warpIndexCheck[i]=string_char_at(global.warpGate6,i+1)
    event_user(0)
  }
}
if listLast=-1
  listLast=listFirst
init=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[1]=1 //Back
{
  playSound(global.snd_MenuCursor,0,1,1)
  if telePos=listFirst
  {
    telePos=listLast
  }
  else
  {
    for(i=telePos-1;i<telePos;i-=1)
    {
      if warpIndexCheck[i-1]!=0
      {
        telePos=warpIndexCheck[i-1]
        break;
      }
    }
  }
}
else if oKeyCodes.kCodePressed[2]=1 //Forward
{
  playSound(global.snd_MenuCursor,0,1,1)
  if telePos=listLast
  {
    telePos=listFirst
  }
  else
  {
    for(i=telePos;i<maxIndex;i+=1)
    {
      if warpIndexCheck[i]!=0
      {
        telePos=warpIndexCheck[i]
        break;
      }
    }
  }
}

if oKeyCodes.kCodePressed[5]=1
{
  resetKeyCodes()
  if telePos!=gateNum
  {
    if area=0 //-------------------- MAIN WORLD --------------------
    {
      if telePos=1
      {
        newMapX=864
        newMapY=272
        toRoom=rMain_2
      }
      else if telePos=2
      {
        newMapX=288
        newMapY=192
        toRoom=rMain_5Gate
      }
      else if telePos=3
      {
        newMapX=1008
        newMapY=176
        toRoom=rMain_8
      }
      else if telePos=4
      {
        newMapX=128
        newMapY=288
        toRoom=rCCity_NorthA
      }
      else if telePos=5
      {
        newMapX=2016
        newMapY=96
        toRoom=rMain_14
      }
      else if telePos=6
      {
        newMapX=528
        newMapY=64
        toRoom=rMain_28
      }
      else if telePos=7
      {
        newMapX=800
        newMapY=1120
        toRoom=rMain_34
      }
      else if telePos=8
      {
        newMapX=288
        newMapY=368
        toRoom=rMain_39
      }
      else if telePos=9
      {
        newMapX=2464
        newMapY=400
        toRoom=rMain_48
      }
      else if telePos=10
      {
        newMapX=192
        newMapY=288
        toRoom=rMain_56
      }
      else if telePos=11
      {
        newMapX=160
        newMapY=256
        toRoom=rMain_67
      }
      else if telePos=12
      {
        newMapX=3456
        newMapY=432
        toRoom=rMain_84
      }
      else if telePos=13
      {
        newMapX=1088
        newMapY=272
        toRoom=rMain_78
      }
    }
    else if area=1 //-------------------- GATE 1 --------------------
    {
      if telePos=1
      {
        newMapX=312
        newMapY=160
        toRoom=rMario1_1
      }
      else if telePos=2
      {
        newMapX=64
        newMapY=224
        toRoom=rMario1_5Hub
      }
      else if telePos=3
      {
        newMapX=2800
        newMapY=112
        toRoom=rMario1_8
      }
      else if telePos=4
      {
        newMapX=64
        newMapY=480
        toRoom=rMario1_CCd
      }
    }
    else if area=2 //-------------------- GATE 2 --------------------
    {
      if telePos=1
      {
        newMapX=624
        newMapY=304
        toRoom=rLink2_HP
      }
      else if telePos=2
      {
        newMapX=120
        newMapY=304
        toRoom=rLink2_PalaceA_1
      }
      else if telePos=3
      {
        newMapX=128
        newMapY=288
        toRoom=rLink2_PalaceF_1
      }
      else if telePos=4
      {
        newMapX=440
        newMapY=304
        toRoom=rLink2_TownB_Ext
      }
      else if telePos=5
      {
        newMapX=144
        newMapY=304
        toRoom=rLink2_PalaceC_1
      }
      else if telePos=6
      {
        newMapX=144
        newMapY=320
        toRoom=rLink2_PalaceC_14
      }
      else if telePos=7
      {
        newMapX=152
        newMapY=240
        toRoom=rLink2_PalaceW_1
      }
      else if telePos=8
      {
        newMapX=1408
        newMapY=528
        toRoom=rLink2_PalaceW_10
      }
    }
    else if area=3 //-------------------- GATE 3 --------------------
    {
      if telePos=1
      {
        newMapX=128
        newMapY=304
        toRoom=rBelmont3_Entry
      }
      else if telePos=2
      {
        newMapX=144
        newMapY=288
        toRoom=rBelmont3_2A
      }
      else if telePos=3
      {
        newMapX=112
        newMapY=288
        toRoom=rBelmont3_3A
      }
      else if telePos=4
      {
        newMapX=416
        newMapY=288
        toRoom=rBelmont3_3E
      }
      else if telePos=5
      {
        newMapX=96
        newMapY=1056
        toRoom=rBelmont3_5A
      }
      else if telePos=6
      {
        newMapX=168
        newMapY=608
        toRoom=rBelmont3_6A
      }
      else if telePos=7
      {
        newMapX=3792
        newMapY=272
        toRoom=rBelmont3_7F
      }
    }
    else if area=4 //-------------------- GATE 4 --------------------
    {

    }
    else if area=5 //-------------------- GATE 5 --------------------
    {

    }
    else if area=6 //-------------------- GATE 6 --------------------
    {

    }

    playSound(global.snd_Teleport,0,0.95,19845)
    global.gamePaused=false
    global.recAreaTrans+=1
    global.newMapX=newMapX
    global.newMapY=newMapY
    global.desertHeat=1500
    writeToPlayerGlobals()
    transition_steps=15
    transition_kind=21
    room_goto(toRoom)
  }
}
else if oKeyCodes.kCodePressed[6]=1
{
  io_clear()
  resetKeyCodes()
  global.gamePaused=false
  instance_destroy()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if warpIndexCheck[i]="1"
{
  warpIndexCheck[i]=i+1
  if listFirst=-1
    listFirst=i+1
  else if listFirst!=-1
    listLast=i+1
}
else
  warpIndexCheck[i]=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
menuMap(1)
draw_set_color(c_black)
draw_set_alpha(1)
draw_rectangle(contentMenuX-4,contentMenuY+13,contentMenuX+325,contentMenuY+175,1)

draw_sprite_part(sTutorialBox,0,0,0,200,18,contentMenuX+65,contentMenuY-5)
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_middle)
draw_set_color(textColorMain)
draw_text(contentMenuX+164,contentMenuY-1,">> Teleport Interface <<")

area_Name=""

if area=0
{
  if telePos=1
  {
    area_Name="Initiate's Pass - West"
    mMap_CurX=8
    mMap_CurY=9
  }
  else if telePos=2
  {
    area_Name="Stratum Steppe Gate"
    mMap_CurX=13
    mMap_CurY=8
  }
  else if telePos=3
  {
    area_Name="Greatest Stretch - North"
    mMap_CurX=17
    mMap_CurY=7
  }
  else if telePos=4
  {
    area_Name="Central City - North"
    mMap_CurX=19
    mMap_CurY=10
  }
  else if telePos=5
  {
    area_Name="Magical Hills - Canopy"
    mMap_CurX=28
    mMap_CurY=7
  }
  else if telePos=6
  {
    area_Name="Begonia - Floating Isles"
    mMap_CurX=10
    mMap_CurY=13
  }
  else if telePos=7
  {
    area_Name="Farreaches - Bubble Tower"
    mMap_CurX=31
    mMap_CurY=10
  }
  else if telePos=8
  {
    area_Name="Farreaches - Consciousness"
    mMap_CurX=25
    mMap_CurY=11
  }
  else if telePos=9
  {
    area_Name="Barrens - Oasis"
    mMap_CurX=20
    mMap_CurY=17
  }
  else if telePos=10
  {
    area_Name="Burning Stretch - Land's End"
    mMap_CurX=36
    mMap_CurY=15
  }
  else if telePos=11
  {
    area_Name="Starry Skies - Windy Slopes"
    mMap_CurX=12
    mMap_CurY=4
  }
  else if telePos=12
  {
    area_Name="Highlands - Crossroads"
    mMap_CurX=33
    mMap_CurY=4
  }
  else if telePos=13
  {
    area_Name="Magical Treeless Pass"
    mMap_CurX=32
    mMap_CurY=7
  }
}
else if area=1
{
  if telePos=1
    area_Name="Mario World Gate"
  else if telePos=2
    area_Name="Toad Shack"
  else if telePos=3
    area_Name="Hammer Bro Fort Entrance"
  else if telePos=4
    area_Name="Cackletta's Castle"
}
else if area=2
{
  if telePos=1
    area_Name="Hidden Palace Entrance"
  else if telePos=2
    area_Name="Desert Palace Entrance"
  else if telePos=3
    area_Name="Forest Palace Entrance"
  else if telePos=4
    area_Name="Town of Some Where"
  else if telePos=5
    area_Name="Great Palace Entrance"
  else if telePos=6
    area_Name="Great Palace Depths"
  else if telePos=7
    area_Name="Water Palace Entrance"
  else if telePos=8
    area_Name="Water Palace Depths"
}
else if area=3
{
  if telePos=1
    area_Name="Castle Entry"
  else if telePos=2
    area_Name="Castle Dungeon"
  else if telePos=3
    area_Name="Castle Inner Sanctum"
  else if telePos=4
    area_Name="Castle Staircase"
  else if telePos=5
    area_Name="Castle Courtyard"
  else if telePos=6
    area_Name="Death's Flying Castle"
  else if telePos=7
    area_Name="Death's Hall"
}
else if area=4
{
  //None
}
else if area=5
{
  //None
}
else if area=6
{
  //None
}

draw_sprite_general(sTutorialBox,0,5,0,195,18,contentMenuX+230,contentMenuY+193,1,1,180,c_white,c_white,c_white,c_white,1)
draw_sprite_general(sTutorialBox,0,0,0,195,18,contentMenuX+294,contentMenuY+193,1,1,180,c_white,c_white,c_white,c_white,1)
draw_sprite_ext(sPauseM_AbilArrow,0,contentMenuX+24,contentMenuY+184,1,1,180,c_white,1)
draw_sprite(sPauseM_AbilArrow,0,contentMenuX+305,contentMenuY+184)
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_left)
draw_text(contentMenuX+43,contentMenuY+177,"Teleport to: [" +string(telePos) +string("] ") +string(area_Name))
