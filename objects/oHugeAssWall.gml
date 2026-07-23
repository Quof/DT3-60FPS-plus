#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Huge Ass Wall"
eLevel=28
maxLife=1400
life=maxLife
pointWorth=80
atkPower=8
resType[0]=1
resType[1]=1
stunResist=50
affiliation=7
dieSound=0
dieEffect=0
gunShot=10
gunDelay=60

jeremyText="The wall itself doesn't do anything aside from get in the way. Once you take down those turrets though, its weak point will slowly fire bullets toward you. Huh, they also don't spawn if you enter the map from the right side of them."
chaoText="This is from Contra 3. They would block your path... I don't know what else to really say about them.#Oh right! If you come from the right, they won't appear."
devText="The Rayman and Contra 3 sprites going together didn't look as bad as I thought it would. I expected it to look really bad and was kinda going for it to look horrible."
extraInfo="Gets in the way."

deathAnim=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x<oPlayer1.x {instance_destroy()}
else
{
  myTurretA=instance_create(x+9,y+52,oHAW_Gun); myTurretA.gunShot=0
  myTurretB=instance_create(x+41,y+52,oHAW_Gun); myTurretB.gunShot=27
  mySolid=instance_create(x+48,y,oSolid); mySolid.sprite_index=sInvisibleSolidMask; mySolid.visible=0
  mySolid.image_xscale=2; mySolid.image_yscale=10
}
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
    if !instance_exists(myTurretA) and !instance_exists(myTurretB)
    {
      gunShot+=1
      if gunShot>=gunDelay
      {
        var tNewAttack;
        tNewAttack=instance_create(x+22,y+112,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+22,y+112,oPlayer1.x,returnPlayerYCenter())
        gunShot=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with myTurretA {instance_destroy()}
      with myTurretB {instance_destroy()}
    }

    if oGame.time mod 8=0 {playSound(global.snd_EnemyDieMM,0,0.9,1)}
    tEffect=instance_create(x+random(sprite_width),y+random(sprite_height),oEffect)
    tEffect.sprite_index=sRobotExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1

    if deathAnim>=35
    {
      with mySolid {instance_destroy()}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
