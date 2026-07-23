#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=1
myText=""
textSpd=0.5
spawnY=room_height-16

skipConfirm=0

if room=rEnd_SceneA {fadeAlpha=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0 //Fade in
{
  if global.gameProgress>=5350 //True end
  {
    sceneDelay+=1
    if sceneDelay>=1 //75
    {
      fadeAlpha-=0.01
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else //Other end
  {
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=1 //-------------------- Start music --------------------
{
  sceneDelay+=1
  if sceneDelay=5 //Other end
  {
    if global.gameProgress<=5310
    {
      var tempMplay;
      tempMplay=findMusic(1003)
      playMusic(tempMplay,0,1)
      SS_SetSoundFreq(global.msc_IFC,11025)
    }
  }
  if sceneDelay>=30
  {
    if global.gameProgress>=5350 //True end
    {
      var tempMplay;
      tempMplay=findMusic(1021)
      playMusic(tempMplay,0,1)
      SS_SetSoundFreq(global.msc_Credits,21550)
    }
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=2 //-------------------- Game Scenario & Story --------------------
{
  sceneDelay+=1
  if sceneDelay=30 {myText="- Game Scenario & Story -"; event_user(0)}
  else if sceneDelay=90 {myText="Game Design:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=130 {myText="Story:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=170 {myText="Events & Scenario:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=210 {myText="Platform Engine:   Martin Piecyk"; event_user(2)}
  else if sceneDelay>=270 {sceneDelay=0; sceneProgress+=1}

  if sceneDelay=120 {global.optChaoRoam=1}
}
else if sceneProgress=3 //-------------------- Sprites & Tiles Rips --------------------
{
  sceneDelay+=1
  if sceneDelay=30 {myText="- Sprites & Tiles -"; event_user(0)}
  else if sceneDelay=90 {myText="A.J. Nitro"; event_user(1); myText="Akuri"; event_user(2); myText="Apocalypse"; event_user(3)}
  else if sceneDelay=130 {myText="Arima"; event_user(1); myText="Badassbill"; event_user(2); myText="Badbatman3"; event_user(3)}
  else if sceneDelay=170 {myText="BalladOfWindfishes"; event_user(1); myText="Barubary"; event_user(2); myText="Bean"; event_user(3)}
  else if sceneDelay=210 {myText="Blueyosh"; event_user(1); myText="Bmatsantos"; event_user(2); myText="BruceJuice"; event_user(3)}
  else if sceneDelay=250 {myText="ChaosMiles07"; event_user(1); myText="Chaofanatic"; event_user(2); myText="Colbydude"; event_user(3)}
  else if sceneDelay=290 {myText="CrimsonPenguin"; event_user(1); myText="daemoth"; event_user(2); myText="Darksouls20"; event_user(3)}
  else if sceneDelay=330 {myText="Darkwolf"; event_user(1); myText="Dazz"; event_user(2); myText="Deathbringer"; event_user(3)}
  else if sceneDelay=370 {myText="Dolphman"; event_user(1); myText="Doomtodeath"; event_user(2); myText="Drshnaps"; event_user(3)}
  else if sceneDelay=410 {myText="Dunkelschwamm"; event_user(1); myText="EternalLight"; event_user(2); myText="Fabio"; event_user(3)}
  else if sceneDelay=450 {myText="Fatty McGee"; event_user(1); myText="Fret"; event_user(2); myText="Gussprint"; event_user(3)}
  else if sceneDelay=490 {myText="Imfletcher"; event_user(1); myText="Indo Tenbuki"; event_user(2); myText="King metroid"; event_user(3)}
  else if sceneDelay=530 {myText="Knuckio The Chameleon"; event_user(1); myText="Lexou"; event_user(2); myText="Lord Zymeth"; event_user(3)}
  else if sceneDelay=570 {myText="Mario Gamer"; event_user(1); myText="Metroid345"; event_user(2); myText="Midi Waffle"; event_user(3)}
  else if sceneDelay=610 {myText="Mighty Jetters"; event_user(1); myText="Mr. G"; event_user(2); myText="Ngamer01"; event_user(3)}
  else if sceneDelay=650 {myText="Nitratez"; event_user(1); myText="No Body the Dragon"; event_user(2); myText="N-finity"; event_user(3)}
  else if sceneDelay=690 {myText="Obreck"; event_user(1); myText="Omega"; event_user(2); myText="Peltos"; event_user(3)}
  else if sceneDelay=730 {myText="Psychtaygar"; event_user(1); myText="Ragey"; event_user(2); myText="Rakia"; event_user(3)}
  else if sceneDelay=770 {myText="Random Talking Bush"; event_user(1); myText="redblueyellow"; event_user(2); myText="Rick N. Bruns"; event_user(3)}
  else if sceneDelay=810 {myText="riddler"; event_user(1); myText="Rocktyt"; event_user(2); myText="Rogultgot"; event_user(3)}
  else if sceneDelay=850 {myText="roket"; event_user(1); myText="rukifellth"; event_user(2); myText="Ryan914"; event_user(3)}
  else if sceneDelay=890 {myText="ShadeDBZ"; event_user(1); myText="SmithyGCN"; event_user(2); myText="SonicFreak"; event_user(3)}
  else if sceneDelay=930 {myText="Sonikku"; event_user(1); myText="Sonuna Hydris"; event_user(2); myText="SupaChao"; event_user(3)}
  else if sceneDelay=970 {myText="The Original Eevee"; event_user(1); myText="The Redhalberd"; event_user(2); myText="Tommy Lee"; event_user(3)}
  else if sceneDelay=1010 {myText="Tonberry2k"; event_user(1); myText="tredog777"; event_user(2); myText="Turbo Thunderbolt"; event_user(3)}
  else if sceneDelay=1050 {myText="Vaati"; event_user(1); myText="Vincent"; event_user(2); myText="Yawackhary"; event_user(3)}
  else if sceneDelay=1090 {myText="zerofighter"; event_user(1); myText=""; event_user(2); myText=""; event_user(3)}
  else if sceneDelay=1130 {myText="Original Sprites by:  RenaTurnip (TaviTurnip)"; event_user(1)}
  else if sceneDelay=1170 {myText="NES Font by:  codeman38"; event_user(1)}
  else if sceneDelay>=1230 {sceneDelay=0; sceneProgress+=1}

  /*if sceneDelay=500
  {
    chaoMoveTo=instance_create(144,-24,oMisc); chaoMoveTo.type=0; chaoMoveTo.sprite_index=sNull
    oIdentifier.followTarget=chaoMoveTo
    oIdentifier.effectDelay=1000000
  }*/
  if sceneDelay=800
  {
    if global.gameProgress>=5350 //True end
    {
      instance_create(144,-8,oChao_End); oChao_End.changeProg=1
    }
  }
}
else if sceneProgress=4 //-------------------- Music & Sound --------------------
{
  sceneDelay+=1
  if sceneDelay=30 {myText="- Music & Sound -"; event_user(0)}
  else if sceneDelay=90 {myText="Autumn-Collapse"; event_user(1); myText="Bad-Atom"; event_user(2); myText="bassfiddlejones"; event_user(3)}
  else if sceneDelay=130 {myText="Beartheshadows"; event_user(1); myText="Blackaux"; event_user(2); myText="blackrose96"; event_user(3)}
  else if sceneDelay=170 {myText="BlueAngelEagle"; event_user(1); myText="Breis"; event_user(2); myText="cabose117"; event_user(3)}
  else if sceneDelay=210 {myText="Charem"; event_user(1); myText="Daniel Tidwell"; event_user(2); myText="Groovemaster303"; event_user(3)}
  else if sceneDelay=250 {myText="DayDreamingFox"; event_user(1); myText="DeatHTaX"; event_user(2); myText="DesoloZ"; event_user(3)}
  else if sceneDelay=290 {myText="DJ-HappyFace"; event_user(1); myText="DrMackFoxx"; event_user(2); myText="ectsoman"; event_user(3)}
  else if sceneDelay=330 {myText="EliteFerrex"; event_user(1); myText="Enzer0"; event_user(2); myText="EspioKaos"; event_user(3)}
  else if sceneDelay=370 {myText="F4LL0UT"; event_user(1); myText="F-777"; event_user(2); myText="GenoWhirled"; event_user(3)}
  else if sceneDelay=410 {myText="Guardian Soul"; event_user(1); myText="HighwindLegend"; event_user(2); myText="JakesFable"; event_user(3)}
  else if sceneDelay=450 {myText="Jake Kaufman"; event_user(1); myText="Jhalkompwdr"; event_user(2); myText="JonnyAtma"; event_user(3)}
  else if sceneDelay=490 {myText="Kayden Riggs"; event_user(1); myText="Kevin Leo Smith"; event_user(2); myText="KFNX"; event_user(3)}
  else if sceneDelay=530 {myText="Koori-kun"; event_user(1); myText="Kid2Will"; event_user(2); myText="Laikros"; event_user(3)}
  else if sceneDelay=570 {myText="LennartAlsing"; event_user(1); myText="Mattashi"; event_user(2); myText="Mazedude"; event_user(3)}
  else if sceneDelay=610 {myText="MetalMetroid"; event_user(1); myText="Miguel Volkov"; event_user(2); myText="Mozzaratti"; event_user(3)}
  else if sceneDelay=650 {myText="MusicWizard"; event_user(1); myText="NeXsard"; event_user(2); myText="NGXmusical"; event_user(3)}
  else if sceneDelay=690 {myText="NickPerrin"; event_user(1); myText="OneStepAhead"; event_user(2); myText="Peder B. Helland"; event_user(3)}
  else if sceneDelay=730 {myText="ProudOne"; event_user(1); myText="prsnth1111"; event_user(2); myText="RabidMedia"; event_user(3)}
  else if sceneDelay=770 {myText="Ritz190"; event_user(1); myText="sbproductions"; event_user(2); myText="Scaredsim"; event_user(3)}
  else if sceneDelay=810 {myText="smartpoetic"; event_user(1); myText="Step"; event_user(2); myText="TritoneAngel"; event_user(3)}
  else if sceneDelay=850 {myText="T-Free"; event_user(1); myText="XayberOptix"; event_user(2); myText="Yousuke Yasui"; event_user(3)}
  else if sceneDelay=890 {myText="ZombiePosessor"; event_user(1); myText=""; event_user(2); myText=""; event_user(3)}
  else if sceneDelay>=950 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=5 //-------------------- Testers --------------------
{
  sceneDelay+=1
  if sceneDelay=30 {myText="- Testers -"; event_user(0)}
  else if sceneDelay=90 {myText="Amatsu"; event_user(1); myText="Anomaly"; event_user(3)}
  else if sceneDelay=130 {myText="NegativeZeroZ"; event_user(1); myText="Koishi The Rock"; event_user(3)}
  else if sceneDelay=170 {myText="Slaix223"; event_user(1); myText="Slit08"; event_user(3)}
  else if sceneDelay>=230 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=6 //-------------------- Special Thanks --------------------
{
  sceneDelay+=1
  if sceneDelay=30 {myText="- Special Thanks -"; event_user(0)}
  else if sceneDelay=90 {myText="Alice"; event_user(1); myText="Beatrix"; event_user(3)}
  else if sceneDelay=130 {myText="Chele"; event_user(1); myText="Dave"; event_user(3)}
  else if sceneDelay=170 {myText="GreatEmerald"; event_user(1); myText="Hadriex"; event_user(3)}
  else if sceneDelay=210 {myText="Jeremy"; event_user(1); myText="Jerry"; event_user(3)}
  else if sceneDelay=250 {myText="Peter"; event_user(1); myText="RobinLSL"; event_user(3)}
  else if sceneDelay=290 {myText="WhattayaBrian"; event_user(1); myText=""; event_user(3)}

  if global.gameProgress>=5350 //True end +220
  {
    if sceneDelay=410 {myText="Another thanks to the testers for#putting up with me and sticking with#the project for so long."; event_user(1)}
    else if sceneDelay>=470 {sceneDelay=0; sceneProgress+=1}
  }
  else //False end +60
  {
    if sceneDelay>=350 {sceneDelay=0; sceneProgress+=1}
  }
}
else if sceneProgress=7 //-------------------- Fade out --------------------
{
  sceneDelay+=1
  if sceneDelay>=600
  {
    if global.gameProgress>=5350 //True end
    {
      if sceneDelay=600 {oChao_End.image_index=1}
      else if sceneDelay=604 {oChao_End.image_index=2}
      else if sceneDelay=608 {oChao_End.image_index=3}
      else if sceneDelay=612 {oChao_End.image_index=4}
      else if sceneDelay=616 {oChao_End.image_index=3}
      else if sceneDelay=620 {oChao_End.image_index=2}
      else if sceneDelay=624 {oChao_End.image_index=3}
      else if sceneDelay=628 {oChao_End.image_index=4}
      else if sceneDelay=632 {oChao_End.image_index=3}
      else if sceneDelay=636 {oChao_End.image_index=2}
      else if sceneDelay=640 {oChao_End.image_index=3}
      else if sceneDelay=644 {oChao_End.image_index=4}
      else if sceneDelay=648 {oChao_End.image_index=3}
      else if sceneDelay=652 {oChao_End.image_index=2}
      else if sceneDelay=656 {oChao_End.image_index=3}
      else if sceneDelay=660 {oChao_End.image_index=4}
      else if sceneDelay=664 {oChao_End.image_index=3}
      else if sceneDelay=668 {oChao_End.image_index=2}
      else if sceneDelay=672 {oChao_End.image_index=1}
      else if sceneDelay=676 {oChao_End.image_index=0}
    }
  }
  if sceneDelay>=610
  {
    fadeAlpha+=0.01
    if fadeAlpha>=1 {global.gamePaused=1; sceneDelay=0; sceneProgress+=1}
  }
}
else if sceneProgress=8 //-------------------- End --------------------
{
  sceneDelay+=1
  if global.gameProgress>=5350 //True end?
  {
    if sceneDelay>=60 //Save that game was completed
    {
      global.newMapX=176; global.newMapY=256
      room_goto(rEnd_SceneB)
    }
  }
  else //Other end
  {
    if sceneDelay=1
    {
      fadeAlpha=0
      oBadEnd.sceneDelay=0
      oBadEnd.sceneProgress=2
    }
  }
}

if skipConfirm>0 {skipConfirm-=0.02}

if oKeyCodes.kCodePressed[11]=1 and sceneProgress<8 //Cutscene skip
{
  if skipConfirm>0
  {
    skipConfirm=0
    bWaitForInput=false
    with oMessageCutscene {instance_destroy()}
    fadeAlpha=0; sceneDelay=0
    sceneProgress=8
  }
  else {skipConfirm=1}
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Header Text
var tCreditText;
tCreditText=instance_create(240,spawnY,oCreditText)
tCreditText.myText=myText
tCreditText.mySpd=textSpd
tCreditText.myFont=fnt_Chapter
tCreditText.myAlign=fa_center
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Left Text
var tCreditText;
tCreditText=instance_create(24,spawnY,oCreditText)
tCreditText.myText=myText
tCreditText.mySpd=textSpd
tCreditText.myFont=fnt_GOoptions
tCreditText.myAlign=fa_left
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Middle Text
var tCreditText;
tCreditText=instance_create(240,spawnY,oCreditText)
tCreditText.myText=myText
tCreditText.mySpd=textSpd
tCreditText.myFont=fnt_GOoptions
tCreditText.myAlign=fa_center
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Right Text
var tCreditText;
tCreditText=instance_create(456,spawnY,oCreditText)
tCreditText.myText=myText
tCreditText.mySpd=textSpd
tCreditText.myFont=fnt_GOoptions
tCreditText.myAlign=fa_right
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if skipConfirm>0
{
  draw_set_alpha(skipConfirm)
  draw_set_color(c_white)
  draw_set_halign(fa_right)
  textDropShadow("- Skip? -",view_xview[0]+468,view_yview[0]+330,c_white,c_black,1)
}
