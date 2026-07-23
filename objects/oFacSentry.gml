#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-16,16,-1)
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0
bInfected=0
gunAngle=90

//Enemy base statistics
eName="Facility Sentry"
eLevel=31
maxLife=470
life=maxLife
pointWorth=45
atkPower=9
resType[0]=2
resType[1]=1
resType[4]=4
resType[5]=2
stunResist=7
baseItemChance=60
baseDropIndex=90
moneyWorth=5
bombResist=0

//Movement Data
runAcc=1.25
myDir=0
turnTime=0
behavior=0
bStop=0
changeTime=0
myDistX=0

//Weapon Data
shotTime=20
shotDelay=75
shotNum=0

bIsBoss=1
chaoText="Its movement pattern changes periodically. It'll either try to move toward you, away from you, or... some weird erratic thing.#I like when it does its erratic movement, it kinda looks like it's dancing."
devText="Originally the music for this level was going to be the 'Main Gate' theme from 'Mega Man Legends', but the 'Mother Zone' theme from 'Mega Man Legends 2' fit the level better."

myInfectSpot=instance_create(x,y,oInfectMe)
myInfectSpot.myOwner=id
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
    changeTime+=1
    if changeTime>=120 //Change behavior
    {
      behavior=0
    }

    myDistX=point_distance(x,0,oPlayer1.x,0)
    if behavior=0 //Decide on a movement action
    {
      turnTime=0
      if myDistX<=64 {behavior=2; changeTime=90}
      else if myDistX>=128 {behavior=1; changeTime=105}
      else {behavior=3; changeTime=75}
      if random(10)<3.5 {behavior=choose(1,2,3)}
    }
    else if behavior=1 //Move toward player
    {
      if myDir=1 and x<oPlayer1.x {turnTime-=1}
      else if myDir=-1 and x>oPlayer1.x {turnTime-=1}

      if turnTime<=0
      {
        turnTime=15
        if x<oPlayer1.x {myDir=1}
        else {myDir=-1}
      }
    }
    else if behavior=2 //Move away from player player
    {
      if myDir=1 and x>oPlayer1.x {turnTime-=1}
      else if myDir=-1 and x<oPlayer1.x {turnTime-=1}

      if turnTime<=0
      {
        turnTime=15
        if x>oPlayer1.x {myDir=1}
        else {myDir=-1}
      }
    }
    else if behavior=3 //Move back and forth
    {
      turnTime-=1
      if turnTime<=0
      {
        turnTime=10
        if x>oPlayer1.x {myDir=1}
        else {myDir=-1}
        if bStop=0 {bStop=1}
        else
        {
          myDir=0
          bStop=0
        }
      }
    }
    xVel=runAcc*myDir
    image_index+=0.25*myDir

    if bInfected=1 //If infected
    {
      if x>oPlayer1.x {gunAngle=myDistX/5+90}
      else {gunAngle=-myDistX/5+90}

      shotTime+=1
      if shotTime=shotDelay //Attack warn
      {
        var tEffect;
        for(i=0;i<7;i+=1)
        {
          tEffect=instance_create(x+random_range(-12,12),y-2-random(6),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
          tEffect.image_speed=0.5; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-1.5-random(1.5)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        }
      }
      else if shotTime=shotDelay+15
      {
        var targetYVel,tNewAttack;
        targetYVel=intercept_target_arc(oPlayer1,8,0.3)

        if targetYVel>9 {targetYVel=9}
        else if targetYVel<-9 {targetYVel=-9}

        if x>oPlayer1.x {tDir=-1}
        else {tDir=1}
        tNewAttack=instance_create(x,y-16,oFSentBomb)
        tNewAttack.atkPower=atkPower; tNewAttack.grav=0.3
        tNewAttack.xVel=8*tDir; tNewAttack.yVel=targetYVel

        shotNum+=1
        if shotNum>=2
        {
          shotNum=0
          shotTime=0
        }
        else {shotTime=shotDelay-9}
      }
    }

    if bombResist=1 //Increase resist against Explosive damage
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=4; tAtkShield.atkUp=1
      resType[4]=1
      bombResist=2
    }

    yVel+=0.3
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
      if instance_exists(myInfectSpot)
      {
        with myInfectSpot {instance_destroy()}
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myInfectSpot)
{
  with myInfectSpot {instance_destroy()}
}
bIsBoss=0
jeremyText="It fires bullets made of explodium with near pinpoint precision. I don't think the bots in the Data Segment even had this kind of precision. Interesting thing to note, it has a vulnerability to EXPLOSION type damage, but when one is hit with that type, all other spawned Sentries will become completely immune to EXPLOSIVE damage."
bCanDealDamage=true
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
bActive=1
bInfected=1
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION"
{
  with oFacSentry
  {
    if bombResist=0 {bombResist=1}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sFacilitySentryGun,0,x,y-15,image_xscale,image_yscale,gunAngle,image_blend,image_alpha)
event_inherited()
