#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Menace Spawn"
eLevel=10
maxLife=205
life=maxLife
pointWorth=5
atkPower=4
resType[2]=5
stunResist=1
affiliation=3
lifeTime=390

currHspd=0
currVspd=0

jeremyText="These are given off from Menace to distract you. Though they'll eventually dissipate on their own, you can destroy them as well."
chaoText="What?! Something else that's stolen my movement style!"
devText="The Giant Bat at the beginning of this Gate was much simpler in the demo build, as were the Zelda 2 bosses of Gate 2. Eventually I went back and revamped them to add a bit more and make them more interesting. Helmet Head got the most changes of them all. In the demo build, he was nearly identical to the Zelda 2 version."
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
    if x>oPlayer1.x
      image_xscale=-1
    else
      image_xscale=1

    myDist=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
    myDist=round(myDist/32)
    if myDist>9
      myDist=9
    else if myDist<3
      myDist=3
    maxSpeed=myDist

    if x>oPlayer1.x
    {
      if currHspd>-maxSpeed
        currHspd-=0.1
      else
        currHspd=-maxSpeed
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed
        currHspd+=0.1
      else
        currHspd=maxSpeed
    }
    if y>oPlayer1.y-26
    {
      if currVspd>-maxSpeed
        currVspd-=0.1
      else
        currVspd=-maxSpeed
    }
    else if y<oPlayer1.y-26
    {
      if currVspd<maxSpeed
        currVspd+=0.1
      else
        currVspd=maxSpeed
    }
    hspeed=currHspd
    vspeed=currVspd
  }
  else
  {
    hspeed=0
    vspeed=0
  }
  enemyStepEvent()

  lifeTime-=1
  if lifeTime=0
  {
    var tExplode;
    tExplode=instance_create(x,y,oM_PoisonBreath)
    tExplode.atkPower=atkPower; tExplode.bulletSpeed=0; tExplode.animSpeed=0.25
    instance_destroy()
  }
}
else
{
  hspeed=0
  vspeed=0
}
