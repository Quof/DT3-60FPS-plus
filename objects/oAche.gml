#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-4,-6,4,6)
image_speed=0.25

//Enemy base statistics
eName="Ache"
eLevel=7
maxLife=105
life=maxLife
pointWorth=9
atkPower=5
resType[1]=5
resType[2]=2
resType[3]=2
baseItemChance=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

detectDistY=288
atkDistX=48
atkProg=0
atkX=0
atkY=0

jeremyText="It waits for its prey to get close below it and then it swoops down and attacks."
chaoText="I didn't like the red versions of these with their fire. You couldn't shield the fire attacks."
devText="I've always felt my writing was weak on many fronts. Not necessarily the concepts, but the execution. It really surprised me when people got into the story of DT1 as it was more to justify going from point A to B. This is the biggest reason why I wanted to have a bit more story focus for DT3 and flesh out the world a bit more. Of course, I won't have the primary focus of DT suffer because of this."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true and stunnedTime=0
  {
    if atkProg=0 //Wait for player to get close
    {
      if findTargetX<atkDistX and y<oPlayer1.y and findTargetY<detectDistY
      {
        sprite_index=sAcheFly
        if x<oPlayer1.x
          atkX=1
        else
          atkX=-1
        atkY=11.5
        atkProg+=1
      }
    }
    else if atkProg=1 //Swoop down
    {
      x+=atkX
      y+=atkY

      if atkY>-8
        atkY-=0.35
      if (isCollisionTop(1) and atkY<-7) or y<=ystart
      {
        sprite_index=sAcheIdle
        atkX=0
        atkY=0
        atkProg=0
      }
    }
  }
  enemyStepEvent()
}
