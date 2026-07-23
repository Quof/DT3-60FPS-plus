#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveType,moveSpd,turnDelay,turnDegree,sightX,sightY
event_inherited()
bActive=true

//Enemy base statistics
eName="CHAOS Seeker"
eLevel=32
maxLife=240
life=maxLife
pointWorth=40
atkPower=16
stunResist=50
baseItemChance=70
affiliation=7
dieSound=0
dieEffect=0

alertMode=0
alertTime=0
alertNotice=0
alertNScale=0
movePause=0
pointX=0
pointY=0
turnTime=0
scanDegree=turnDegree
moveMod=1
boostResist=0

deathAnim=0

jeremyText="A few things to note. If you damage it or get caught on just the edge of its sight, it'll go into a warning mode and seek out the position you are at the moment the event occurred. If it does see you, it goes into an alert mode and will seek out your current position for about 5 seconds. That timer, however, will reset anytime you're within its sights. Keep in mind it cannot see through walls."
chaoText="You can tell what mode it's in by the sight color.#Blue: Patrol mode - It's calm.#Yellow: Warn mode - It thinks something is out there.#Red: Alert mode - It knows where its target is and will hunt them down.#Note that every time you deal damage to one, its warn mode speed increases. This sprite is from 'Phantasy Star 4' on the Sega Genesis."
devText="I had always planned to have a semi-stealth level in DT3, but it was cut during development. It was later re-added to the plans, but was once again cut. Looks like it made its way in though."

myPath=path_add()

direction=initDir
myRange=instance_create(x,y,oCS_Range)
myRange.ownerID=id
myRange.image_xscale=sightX
myRange.image_yscale=sightY

myDoorA=instance_create(xstart-512,0,oSeekerDoor)
myDoorA.seekerID=id
myDoorB=instance_create(xstart+512,0,oSeekerDoor)
myDoorB.seekerID=id
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if alertMode=0 //Not alert
    {
      myRange.image_blend=c_blue
      for(i=0;i<6;i+=1) {resType[i]=3}; resType[4]=2; resType[5]=2
      if boostResist=1 {resType[1]=2; resType[3]=2}

      if moveType=0 //Move in a set path (stop for a moment before turning around)
      {
        turnTime+=1
        if turnTime<turnDelay {speed=moveSpd}
        else {speed=0}
        if turnTime>=turnDelay+10
        {
          direction+=turnDegree
          turnTime=0
        }
      }
      else if moveType=1 //Spin in circle
      {
        direction+=turnDegree
      }
      else if moveType=2 //Scan(rotate) to set range
      {
        if turnTime<turnDelay {direction+=scanDegree}
        turnTime+=1
        if turnTime>=turnDelay+20
        {
          scanDegree*=-1
          turnTime=0
        }
      }
    }
    else if alertMode=1 //Go toward point (Just checking)
    {
      myRange.image_blend=c_yellow
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      if movePause=0
      {
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,pointX,pointY,1)
        spdChk=(moveSpd*0.9)*moveMod
        if spdChk<2 {spdChk=2}
        else if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)
        if point_distance(x,y,pointX,pointY)<(moveSpd*0.9)*moveMod
        {
          movePause=10
          alertMode=2
        }
      }
      else {movePause-=1}
    }
    else if alertMode=2 //Go back to position
    {
      myRange.image_blend=c_yellow
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      if movePause=0
      {
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,xstart,ystart,1)
        spdChk=moveSpd*1.25
        if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)
        if point_distance(x,y,xstart,ystart)<moveSpd*1.25
        {
          speed=0
          direction=initDir
          scanDegree=turnDegree
          path_end()
          turnTime=0
          alertMode=0
        }
      }
      else {movePause-=1}
    }
    else if alertMode=3 //Search for player
    {
      myRange.image_blend=c_red
      for(i=0;i<6;i+=1) {resType[i]=2}; resType[4]=1; resType[5]=1
      if boostResist=1 {resType[1]=1; resType[3]=1}

      alertTime-=1
      if alertTime<=120
      {
        mp_grid_path(oCS_Grid.myGrid,myPath,x,y,oPlayer1.x,returnPlayerYCenter(),1)
        spdChk=moveSpd*0.6
        if spdChk<1.5 {spdChk=1.5}
        else if spdChk>5 {spdChk=5}
        path_start(myPath,spdChk,2,1)

        if oGame.time mod 10=0
        {
          if !collision_line(x+lengthdir_x(21,direction),y+lengthdir_y(21,direction),oPlayer1.x,returnPlayerYCenter(),oSolid,1,1)
          {
            tNewAttack=instance_create(x+lengthdir_x(21,direction),y+lengthdir_y(21,direction),oNormalBullet)
            tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
            tNewAttack.direction=image_angle
          }
        }
      }
      if alertTime<=0
      {
        alertMode=2
      }
    }

    if boostResist=0 //Boost PIERCE and SHOT resist at half HP
    {
      if life<=maxLife/2
      {
        boostResist=1
      }
    }

    image_angle=direction
    myRange.x=x+lengthdir_x(21,direction)
    myRange.y=y+lengthdir_y(21,direction)
    myRange.image_angle=direction
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with myRange {instance_destroy()}
    }
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.075
    if image_alpha<0
    {
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else
{
  speed=0
  path_end()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
if alertMode=0
{
  movePause=10
  alertNotice=1
  alertNScale=0
  alertMode=1
  speed=0
  pointX=oPlayer1.x
  pointY=returnPlayerYCenter()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if alertMode<3
{
  if alertMode=0
  {
    movePause=10
    alertNotice=1
    alertNScale=0
  }
  moveMod+=0.25
  myRange.image_blend=c_yellow
  pointX=oPlayer1.x
  pointY=oPlayer1.y-26
  alertMode=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if alertNotice>0 //Alert Icon
{
  draw_sprite_ext(sC_AlertNotice,0,x,y-24,alertNScale,alertNScale,0,c_white,1)

  if alertNotice=1
  {
    alertNScale+=0.2
    if alertNScale=1 {alertNotice=2}
  }
  else if alertNotice>=2
  {
    alertNotice+=1
    if alertNotice>=15 {alertNotice=0}
  }
}
