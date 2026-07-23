#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Medium Sized Wall Turret"
eLevel=27
maxLife=500
life=maxLife
pointWorth=25
atkPower=8
resType[0]=1
resType[1]=1
stunResist=1
affiliation=7
dieSound=0
dieEffect=0
gunDelay=55

jeremyText="Eh, just a turret. It has decent durability and fire rate, but not really all that threatening."
chaoText="See my thoughts on the wall itself..."
devText="The wall's scanning area is the weak point."
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
    //Fire at player
    gunShot+=1
    if gunShot>=gunDelay
    {
      var tNewAttack;
      tNewAttack=instance_create(x-18,y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x-18,y,oPlayer1.x,returnPlayerYCenter())
      gunShot=0
    }
  }
  else if life<=0
  {
    playSound(global.snd_HardHit1,0,0.9,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
