#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
myText=""
textSpd=32
spawnY=room_height-16

textLeft=16
textRight=464

endText=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0 //-------------------- Start music --------------------
{
  var tempMplay;
  tempMplay=findMusic(1025)
  playMusic(tempMplay,0,1)
  SS_SetSoundFreq(global.msc_Skyfall,88200)
  sceneDelay=0; sceneProgress+=1
}
else if sceneProgress=1 //-------------------- Game Scenario & Story --------------------
{
  sceneDelay+=1
  if sceneDelay=1 {myText="- Game Scenario & Story -"; event_user(0)}
  else if sceneDelay=2 {myText="Game Design:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=3 {myText="Story:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=4 {myText="Events & Scenario:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=5 {myText="Platform Engine:   Martin Piecyk"; event_user(2)}
  else if sceneDelay>=6 {sceneDelay=0; sceneProgress+=1}

  if sceneDelay=120 {global.optChaoRoam=1}
}
else if sceneProgress=2 //-------------------- Sprites & Tiles Rips --------------------
{
  sceneDelay+=1
  if sceneDelay=1 {myText="- Sprites & Tiles -"; event_user(0)}
  else if sceneDelay=2 {myText="A.J. Nitro"; event_user(1); myText="Akuri"; event_user(2); myText="Apocalypse"; event_user(3)}
  else if sceneDelay=3 {myText="Arima"; event_user(1); myText="Badassbill"; event_user(2); myText="Badbatman3"; event_user(3)}
  else if sceneDelay=4 {myText="BalladOfWindfishes"; event_user(1); myText="Barubary"; event_user(2); myText="Bean"; event_user(3)}
  else if sceneDelay=5 {myText="Blueyosh"; event_user(1); myText="Bmatsantos"; event_user(2); myText="BruceJuice"; event_user(3)}
  else if sceneDelay=6 {myText="ChaosMiles07"; event_user(1); myText="Chaofanatic"; event_user(2); myText="Colbydude"; event_user(3)}
  else if sceneDelay=7 {myText="CrimsonPenguin"; event_user(1); myText="daemoth"; event_user(2); myText="Darksouls20"; event_user(3)}
  else if sceneDelay=8 {myText="Darkwolf"; event_user(1); myText="Dazz"; event_user(2); myText="Deathbringer"; event_user(3)}
  else if sceneDelay=9 {myText="Dolphman"; event_user(1); myText="Doomtodeath"; event_user(2); myText="Drshnaps"; event_user(3)}
  else if sceneDelay=10 {myText="Dunkelschwamm"; event_user(1); myText="EternalLight"; event_user(2); myText="Fabio"; event_user(3)}
  else if sceneDelay=11 {myText="Fatty McGee"; event_user(1); myText="Fret"; event_user(2); myText="Gussprint"; event_user(3)}
  else if sceneDelay=12 {myText="Imfletcher"; event_user(1); myText="Indo Tenbuki"; event_user(2); myText="King metroid"; event_user(3)}
  else if sceneDelay=13 {myText="Knuckio The Chameleon"; event_user(1); myText="Lexou"; event_user(2); myText="Lord Zymeth"; event_user(3)}
  else if sceneDelay=14 {myText="Mario Gamer"; event_user(1); myText="Metroid345"; event_user(2); myText="Midi Waffle"; event_user(3)}
  else if sceneDelay=15 {myText="Mighty Jetters"; event_user(1); myText="Mr. G"; event_user(2); myText="Ngamer01"; event_user(3)}
  else if sceneDelay=16 {myText="Nitratez"; event_user(1); myText="No Body the Dragon"; event_user(2); myText="N-finity"; event_user(3)}
  else if sceneDelay=17 {myText="Obreck"; event_user(1); myText="Omega"; event_user(2); myText="Peltos"; event_user(3)}
  else if sceneDelay=18 {myText="Psychtaygar"; event_user(1); myText="Ragey"; event_user(2); myText="Rakia"; event_user(3)}
  else if sceneDelay=19 {myText="Random Talking Bush"; event_user(1); myText="redblueyellow"; event_user(2); myText="Rick N. Bruns"; event_user(3)}
  else if sceneDelay=20 {myText="riddler"; event_user(1); myText="Rocktyt"; event_user(2); myText="Rogultgot"; event_user(3)}
  else if sceneDelay=21 {myText="roket"; event_user(1); myText="rukifellth"; event_user(2); myText="Ryan914"; event_user(3)}
  else if sceneDelay=22 {myText="ShadeDBZ"; event_user(1); myText="SmithyGCN"; event_user(2); myText="SonicFreak"; event_user(3)}
  else if sceneDelay=23 {myText="Sonikku"; event_user(1); myText="Sonuna Hydris"; event_user(2); myText="SupaChao"; event_user(3)}
  else if sceneDelay=24 {myText="The Original Eevee"; event_user(1); myText="The Redhalberd"; event_user(2); myText="Tommy Lee"; event_user(3)}
  else if sceneDelay=25 {myText="Tonberry2k"; event_user(1); myText="tredog777"; event_user(2); myText="Turbo Thunderbolt"; event_user(3)}
  else if sceneDelay=26 {myText="Vaati"; event_user(1); myText="Vincent"; event_user(2); myText="Yawackhary"; event_user(3)}
  else if sceneDelay=27 {myText="zerofighter"; event_user(1); myText=""; event_user(2); myText=""; event_user(3)}
  else if sceneDelay=28 {myText="Original Sprites by:  RenaTurnip (TaviTurnip)"; event_user(1)}
  else if sceneDelay=29 {myText="NES Font by:  codeman38"; event_user(1)}
  else if sceneDelay>=30 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=3 //-------------------- Music & Sound --------------------
{
  sceneDelay+=1
  if sceneDelay=1 {myText="- Music & Sound -"; event_user(0)}
  else if sceneDelay=2 {myText="Autumn-Collapse"; event_user(1); myText="Bad-Atom"; event_user(2); myText="bassfiddlejones"; event_user(3)}
  else if sceneDelay=3 {myText="Beartheshadows"; event_user(1); myText="Blackaux"; event_user(2); myText="blackrose96"; event_user(3)}
  else if sceneDelay=4 {myText="BlueAngelEagle"; event_user(1); myText="Breis"; event_user(2); myText="cabose117"; event_user(3)}
  else if sceneDelay=5 {myText="Charem"; event_user(1); myText="Daniel Tidwell"; event_user(2); myText="Groovemaster303"; event_user(3)}
  else if sceneDelay=6 {myText="DayDreamingFox"; event_user(1); myText="DeatHTaX"; event_user(2); myText="DesoloZ"; event_user(3)}
  else if sceneDelay=7 {myText="DJ-HappyFace"; event_user(1); myText="DrMackFoxx"; event_user(2); myText="ectsoman"; event_user(3)}
  else if sceneDelay=8 {myText="EliteFerrex"; event_user(1); myText="Enzer0"; event_user(2); myText="EspioKaos"; event_user(3)}
  else if sceneDelay=9 {myText="F4LL0UT"; event_user(1); myText="F-777"; event_user(2); myText="GenoWhirled"; event_user(3)}
  else if sceneDelay=10 {myText="Guardian Soul"; event_user(1); myText="HighwindLegend"; event_user(2); myText="JakesFable"; event_user(3)}
  else if sceneDelay=11 {myText="Jake Kaufman"; event_user(1); myText="Jhalkompwdr"; event_user(2); myText="JonnyAtma"; event_user(3)}
  else if sceneDelay=12 {myText="Kayden Riggs"; event_user(1); myText="Kevin Leo Smith"; event_user(2); myText="KFNX"; event_user(3)}
  else if sceneDelay=13 {myText="Koori-kun"; event_user(1); myText="Kid2Will"; event_user(2); myText="Laikros"; event_user(3)}
  else if sceneDelay=14 {myText="LennartAlsing"; event_user(1); myText="Mattashi"; event_user(2); myText="Mazedude"; event_user(3)}
  else if sceneDelay=15 {myText="MetalMetroid"; event_user(1); myText="Miguel Volkov"; event_user(2); myText="Mozzaratti"; event_user(3)}
  else if sceneDelay=16 {myText="MusicWizard"; event_user(1); myText="NeXsard"; event_user(2); myText="NGXmusical"; event_user(3)}
  else if sceneDelay=17 {myText="NickPerrin"; event_user(1); myText="OneStepAhead"; event_user(2); myText="Peder B. Helland"; event_user(3)}
  else if sceneDelay=18 {myText="ProudOne"; event_user(1); myText="prsnth1111"; event_user(2); myText="RabidMedia"; event_user(3)}
  else if sceneDelay=19 {myText="Ritz190"; event_user(1); myText="sbproductions"; event_user(2); myText="Scaredsim"; event_user(3)}
  else if sceneDelay=20 {myText="smartpoetic"; event_user(1); myText="Step"; event_user(2); myText="TritoneAngel"; event_user(3)}
  else if sceneDelay=21 {myText="T-Free"; event_user(1); myText="XayberOptix"; event_user(2); myText="Yousuke Yasui"; event_user(3)}
  else if sceneDelay=22 {myText="ZombiePosessor"; event_user(1); myText=""; event_user(2); myText=""; event_user(3)}
  else if sceneDelay>=23 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=4 //-------------------- Testers --------------------
{
  sceneDelay+=1
  if sceneDelay=1 {myText="- Testers -"; event_user(0)}
  else if sceneDelay=2 {myText="Amatsu"; event_user(1); myText="Anomaly"; event_user(3)}
  else if sceneDelay=3 {myText="NegativeZeroZ"; event_user(1); myText="Koishi The Rock"; event_user(3)}
  else if sceneDelay=4 {myText="Slaix223"; event_user(1); myText="Slit08"; event_user(3)}
  else if sceneDelay>=5 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=5 //-------------------- Special Thanks --------------------
{
  sceneDelay+=1
  if sceneDelay=1 {myText="- Special Thanks -"; event_user(0)}
  else if sceneDelay=2 {myText="Alice"; event_user(1); myText="Beatrix"; event_user(3)}
  else if sceneDelay=3 {myText="Chele"; event_user(1); myText="Dave"; event_user(3)}
  else if sceneDelay=4 {myText="GreatEmerald"; event_user(1); myText="Hadriex"; event_user(3)}
  else if sceneDelay=5 {myText="Jeremy"; event_user(1); myText="Jerry"; event_user(3)}
  else if sceneDelay=6 {myText="Peter"; event_user(1); myText="RobinLSL"; event_user(3)}
  else if sceneDelay=7 {myText="WhattayaBrian"; event_user(1); myText=""; event_user(3)}
  else if sceneDelay>=8 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=6 //-------------------- End --------------------
{
  sceneDelay+=1
  if sceneDelay=30
  {
    endText+=1
    if endText>=8
    {
      SS_SetSoundFreq(global.msc_Skyfall,22050)
      stopAllMusic()
      sceneDelay=0; sceneProgress+=1
    }
    else {sceneDelay=25}
  }
}
else if sceneProgress=7 //-------------------- Wait till input and then back to title screen --------------------
{
  var tButtonCheck;
  tButtonCheck=0
  for(i=0;i<14;i+=1)
  {
    if oKeyCodes.kCodePressed[i]=1 {tButtonCheck=1}
  }
  if keyboard_check_pressed(vk_anykey) or tButtonCheck=1
  {
    playSound(global.snd_MenuCancel,0,1,1)
    room_goto(rTitle)
  }
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
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(0,0,room_width,room_height,0)

if endText>=1
{
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_set_font(fnt_NES)

  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+64,"Number of times you saw the Game Over screen:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+64,global.recDeathCount)
}
if endText>=2
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+80,"Amount of damage you took:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+80,global.recDmgTaken)
}
if endText>=3
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+96,"Number of times you were hit:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+96,global.recTimesHit)
}
if endText>=4
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+112,"Number of times you fell off the level:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+112,global.recFallenOffLevel)
}
if endText>=5
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+128,"Amount of money you lost from dying all the time:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+128,global.recInterLostDeath)
}
if endText>=6
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+144,"Number of times you hilariously drowned:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+144,global.recDrowned)
}
if endText>=7
{
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+textLeft,view_yview[0]+160,"Number of times you allowed your shield to break:")
  draw_set_halign(fa_right)
  draw_text(view_xview[0]+textRight,view_yview[0]+160,global.recShieldBroken)
}
if endText>=8
{
  draw_set_halign(fa_center)
  draw_set_font(fnt_Chapter)
  draw_text(view_xview[0]+240,view_yview[0]+208,"There, this reference was made!#Now go play something else!")
}
