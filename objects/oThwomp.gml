#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-11*image_xscale,-15*image_yscale,11*image_xscale,15*image_yscale)
hoverAlpha=-1
image_speed=0

//Enemy base statistics
eName="Thwomp"
atkPower=6
affiliation=1
bCanTakeDamage=false
bShowHealthBar=false
atkSpeed=10
for(i=0;i<6;i+=1)
{
  resType[i]=1
}

atkProg=0
atkTime=0
detectDistY=288
atkDistX=36*image_xscale

jeremyText="Another classic Mario obstacle. When you get close to them, their expression will change, get a bit closer and they'll get angry and try to crush you."
chaoText="I always liked that in the 3D Mario games that you could stand on top of these. Don't try it here, it won't work."
if global.location=101 {devText="These two rooms in Gate A were designed to test the player's observation and timing skills. The level isn't timed so there's no pressure to keep moving forward at a quick pace. The level is quite intense so I wanted the player to be able to choose their own pace for it. I hope you all enjoy these optional levels, should you choose to take them on. The difficulty isn't quite linear, I find Gate B much easier than A."}
else {devText="I sometimes kick myself in the ass for not having these in DT1, so I made sure to include them all over the place in this game to make up for it... Eh, I guess they're not THAT common. Still, Thwomps are so iconic."}
extraInfo="Completely immune to damage."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true
  {
    if atkProg=0 //Check if player is close
    {
      if findTargetX<atkDistX*2 and y<oPlayer1.y and findTargetY<detectDistY
        image_index=1
      else
        image_index=0

      if findTargetX<atkDistX and y<oPlayer1.y and findTargetY<detectDistY
      {
        if global.location!=40
        {
          if random(100)<2
          {
            var newMessage,tRanMessage;
            newMessage=instance_create(x-46,y-70,oEnemyChat)
            tRanMessage=irandom_range(1,2)
            if tRanMessage=1 {newMessage.enemyMessage="IT'S MY TIME TO SHINE!"}
            else if tRanMessage=2 {newMessage.enemyMessage="IT'S SMASHING TIME!"}
          }
        }
        image_index=2
        yVel=atkSpeed
        atkProg+=1
      }
    }
    else if atkProg=1 //Falling
    {
      if isCollisionBottom(1)
      {
        playSound(global.snd_ThwompHit,0,1,1)
        var tEffect;
        tEffect=instance_create(x+12,bbox_bottom+2,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=1; tEffect.ySpd=0
        tEffect=instance_create(x-12,bbox_bottom+2,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_xscale=-1; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-1; tEffect.ySpd=0
        yVel=0
        if gDeltaDoTicks {y+=1}
        atkProg+=1
      }
    }
    else if atkProg=2 //Wait
    {
      atkTime+=1*gDeltaTime
      if atkTime=25
      {
        image_index=0
        yVel=-atkSpeed/3
        atkTime=0
        if gDeltaDoTicks {y-=1}
        atkProg+=1
      }
    }
    else if atkProg=3 //Return
    {
      if y<=ystart
      {
        y=ystart
        yVel=0
        atkProg=0
      }
    }
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  }
}
#define Collision_oMarioBreakBlock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=2
{
  with other
  {
    for(i=0;i<4;i+=1)
    {
      newEffect=instance_create(x+8,y+8,oEfMarioBlock)
      newEffect.type=i
    }
    instance_destroy()
  }
}
