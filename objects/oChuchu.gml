#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-6,-14,6,-1)
image_speed=0.2
image_xscale=1.5
image_yscale=1.5
electFrm=0

//Enemy base statistics
eName="Chuchu"
eLevel=9
maxLife=560
life=maxLife
pointWorth=16
atkPower=5
resType[0]=4
resType[1]=2
resType[2]=1
resType[5]=4
damageType="ELEMENTAL"
stunResist=7
baseItemChance=60
baseDropIndex=90
affiliation=2
dieEffect=3

initDir=0
turnTime=0
runAcc=0.75

electricTime=40
bElectric=0

jeremyText="You should know what Chuchus do, Jerry. But... ugh, just in case. They will periodically electrify themselves. During this they cannot move, but melee weapons will deal no damage and you will be electrocuted. In this case, don't use NORMAL type attacks against it while you see it electrified."
chaoText="It's another slime enemy... though it's kind of adorable."
devText="This enemy was added in much much later in the project. I typically worked on the game's events in order of beginning to end of the story. It wasn't until Chapter 18 that I went back and redid the Forest Temple from the Zelda 2 setup it had in the demo. This enemy wasn't added in until then either."
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
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x {xVel*=-1}
      initDir=1
    }

    if x>oPlayer1.x and xVel>0 {turnTime+=1}
    else if x<oPlayer1.x and xVel<0 {turnTime+=1}
    if turnTime>=10
    {
      xVel*=-1
      turnTime=0
    }

    //Electric
    electFrm+=0.4
    electricTime+=1
    if electricTime=80
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_Spark,0,0.89,25500)}
      xVel=0
      image_speed=0; image_index=3
      resType[0]=1
      damageType="ELEMENTAL"
      bElectric=1
    }
    else if electricTime>=81 and electricTime<=115
    {
      if electricTime mod 3=0
      {
        image_index+=1
        if image_index=6 {image_index=3}
      }
    }
    else if electricTime>=116
    {
      image_speed=0.2
      xVel=runAcc
      if x>oPlayer1.x {xVel*=-1}
      resType[0]=4
      damageType="NORMAL"
      bElectric=0
      var tDistChk;
      tDistChk=point_distance(x,y-6,oPlayer1.x,oPlayer1.y-26)/8
      electricTime=30-round(tDistChk)
      if electricTime<0 {electricTime=0}
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.weaponTag=0 and other.object_index=oLinkSword) or other.weaponTag=30 and bElectric=1
{
  with oPlayer1
    hitPlayer(other)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if bElectric=1
{
  draw_sprite_ext(sChuchuElectric,electFrm,x,y-8,2.5,2.5,0,c_white,1)
}
