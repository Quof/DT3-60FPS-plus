#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
bActive=true
bCanDealDamage=false
bShowHealthBar=false
hoverAlpha=-1
image_alpha=0.33
bIsBoss=true
bNoBonus=true

//Enemy base statistics
eName="Wall Master"
maxLife=2000
life=maxLife
atkPower=6
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[2]=5
affiliation=2

currHspd=0
currVspd=0

jeremyText="This unique enemy which should be in the Zelda Gates has a rather annoying attribute in that only its shadow will damage you. You can't hurt it and it can't hurt you. The hand itself will go after you, but really you need to watch out for that shadow.#This thing also cheats since it's hard to see where it's casting its shadow from."
chaoText="The Wall Masters have always had slightly different behavior for each Zelda game, I don't think any of them have ever dealt with shadows hurting you, though the shadow is how you knew it was coming from the ceiling..."
extraInfo="Can't be destroyed."
devText="Not only do I want the Nightmare Gates to be more difficult than their predecessors as well as carrying some of the same theme, I wanted them to have something unique. It's not always successful in that regard, but Gate C, I feel, found something unique. Overall, I wanted to keep things fairly simple with the execution. The shadows create seemingly complicated scenarios without actually being complex."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life=maxLife
  {
    if x>oPlayer1.x
      image_xscale=-1
    else
      image_xscale=1

    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
    myDist=round(myDist/32)
    if myDist>5
      myDist=5
    else if myDist<2
      myDist=2
    maxSpeed=myDist

    if x>oPlayer1.x
    {
      if currHspd>-maxSpeed
        currHspd-=0.08
      else
        currHspd=-maxSpeed
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed
        currHspd+=0.08
      else
        currHspd=maxSpeed
    }
    if y>oPlayer1.y-26
    {
      if currVspd>-maxSpeed
        currVspd-=0.08
      else
        currVspd=-maxSpeed
    }
    else if y<oPlayer1.y-26
    {
      if currVspd<maxSpeed
        currVspd+=0.08
      else
        currVspd=maxSpeed
    }
  }
  else
  {
    if life<1500 {life=1500}
    if oGame.time mod 2=0 {life+=5}
    if life>maxLife {life=maxLife}
    currHspd=0
    currVspd=0
  }
  hspeed=currHspd
  vspeed=currVspd
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}
