#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-14,7,-1)
image_speed=0.3

//Enemy base statistics
eName="Goomba"
maxLife=70
life=maxLife
pointWorth=3
atkPower=2
resType[2]=4
resType[3]=2
baseItemChance=50
affiliation=1
dieEffect=0
initDir=0
runAcc=1

deathAnim=0

jeremyText="Theres not much I have to say about Goombas that you shouldnt already know. It walks straight and slowly at that. Why are you scanning this? Its not like there's anything I'd be able to tell you thats new or interesting. Okay look down, it's twice as vulnerable to Elemental type attacks."
chaoText="Look at their little stubby legs, they're so cute! Can I pleeease have a house full of these?!"
devText="Hopefully this is the first thing you scan, since this message is kind of a general overview of what these 'Dev Comments' are. Which they are simply, well... commentary from me. Not necessarily on the enemy you're scanning, but sometimes on things around that enemy or just things I want to talk about."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
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
    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionSolid()
      y-=2
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
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
      if bJumpedOn=0
      {
        var tEffect;
        for(i=0;i<6;i+=1)
        {
          tEffect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
          tEffect.speed=2.66; tEffect.direction=i*60; tEffect.friction=0.11
          tEffect.fadeAlpha=0.025; tEffect.imageRot=0
        }
      }
    }
    else if deathAnim=12 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
if life>0 {event_inherited()}
else
{
  if bJumpedOn=1 {draw_sprite_part(sprite_index,2,0,0,16,4,x-6,y-4)}
}
magicInterpDrawEnd()
