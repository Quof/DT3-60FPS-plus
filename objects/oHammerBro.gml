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
eName="Hammer Bro"
eLevel=5
maxLife=220
life=maxLife
pointWorth=9
atkPower=4
resType[3]=2
resType[4]=5
baseItemChance=50
affiliation=1
runAcc=0.5*gDeltaTime

throwTime=45
throwDelay=70
hammerSpam=0
bEnraged=0

jeremyText="These guys are actually easier than what you would find in a Mario game, however you need to be careful when there's more than one of them around. If you beat a Bro, all the nearby Bros will become enraged for a moment and hammer spam. This is really bad when they're in large mixed groups. If there's no way around it, plan an escape route beforehand. Every 4 hammer throws, they also have a much tamer and controlled hammer spam."
chaoText="Hammer Bros are always so mean! I think it's cool that they look after each other here though, like we do...#This makes me sad now."
devText="Both this and the Fire Bro went through a few revisions. I couldn't have the throwing frequency of their original counterpart, especially due to the player size. I did want it in though... somehow. That's where the angering idea came in. This also brings up points where the player would need to think about what order to defeat closely placed Bros. There are situations set up with that idea in mind."
extraInfo="Will get angered if his bros are beaten close by."
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
      sprite_index=sHammerBroWalk
      animSpd=0.1*gDeltaTime
    }
    else
    {
      xVel=0
      if throwTime<throwDelay
      {
        sprite_index=sHammerBroThrow
        animSpd=0
        image_index=5
      }
    }
    if throwTime<throwDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Hammer time ----------
    throwTime+=1*gDeltaTime
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //Init hammer throw
      {
        sprite_index=sHammerBroThrow
        image_index=0
        animSpd=0.5
      }
      else if throwTime>=throwDelay+1 and throwTime<=throwDelay+500
      {
        animSpd=0.5
        if bEnraged=1 {animSpd=1}

        if image_index>=6 //On throw frame
        {
          //Check distance to player
          var tNewAttack,tXshift,tXThrow;
          tXThrow=point_distance(x,0,oPlayer1.x,0)/64
          if bEnraged=1 {tXThrow+=irandom_range(-1.5,1.5)}

          if tXThrow>8 {tXThrow=8}
          else if tXThrow<0.75 {tXThrow=0.75}

          if image_xscale=1
            tXshift=7
          else
          {
            tXshift=-7
            tXThrow*=-1
          }
          //Throw hammer
          tNewAttack=instance_create(x+tXshift,y-20,oGravityBullet)
          tNewAttack.sprite_index=sHammerBHam
          if tXThrow<0 {tNewAttack.image_xscale=-1}
          tNewAttack.atkPower=atkPower
          tNewAttack.xVel=tXThrow*gDeltaTime
          tNewAttack.yVel=(-6-bEnraged)*gDeltaTime

          //Hammer spam
          hammerSpam+=1
          if hammerSpam>=4
          {
            image_index=0
            throwTime=throwDelay
            if bEnraged=1 and hammerSpam>=11
            {
              animSpd=0
              bEnraged=0
              hammerSpam=0
              throwTime=throwDelay+600
            }
            else if bEnraged=0 and hammerSpam>=7
            {
              animSpd=0
              hammerSpam=0
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
        //sprite_index=sHammerBroWalk QWH
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
#define Other_23
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bEnraged=1
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,11)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="U Mad Bro"; tAchievement.checkNum=11
  }
}
