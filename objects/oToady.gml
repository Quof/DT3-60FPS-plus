#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
propFrm=0
frameProg=0

//Enemy base statistics
eName="Toady"
eLevel=18
maxLife=300
life=maxLife
pointWorth=10
atkPower=4
baseItemChance=10
moneyWorth=0
affiliation=1

jeremyText="I looked over its behavior data and I can't find anything for it. Like... did someone forget to link this to any behaviors?"
chaoText="These are those mean things that would come and take Baby Mario away in Yoshi's Island. I don't want this to come off the wrong way, but by the time they showed up, I was kinda happy about it... What?! That crying was awful to my ears!"
devText="I asked the testers to each design me up to 2 maps for the B side of Bubble Tower and had a few restrictions for them to follow. One of which were they could request new enemy types as long as they were simple. Slit08 simply wanted a floating Mario enemy so it could be used as a one time lift. That was... well about as simple as it could get. Request granted! It also worked for other places, so it made its way to those too."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)

  frameProg+=1
  if frameProg=4 {propFrm=1}
  else if frameProg=8 {propFrm=2}
  else if frameProg=12 {propFrm=3}
  else if frameProg=16 {propFrm=2}
  else if frameProg=20 {propFrm=1}
  else if frameProg=24 {propFrm=0; frameProg=0}

  if bActive=true and stunnedTime=0
  {
    if x<oPlayer1.x
      image_xscale=1
    else
      image_xscale=-1
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite(sToadyProp,propFrm,x,y)
