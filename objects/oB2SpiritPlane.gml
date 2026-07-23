#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="B2 Spirit Plane"
eLevel=28
maxLife=800
life=maxLife
pointWorth=40
atkPower=10
resType[0]=1
resType[1]=1
resType[4]=5
resType[5]=4
stunResist=25
baseItemChance=80
baseDropIndex=90
affiliation=7
dieSound=0
dieEffect=0
bGenEnemy=1
detectDistX=300
detectDistY=240
inactiveDist=detectDistX*1.75

initDir=0
runAcc=7
bombTime=7
bombWait=13

jeremyText="Oh no, it's these again. Seriously, who thought it was a good idea to bring these things back?! Well anyway, they behave the same as before. Fly across and carpet bomb the hell out of the ground. Try to get to cover if you can. Something else to note is their bombs and resulting explosion will hit through your dash."
chaoText="These are from the SNES game 'U.N. Squadron'. I never played that one or even heard of it until looking up this sprite's origins."
devText="I liked these in DT1, though I know they weren't very well received. I feel they weren't utilized properly, like not having enough cover to avoid the missiles. This is especially important in DT3 where dashing is a bit more limited. Hopefully I can get them right this time..."
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
    //movement
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=true
    }
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    x+=xVel
    //shoot
    bombTime+=1
    if bombTime>=bombWait
    {
      playSound(global.snd_BombLaunch,0,0.85,36000)
      var tNewAtk;
      tNewAtk=instance_create(x,y+8,oB2Bomb)
      tNewAtk.atkPower=atkPower; tNewAtk.depth=26
      if image_xscale=1
      {
        tNewAtk.direction=350
        tNewAtk.image_angle=350
      }
      else
      {
        tNewAtk.direction=190
        tNewAtk.image_angle=190
      }
      tNewAtk.bulletSpeed=4
      bombTime=0
    }

    if findTargetX>inactiveDist/1.5
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    x+=2*image_xscale; y+=2
    if image_xscale=1 {image_angle-=2}
    else {image_angle+=2}
    if oGame.time mod 5=0
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      tEffect=instance_create(x+random_range(-32,32),y+random_range(-24,24),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    image_alpha-=0.035
    if image_alpha<0
    {
      playSound(global.snd_HardHit1,0,0.98,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
