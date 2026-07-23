#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-9,-12,9,7)
image_speed=0.1

//Enemy base statistics
eName="Skultera"
eLevel=23
maxLife=170
life=maxLife
pointWorth=32
atkPower=8
resType[0]=2
resType[1]=2
resType[2]=4
resType[4]=4
stunResist=2
baseItemChance=65
baseDropIndex=80
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

if room=rSamus5_Lv3_O {inactiveDist=10000}

initDir=0
runAcc=2.75
turnTime=0

deathAnim=0

jeremyText="Huh... It looks like the program copied over the Skull Fish AI routine for these. The only difference I see is a speed increase and some slight difference in stats. I am picking up some weird anomaly in the code when it's on land though."
chaoText="'These creatures are fish with bony frames and joints that rotate mechanically.'#I found that bit in the Super Metroid manual. Something I found interesting, these have a rather keen resemblance to the Skull Fish and Desbrekos from the Zelda games."
devText="These had an issue for awhile where they would disappear when going off screen. It turned out that they were simply following their code correctly and couldn't swim without water. Since the water volume doesn't bleed off the edge of the map, they would fall off the side of the water. Of course, that was fixed."
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
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    if isCollisionWaterTop(0) //In water
    {
      image_angle=0
      if x>oCharacter.x and image_xscale=1
      {
        turnTime+=1
        x+=runAcc
      }
      else if x<oCharacter.x and image_xscale=-1
      {
        turnTime+=1
        x+=-runAcc
      }
      else
      {
        if point_distance(0,oPlayer1.y-18,0,y)<24 //In line with player, speed forward
        {
          if oGame.time mod 8=0
          {
            var tEffect;
            tEffect=instance_create(x+(8*(image_xscale*-1)),y,oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
            tEffect.image_speed=0.5; tEffect.image_blend=c_teal
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          x+=(runAcc*1.75)*image_xscale
        }
        else
          x+=runAcc*image_xscale

        if y>oPlayer1.y-18
        {
          if isCollisionWaterTop(12)
            y-=1
        }
        else if y<oPlayer1.y-18
          y+=1
      }

      if turnTime>=60
      {
        xVel*=-1
        turnTime=0
      }

      if !isCollisionWaterLeft(8) and xVel<0
      {
        xVel=runAcc
        turnTime=0
      }
      if !isCollisionWaterRight(8) and xVel>0
      {
        xVel=-runAcc
        turnTime=0
      }
    }
    else //Flop around out of water
    {
      yVel+=0.4
      if isCollisionBottom(1)
      {
        image_angle=random(360)
        xVel=random_range(-1.5,1.5)
        yVel=-random(2)-1.25
      }
      if isCollisionLeft(1)
        xVel=1
      if isCollisionRight(1)
        xVel=-1
      if isCollisionSolid()
        y-=2

      moveTo(xVel,yVel)
      if y>room_height+24
        instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-15,15),y+random_range(-4,4),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_speed=0
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
