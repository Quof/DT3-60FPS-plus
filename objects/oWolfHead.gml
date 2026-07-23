#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bDestroyOnDeactivate=true
inactiveDist=128

//Enemy base statistics
eName="Wolf Head"
eLevel=8
maxLife=95
life=maxLife
pointWorth=9
atkPower=4
resType[2]=2
resType[3]=4
baseItemChance=25
pickupDropMod=10
moneyWorth=0
affiliation=2
bGenEnemy=1
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

if x>oPlayer1.x
  image_xscale=-1
moveSpd=1
moveSegment=16
shootTime=20
moveProgress=0
moveTime=0

jeremyText="Up - Forward - Down - Forward, repeat. This is ALL these do, oh and don't forget about the annoying amount of projectile spam they send at you. If you don't kill them and stay in one spot for a long time, the amount of crap on screen... try not to put yourself in that situation."
chaoText="These worked just like the Skull Heads, but in this the sprite doesn't seem to be interchangable."
devText="One thing I don't use to gauge if something is 'too difficult' is how many attempts it takes me to complete a scenario. The number of attempts, when I thought about it, is a bad metric to use for this. It's a rather non-tangible thing to determine overall. Instead of designing for something being difficult though, I simply design an obstacle and give the player the tools to overcome that obstacle."
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
    //movement
    moveTime+=1
    if moveProgress=0 or moveProgress=2
    {
      if image_xscale=1
        x+=moveSpd
      else if image_xscale=-1
        x-=moveSpd

      if moveTime=moveSegment
      {
        var tNewAttack,tOffsetShotX;
          if image_xscale=1
          tOffsetShotX=4
        else
          tOffsetShotX=-4
        tNewAttack=instance_create(x+tOffsetShotX,y+4,oNormalBullet)
        tNewAttack.sprite_index=sWolfHeadShot
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
        if image_xscale=1 {tNewAttack.direction=0}
        else {tNewAttack.direction=180}
      }
    }
    else if moveProgress=1
      y+=moveSpd
    else if moveProgress=3
      y-=moveSpd

    if moveTime>=moveSegment
    {
      moveTime=0
      moveProgress+=1
      if moveProgress=4
        moveProgress=0
    }
  }
  enemyStepEvent()
}
