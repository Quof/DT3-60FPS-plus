#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: runAcc,bClockWise,currentDir
event_inherited()
image_speed=0.2
if global.currentMusic=503
{
  baseColor=make_color_rgb(255,160,160)
  image_blend=baseColor
}
else if global.currentMusic=504
{
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor
}

//Enemy base statistics
eName="Geemer"
eLevel=23
maxLife=95
life=maxLife
pointWorth=29
atkPower=7
resType[0]=2
resType[1]=2
resType[4]=5
baseItemChance=65
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

UP=0
DOWN=1
LEFT=2
RIGHT=3

jeremyText="It can stick to and crawl along any surface. I believe these have the original Metroid bug that causes them to spin midair if their surface is destroyed."
chaoText="In some of the Metroid games, these could extend their spikes when Samus was close. Did you know that Super Metroid's code refers to Geemers as Zoomers? But unlike other creatures that got a name change, Zoomers and Geemers became seperate species."
devText="For me, these are super iconic to the 2D Metroid games. They were the first enemy I encountered in the Metroid universe when playing the NES game way way back in time. They've certainly gotten easier to deal with as Samus gets more abilities through the years."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=106
{
  baseColor=make_color_rgb(30,200,255)
  image_blend=baseColor
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true
  {
    enemyFollowBorder()
    if bClockWise=0
    {
      if currentDir=0 {sprite_index=sMetGeemerB}
      else if currentDir=1 {sprite_index=sMetGeemerD}
      else if currentDir=2 {sprite_index=sMetGeemerA}
      else if currentDir=3 {sprite_index=sMetGeemerC}
    }
    else
    {
      if currentDir=0 {sprite_index=sMetGeemerD}
      else if currentDir=1 {sprite_index=sMetGeemerB}
      else if currentDir=2 {sprite_index=sMetGeemerC}
      else if currentDir=3 {sprite_index=sMetGeemerA}
    }
    enemyStepEvent()
  }
  else
  {
    makeEnemyActive(0)
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
