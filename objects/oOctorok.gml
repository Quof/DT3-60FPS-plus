#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-6,-14,6,-1)
image_speed=0.2

//Enemy base statistics
eName="Octorok"
eLevel=7
maxLife=125
life=maxLife
pointWorth=9
atkPower=4
resType[1]=5
resType[2]=4
baseItemChance=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

shootTime=0
shootDelay=55

jeremyText="Stays in one place and hops. Once it reaches the height of it's short hop, it fires off a rock. Some of these even moved around. Ugh, this game gave me nightmares."
chaoText="Ever noticed how Octoroks are vastly different from game to game a lot of times?"
devText="The story for DT3 was written right after I finished the writing for DT2. There were a lot of things I wanted to do with DT1, but didn't have the skill to do it, or the game's overall design simply disallowed it. In a way, DT3 is what the first game should have been, at least in my eyes."
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
    shootTime+=1
    if shootTime>1 and shootTime<shootDelay-10
    {
      if x>oPlayer1.x
        image_xscale=-1
      else
        image_xscale=1
    }
    if shootTime=shootDelay-10
    {
      y-=4
      yVel=-2.4
    }
    if shootTime>=shootDelay
    {
      var tNewAttack,tOffsetShotX;
      if image_xscale=1
        tOffsetShotX=4
      else
        tOffsetShotX=-4
      tNewAttack=instance_create(x+tOffsetShotX,y-8,oNormalBullet)
      tNewAttack.sprite_index=sOctorokRock
      tNewAttack.atkPower=atkPower
      tNewAttack.bulletSpeed=7
      tNewAttack.image_speed=0.33
      if image_xscale=1
        tNewAttack.direction=0
      else
        tNewAttack.direction=180
      shootTime=0
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)

    if y>room_height+30
      instance_destroy()
  }
  enemyStepEvent()
}
