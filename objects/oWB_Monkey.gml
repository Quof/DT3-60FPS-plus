#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-22,10,-1)
image_speed=0.15

//Enemy base statistics
eName="Monster Monkey"
eLevel=14
maxLife=290
life=maxLife
pointWorth=21
atkPower=5
resType[4]=4
resType[5]=2
stunResist=2
baseItemChance=70
baseDropIndex=90
moneyWorth=5
dieEffect=0
runAcc=2

bJumpReady=2
throwTime=40
throwDelay=80
throwProg=0

deathAnim=0
yDeath=0

jeremyText="Monkeys... monkeys are gross. I don't like them or anything having to do with them. Go around, just do anything you can to avoid monkeys. They're just... ugh."
chaoText="Monkeys like to jump around and throw things... luckily these are throwing coconuts."
devText="During these early chapters, I wanted the game to be a bit calm on the overworld segments since all of the Gate chapters tend to ramp up the difficulty toward the end. The beginning of the early chapters are breathers."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //---------- Movement ----------
    if bJumpReady>=1 and throwTime<throwDelay
    {
      if x<oPlayer1.x
        xVel=runAcc
      else
        xVel=-runAcc

      if bJumpReady=1 {bJumpReady=2} //Delay 1 frame
      else if bJumpReady=2
      {
        if point_distance(x,0,oPlayer1.x,0)<96
        {
          xVel=(runAcc*1.25)*image_xscale
          image_speed=0
          y-=4
          yVel=-6
          bJumpReady=0
        }
      }

      if yVel=0 //Jump up cliff
      {
        if aiCheckHoriz(0,2,16,16,-8)=1
        {
          y-=4
          yVel=-6
          bJumpReady=0
        }
      }
    }

    //---------- Coconut throw ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //Init coconut throw
      {
        if point_distance(x,0,oPlayer1.x,0)<192
        {
          sprite_index=sWB_Monkey_Throw
          image_index=0
          image_speed=0
          xVel=0
        }
        else {throwTime=throwDelay-15}
      }
      else if throwTime=throwDelay+10
      {
        image_index=1
        //Check distance to player
        var tNewAttack,tXThrow;
        tXThrow=point_distance(x,0,oPlayer1.x,0)/64
        if tXThrow>6 {tXThrow=6}
        else if tXThrow<0.75 {tXThrow=0.75}

        tXThrow+=throwProg
        //Throw Coconut
        tNewAttack=instance_create(x-(8*image_xscale),y-20,oGravityBullet)
        tNewAttack.sprite_index=sMonkeyCoconut
        if tXThrow<0 {tNewAttack.image_xscale=-1}
        tNewAttack.atkPower=atkPower
        tNewAttack.xVel=tXThrow*image_xscale
        tNewAttack.yVel=-6+(throwProg/2)
        if throwProg=1
          throwTime=throwDelay+99
        else
        {
          throwProg+=1
          throwTime=throwDelay+41
        }
      }
      else if throwTime=throwDelay+50
      {
        image_index=0
        throwTime=throwDelay+9
      }
      else if throwTime=throwDelay+100 //End attack
      {
        sprite_index=sWB_Monkey_Walk
        image_speed=0.15
        throwProg=0
        throwTime=0
      }
    }

    yVel+=0.2
    if isCollisionBottom(1)
    {
      if bJumpReady=0
      {
        image_speed=0.15
        bJumpReady=1
      }
      yVel=0
    }
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
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sWB_Monkey_Die
      yDeath=-6
    }
    else if deathAnim>=2
    {
      y+=yDeath
      if yDeath<12 {yDeath+=0.3}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
