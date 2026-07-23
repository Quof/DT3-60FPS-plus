#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Gamet"
eLevel=20
maxLife=85
life=maxLife
pointWorth=10
atkPower=7
resType[0]=2
resType[1]=2
resType[4]=5
stunResist=1
baseItemChance=20
baseDropIndex=55
pickupDropMod=20
moneyWorth=0
affiliation=5
bGenEnemy=1
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

eProg=0
moveMin=0

jeremyText="This simply flies up out of its spawning pipe and flies in whatever direction you were at, limited to left and right."
chaoText="In the 2D games, these sometimes came out in vertical groups of 5. One also appeared on the first episode of 'Captain N'. Sigh, that show was really bad."
devText="I remember seeing 'Captain N' when I was really young and liking that show. My roommate, Jerry, had the series on DVD and we rewatched some of the episodes. I didn't remember it being so horrible, made for some cheap laughs though."

if global.currentMusic=502
{
  eName="Geega"
  sprite_index=sMetGeega
  jeremyText=jeremyText +string("#This variant is only found in Brinstar.")
}
else if global.currentMusic=503
{
  eName="Gamet"
  sprite_index=sMetGamet
  jeremyText=jeremyText +string("#This variant is only found in Norfair.")
  devText="This is actually the same object as the Geega enemy found in the Brinstar area of this Gate. Since I knew these would never be used outside of this Gate or their specified areas, the sprite is based on which music ID is playing."
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if eProg=0
    {
      if x>=oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
      y-=3

      moveMin+=1
      if moveMin>=7 {if y<=oPlayer1.y-26 {eProg=1}}
    }
    else if eProg>=1 and eProg<=15
    {
      eProg+=1
      if x>=oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}
    }
    else if eProg>=16 {x+=5*image_xscale}
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
