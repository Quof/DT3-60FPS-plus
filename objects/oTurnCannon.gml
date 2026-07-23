#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0

//Enemy base statistics
eName="Turn Cannon"
eLevel=18
maxLife=200
life=maxLife
pointWorth=26
atkPower=6
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=3
baseItemChance=65
baseDropIndex=75
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0

shotProg=0

jeremyText="A rotating cannon from the Mega Man X series that shoots in two directions, either horizontally or diagonally. Mostly they appear on the ceilings or floors, but in some cases they are on flying platforms. I found this info on the Mega Man Wiki."
chaoText="I know Claire is very familiar with these things, but under the Virus' rules, they can't be taken out in 2 hits... well technically they can..."
devText="Another enemy that I recycled from an earlier game. They're a good obstacle and made sense to reuse."
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
    shotProg+=1
    if shotProg=10
      image_index=1
    else if shotProg=20
      image_index=2
    else if shotProg=22 //diagonal shot
    {
      var tEffect,newAttack,dir1,dir2,xOffset,yOffset;
      if image_angle=0
      {
        dir1=45
        dir2=135
        xOffset=8
        yOffset=-16
      }
      else
      {
        dir1=225
        dir2=315
        xOffset=-8
        yOffset=16
      }

      tEffect=instance_create(x+xOffset,y+yOffset,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.27
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x-xOffset,y+yOffset,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.27
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      newAttack=instance_create(x+xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot; newAttack.direction=dir1; newAttack.decayTime=-100
      newAttack.image_speed=0; newAttack.atkPower=atkPower; newAttack.bulletSpeed=5
      newAttack=instance_create(x-xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot; newAttack.direction=dir2; newAttack.decayTime=-100
      newAttack.image_speed=0; newAttack.atkPower=atkPower; newAttack.bulletSpeed=5
    }
    else if shotProg=42
      image_index=3
    else if shotProg=52
      image_index=0
    else if shotProg=54 //horizontal shot
    {
      var tEffect,newAttack,dir1,dir2,xOffset,yOffset;
      if image_angle=0
      {
        dir1=0
        dir2=180
        xOffset=13
        yOffset=-12
      }
      else
      {
        dir1=180
        dir2=0
        xOffset=-13
        yOffset=12
      }
      tEffect=instance_create(x+xOffset,y+yOffset,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.27
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x-xOffset,y+yOffset,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.27
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      newAttack=instance_create(x+xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot; newAttack.direction=dir1; newAttack.decayTime=-100
      newAttack.image_speed=0; newAttack.atkPower=atkPower; newAttack.bulletSpeed=5
      newAttack=instance_create(x-xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot; newAttack.direction=dir2; newAttack.decayTime=-100
      newAttack.image_speed=0; newAttack.atkPower=atkPower; newAttack.bulletSpeed=5

      shotProg=-10
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-8,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }

  followInstance()
  enemyStepEvent()
}
