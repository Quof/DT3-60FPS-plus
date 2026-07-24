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
eName="Boomerang Bro"
eLevel=5
maxLife=230
life=maxLife
pointWorth=9
atkPower=4
resType[1]=2
resType[2]=4
resType[3]=2
baseItemChance=50
baseDropIndex=90
affiliation=1
runAcc=0.5*gDeltaTime

throwTime=35
throwDelay=65
boomSpam=0
bEnraged=0

jeremyText="Definitely the quirkiest of the Bro koopa family. It throws a boomerang that arcs out and then comes back toward the Bro that threw it. The speed at which the boomerang is thrown is dependent on how close you are. The farther away, the faster it is. At least if you destroy the Bro that threw it, the boomerang itself is destroyed, or rather, it falls."
chaoText="I don't like their boomerang. It's really weird to me. These guys don't seem to care much either. Sure they do the enrage thing the other bros do, but I feel like they do it simply because they have nothing else better to do."
devText="The Boomerang Bro wasn't added into the game until much later in development. It had quite a few votes to be put in though and I knew where their unique weapon would be useful for the game's purpose."
extraInfo="Will become indifferent if his bros are beaten close by."
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
if gDeltaDoTicks != 1 { exit; }
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

      sprite_index=sBoomerBroWalk
      animSpd=0.1
    }
    else
    {
      xVel=0
      if throwTime<throwDelay
      {
        sprite_index=sBoomerBroThrow
        animSpd=0
        image_index=0
      }
    }
    if throwTime<throwDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Boomerang time ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //Init boomerang
      {
        sprite_index=sBoomerBroThrow
        image_index=0
        animSpd=0.5
      }
      else if throwTime>=throwDelay+1 and throwTime<=throwDelay+500
      {
        animSpd=0.33
        if bEnraged=1 {animSpd=1}

        if image_index>=6 //On boomerang frame
        {
          //Check distance to player
          var tNewAttack,tXshift,tXSpd,tDir;
          tXSpd=point_distance(x,0,oPlayer1.x,0)/32
          if bEnraged=1 {tXSpd+=irandom_range(-1.5,1.5)}

          if tXSpd>8 {tXSpd=8}
          else if tXSpd<3 {tXSpd=3}

          if image_xscale=1 {tXshift=9}
          else {tXshift=-9}

          if image_xscale=1
          {
            tDir=35
            if bEnraged=1 {tDir+=random_range(-4,4)}
          }
          else
          {
            tDir=145
            if bEnraged=1 {tDir+=random_range(-4,4)}
          }
          //Spit fire
          tNewAttack=instance_create(x+tXshift,y-12,oBroBoomerang)
          tNewAttack.atkPower=atkPower; tNewAttack.type=image_xscale; tNewAttack.direction=tDir
          tNewAttack.bulletSpeed=tXSpd; tNewAttack.myThrower=id

          //Boomerang spam
          boomSpam+=1
          if boomSpam>=4
          {
            image_index=0
            throwTime=throwDelay
            if bEnraged=1 and boomSpam>=10
            {
              animSpd=0
              bEnraged=0
              boomSpam=0
              throwTime=throwDelay+600
            }
            else if bEnraged=0 and boomSpam>=7
            {
              animSpd=0
              boomSpam=0
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
        sprite_index=sBoomerBroWalk
        animSpd=0.1
      }
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
//image_speed=animSpd
image_speed = 0
image_index += animSpd
