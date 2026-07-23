#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-31,10,-1)
animSpd=0.1
image_speed=animSpd

//Enemy base statistics
eName="Fire Bro"
eLevel=5
maxLife=210
life=maxLife
pointWorth=9
atkPower=4
resType[1]=5
resType[2]=2
resType[3]=2
resType[4]=2
resType[5]=4
baseItemChance=50
baseDropIndex=90
affiliation=1
runAcc=0.5*gDeltaTime

throwTime=35
throwDelay=65
fireSpam=0
bEnraged=0

jeremyText="Another part of the Bro line of the Koopa family. Instead of hammers or boomerangs or whatever else the Bros come up with, these guys use a combination of quantum mechanics and fusion energy to form heat in their throats, which is then expelled from their mouth. Like their Hammer Bro counterpart, they to will rage after a buddy falls."
chaoText="They aren't so bad, you just have to jump over their fireballs. They're much easier to take out than Hammer Bros since the fire doesn't get thrown overhead. The bouncing is kind of annoying though."
devText="I've always thought of Hammer Bros to be a fairly tightly knit group, which is why their messages after you defeat a Bro near them are cries of sorrow for their fallen buddy. On the flip side, Fire Bros always had this assholish disposition, at least from my perspective..."
extraInfo="Will get overjoyed if his bros are beaten close by."
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oHammerBro)
{
  with oHammerBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="Broooooo!"
      }
      bEnraged=1
      if hammerSpam<3 {hammerSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
}
if instance_exists(oFireBro)
{
  with oFireBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="I didn't like him anyway."
      }
      bEnraged=1
      if fireSpam<3 {fireSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
}
if instance_exists(oBoomerBro)
{
  with oBoomerBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="Was he even my friend?"
      }
      bEnraged=1
      if boomSpam<3 {boomSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
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
    //---------- Movement ----------
    if point_distance(x,0,oPlayer1.x,0)>96 and throwTime<throwDelay
    {
      if x<oPlayer1.x {xVel=runAcc}
      else {xVel=-runAcc}
      sprite_index=sFireBroWalk
      animSpd=0.1
    }
    else
    {
      xVel=0
      if throwTime<throwDelay
      {
        sprite_index=sFireBroBreath
        animSpd=0
        image_index=0
      }
    }
    if throwTime<throwDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Fire time ----------
    throwTime+=1*gDeltaTime
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //Init fire
      {
        sprite_index=sFireBroBreath
        image_index=0
        animSpd=0.5
      }
      else if throwTime>=throwDelay+1 and throwTime<=throwDelay+500
      {
        animSpd=0.33*gDeltaTime
        if bEnraged=1 {animSpd=0.66}

        if image_index>=6 //On fire frame
        {
          //Check distance to player
          var tNewAttack, tXshift;
          if image_xscale=1 {tXshift=9}
          else {tXshift=-9}
          //Spit fire
          tNewAttack=instance_create(x+tXshift,y-12,oFireBFire)
          if tXshift<0
          {
            tNewAttack.image_xscale=-1
            tNewAttack.xVel=-6.5*gDeltaTime
          }
          else
            tNewAttack.xVel=6.5*gDeltaTime
          tNewAttack.atkPower=atkPower

          //Fire spam
          fireSpam+=1
          if fireSpam>=4
          {
            image_index=0
            throwTime=throwDelay
            if bEnraged=1 and fireSpam>=10
            {
              animSpd=0
              bEnraged=0
              fireSpam=0
              throwTime=throwDelay+600
            }
            else if bEnraged=0 and fireSpam>=7
            {
              animSpd=0
              fireSpam=0
              throwTime=throwDelay+600
            }
          }
          else
          {
            animSpd=0
            throwTime=throwDelay+600
          }
        }
      }
      else if throwTime>=throwDelay+608 //End attack
      {
        throwTime=0
        //sprite_index=sFireBroWalk
        animSpd=0.1*gDeltaTime
      }
    }

    yVel+=0.2*gDeltaTime*gDeltaTime
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    if xVel>0
      image_xscale=1
    else if xVel<0
      image_xscale=-1
    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
else
  animSpd=0
image_speed=animSpd
