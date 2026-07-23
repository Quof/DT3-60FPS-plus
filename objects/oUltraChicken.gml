#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0
bShowHealthBar=false
bCanTakeDamage=false
image_xscale=4; image_yscale=4
bIsBoss=1
hoverAlpha=-1
bActive=1

//Enemy base statistics
eName="Ultra Chicken"
eLevel=1000
maxLife=100000000
life=maxLife
pointWorth=7
atkPower=16
stunResist=50
affiliation=2
dieEffect=0
initDir=0
flyTime=0
flyAcc=8
bSpotted=0

baseColor=make_color_rgb(255,130,130)
image_blend=baseColor

jeremyText="That WAS kind of a dick move you guys."
chaoText="Well... that happened."
devText="Yep."
extraInfo="... ... ..."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0
  {
    flyTime+=1
    if initDir=0
    {
      myDir=player_sprite_center()
      initDir=1
    }
    if flyTime mod 3=0
    {
      if image_index=2 {image_index=3}
      else {image_index=2}
    }
    direction=myDir
    speed=flyAcc
    if direction>90 and direction<270 {image_xscale=-4}
    else {image_xscale=4}
  }
  enemyStepEvent()
}
else {speed=0}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if flyTime>=30
{
  instance_destroy()
}
