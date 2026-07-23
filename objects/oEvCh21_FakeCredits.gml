#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
myText=""
textSpd=0.5
spawnY=room_height-16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0 //-------------------- Fake credits --------------------
{
  sceneDelay+=1
  if sceneDelay=1
  {
    var tempMplay;
    tempMplay=findMusic(1003)
    playMusic(tempMplay,0,1)
    SS_SetSoundFreq(global.msc_IFC,11025)
  }
  else if sceneDelay=60 {myText="- Game Scenario & Story -"; event_user(0)}
  else if sceneDelay=120 {myText="Game Design:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=160 {myText="Story:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=200 {myText="Events & Scenario:   ZephyrBurst"; event_user(2)}
  else if sceneDelay=240 {myText="Platform Engine:   Martin Piecyk"; event_user(2)}
  else if sceneDelay>=300
  {
    with oCreditText {instance_destroy()}
    with oHexor_Rock
    {
      type=2
      moveSpd=4+random(3)
      direction=random(360)
    }
    stopAllMusic()
    oEvCh21MainA.fadeAlpha=0
    oHexor_Main.atkTime=0; oHexor_Main.atkProg=33
    playSound(global.snd_HardHit1,0,1,1)
    instance_destroy()
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
