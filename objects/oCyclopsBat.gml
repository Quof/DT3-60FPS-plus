#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()

//Enemy base statistics
eName="Cyclops Bat"
eLevel=9
maxLife=220
life=maxLife
pointWorth=12
atkPower=4
resType[0]=2
resType[1]=4
resType[5]=4
baseItemChance=60
affiliation=2
dieEffect=0
initDir=0
runAcc=1.75
weight=90
turnTime=0

deathAnim=0

jeremyText="Kind of gross looking, don't you agree? It just flies in one direction and will track you after awhile. It takes it a moment to adjust itself though. It can also arc its height toward you if needed. It has a Normal resistance, so be careful about that."
chaoText="This gross bat thing is from Demon's Crest. Kind of weird to see it in an area like this. Get rid of it fast, it's so gross."
devText="When I was younger, I played Demon's Crest a lot. I'm fairly certain I beat it 100% roughly 3 times, which includes the Dark Demon fight. My two favorite aspects of Demon's Crest was how each ability allowed you access to more of the world and its secrets, much like how Metroid games play out. The other was the bosses and how varied each one was. (Ignoring the palette swaps.)"
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

    if isCollisionWaterTop(0)
    {
      image_speed=0.1
      x+=xVel/2
    }
    else
    {
      image_speed=0.2
      x+=xVel
    }

    if x>oCharacter.x and image_xscale=1
      turnTime+=1
    else if x<oCharacter.x and image_xscale=-1
      turnTime+=1
    else
    {
      if y>oPlayer1.y-26
        y-=0.25
      else if y<oPlayer1.y-26
        y+=0.25
    }

    if turnTime>=60
    {
      xVel*=-1
      turnTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      image_speed=0; image_index=3
      deathAnim=3
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-7,7),y+random_range(-7,7),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
