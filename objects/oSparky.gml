#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(-9,-16,9,-1)
image_speed=0

//Enemy base statistics
eName="Sparky"
eLevel=19
maxLife=300
life=maxLife
pointWorth=26
atkPower=4
resType[5]=4
stunResist=1
baseItemChance=65
baseDropIndex=95
weight=100

jumpTime=0
jumpDelay=25
sparkTime=60
sparkDelay=100
altBullets=0
mySpark=0

jeremyText="This has very similar behavior to another thing from our past, however, it can shoot lightning... a lot of lightning. It's also worth noting that its lightning attacks can be hard to see in some areas here."
chaoText="There's something I've been thinking about lately that I don't know if I'm willing to believe is true. It's probably nothing, I'm sure I'm just being overly nervous..."
devText="I wanted the Farreaches to be a lively pleasant area. For this, I used a bunch of small things and brought it all together. Such as the music, the cuddling and dancing flowers, to name a few."
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(mySpark) {with mySpark {instance_destroy()}}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if x>oPlayer1.x {image_xscale=-1}
  else {image_xscale=1}

  if bActive=true and stunnedTime=0
  {
    //Keep from moving too fast if blown away
    if xVel>8 {xVel=8}
    else if xVel<-8 {xVel=-8}
    if xVel>0 {xVel-=0.05}
    else if xVel<0 {xVel+=0.05}

    //Spark attack sequence
    sparkTime+=1
    if sparkTime=sparkDelay-15 {image_speed=0.33}
    else if sparkTime=sparkDelay
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_Spark,0,0.75,19000)}
      sprite_index=sSparkySparking
      mySpark=instance_create(x,y-8,oStaticBullet)
      mySpark.sprite_index=sSparkysSpark; mySpark.atkPower=atkPower
    }
    else if sparkTime>=sparkDelay+1 and sparkTime<=sparkDelay+70
    {
      mySpark.x=x; mySpark.y=y-8
      mySpark.image_angle+=29; mySpark.image_alpha=0.4+random(0.2)
      if sparkTime mod 20=0
      {
        var tNewAtk;
        for(i=0;i<4;i+=1)
        {
          tNewAtk=instance_create(x,y-8,oPassBullet)
          tNewAtk.sprite_index=sSparkyLightning; tNewAtk.image_speed=0.5
          tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=7; tNewAtk.decayTime=-100
          tNewAtk.direction=altBullets+(i*90)
        }
        if altBullets=0 {altBullets=45}
        else {altBullets=0}
      }
    }
    else if sparkTime>=sparkDelay+71
    {
      sprite_index=sSparkyDown
      image_speed=0
      with mySpark {instance_destroy()}
      sparkTime=0
    }

    yVel+=0.4
    if sprite_index!=sSparkySparking //Animation control
    {
      if yVel>=0 {sprite_index=sSparkyDown}
      else {sprite_index=sSparkyUp}
    }

    if isCollisionBottom(1)
    {
      yVel=0
      jumpTime+=1
      if jumpTime>=jumpDelay
      {
        jumpTime=0
        y-=4
        yVel=-8.25
      }
    }
    if isCollisionTop(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
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
