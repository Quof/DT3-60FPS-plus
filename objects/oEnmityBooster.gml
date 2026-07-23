#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
image_blend=make_color_rgb(100,100,100)

//Enemy base statistics
eName="Enmity Booster"
eLevel=14
maxLife=2400
life=maxLife
atkPower=5
resType[1]=4
resType[2]=2
resType[4]=5
stunResist=50
bNoBonus=true
dieSound=0
dieEffect=0

atkTime=300
atkDelay=400
shotDir=0
multiShot=0

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=1 and oEnmity.specialAttack=0 and life>0
  {
    atkTime+=1
    if atkTime=atkDelay //---------- Ready missiles ----------
    {
      if multiShot=0
      {
        var tEffect;
        tEffect=instance_create(x-(14*image_xscale),y-38,oEffect)
        tEffect.sprite_index=sMMchargeComplete
        tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    if atkTime>=atkDelay+15 //---------- Attack: Homing Missile ----------
    {
      var tMissile;
      tMissile=instance_create(x-(14*image_xscale),y-38,oEnmityMissile)
      tMissile.atkPower=atkPower; tMissile.targetTime=15
      if image_xscale=1 {tMissile.direction=130-shotDir}
      else {tMissile.direction=50+shotDir}

      shotDir+=10
      multiShot+=1
      if multiShot<2 {atkTime=atkDelay-15}
      else
      {
        shotDir=0
        multiShot=0
        atkTime=0
      }
    }

    if lifePercent<=0.5 and resType[4]=5
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=4; tAtkShield.atkUp=1
      resType[4]-=2
    }
    if lifePercent<=0.3 and resType[1]=4
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      resType[1]-=1
    }
    enemyStepEvent()
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 3=0
    {
      if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
      tEffect=instance_create(x-(26*image_xscale)+(random(49)*image_xscale),y-50+random(56),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.image_xscale=0.9; tEffect.image_yscale=0.9; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
}
