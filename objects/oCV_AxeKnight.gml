#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-11,-44,11,-1)
image_speed=0

//Enemy base statistics
eName="Axe Knight"
eLevel=14
maxLife=400
life=maxLife
pointWorth=19
atkPower=5
resType[3]=2
resType[4]=4
stunResist=7
baseItemChance=65
moneyWorth=5
affiliation=3
dieEffect=0

runAcc=2.5
walkAcc=1
walkTime=0
walkChange=round(random(30)+20)

throwTime=45
throwDelay=70
throwHeight=0

deathAnim=0

jeremyText="It tries to keep itself at a reasonable distance and then lob axes at you. Or axerangs since they come back. What would you even call something like that?"
chaoText="Oh that one hallway with the Axe Knights was horrible. I didn't know that Holy Water could stun and insta-kill them back then."
devText="The hallway with these guys and the Medusa Heads is an obvious nod to a part in the original Castlevania that brought me tons of headache. Of course with DT's mechanics, unless there's a few traps, it's not going to be as hectic, and I'm not going to reach for that level this early on in the Gate. That room is more like a nod to it. (Yep, spoilers if you haven't reached that room yet. This will be an incredibly rare occurence.)"
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
    image_index+=0.2
    if sprite_index=sCV_AxeKnight_Walk
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      if point_distance(x,0,oPlayer1.x,0)>112
      {
        if x<oPlayer1.x {xVel=runAcc}
        else {xVel=-runAcc}
      }
      else if point_distance(x,0,oPlayer1.x,0)<108
      {
        if x<oPlayer1.x {xVel=-walkAcc}
        else {xVel=walkAcc}
      }
      else {xVel=0}
    }
    else {xVel=0}

    //---------- Throw axerang ----------
    throwTime+=1
    if point_distance(x,0,oPlayer1.x,0)<112 and throwTime<throwDelay-5
    {
      if oGame.time mod 2=0 {throwTime+=1}
    }

    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //change anim
      {
        if random(100)<2.5
        {
          var newMessage;
          newMessage=instance_create(x-46,y-100,oEnemyChat)
          newMessage.enemyMessage="I'd like to axe you a question."
        }
        image_index=0
        var tThrowArc; tThrowArc=0
        if point_distance(0,y,0,oPlayer1.y)<8 {tThrowArc=10}
        else if point_distance(0,y,0,oPlayer1.y)>56 {tThrowArc=-10}

        if random(100)+tThrowArc>50 {sprite_index=sCV_AxeKnight_ThrowDown}
        else {sprite_index=sCV_AxeKnight_ThrowUp}
      }
      else if throwTime=throwDelay+9 //Throw axerang
      {
        if checkScreenArea(x,y,48)=1 {playSound(global.snd_ChargeStrike,0,0.91,40000)}
        var tNewAttack,tOffsetY;
        tOffsetY=0
        if sprite_index=sCV_AxeKnight_ThrowUp {tOffsetY=32}
        tNewAttack=instance_create(x-(4*image_xscale),y-13-tOffsetY,oDoomknockerHammerang)
        tNewAttack.sprite_index=sAxeKnightAxe; tNewAttack.image_xscale=image_xscale
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5.25*image_xscale
      }
      else if throwTime=throwDelay+15 //End attack
      {
        sprite_index=sCV_AxeKnight_Walk
        throwTime=0
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
    moveTo(xVel,yVel)

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sCV_AxeKnight_ThrowDown
      image_index=2
      image_speed=0
    }
    if deathAnim mod 3=0
    {
      if deathAnim mod 6=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-15,15),y-1-random(52),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
