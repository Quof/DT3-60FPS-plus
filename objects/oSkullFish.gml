#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-7,15,7)

//Enemy base statistics
eName="Skull Fish"
eLevel=8
maxLife=220
life=maxLife
pointWorth=12
atkPower=5
resType[1]=2
resType[2]=4
resType[5]=4
baseItemChance=50
affiliation=2
dieEffect=0
initDir=0
runAcc=2.25
turnTime=0
inactiveDist*=1.5

deathAnim=0

jeremyText="It's just a fish with low tracking capabilities. Although when it has you in its sights, it starts to speed toward you. When it's not underwater well... it's like a fish out of water."
chaoText="Ewwwww, another gross looking... thing! Why do all the monsters from Demon's Crest look so gross?"
devText="The obvious influence for the Gate 2 final level is Ocarina of Time's Water Temple and all its headaches and memorable...ness? ... So anyway, I wanted to get that same feel when the player has to stop and think about how the water is affecting the level layout. Of course, having water affect other elements was also a big thing. That way it could also be used outside of the level as well."
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
      image_speed=0.1
      sprite_index=sSkullFishSwim
      bCanDealDamage=true

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
        if point_distance(0,oPlayer1.y-26,0,y)<24 //In line with player, speed forward
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
        {
          x+=runAcc*image_xscale
        }

        if y>oPlayer1.y-26
        {
          if isCollisionWaterTop(12)
            y-=0.5
        }
        else if y<oPlayer1.y-26
          y+=0.5
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
      image_speed=0.3
      sprite_index=sSkullFishOnLand
      bCanDealDamage=false

      yVel+=0.4
      if isCollisionBottom(1)
      {
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
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-15,15),y+random_range(-4,4),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
