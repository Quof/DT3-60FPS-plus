#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false; bCanDealDamage=false
image_alpha=0
image_xscale=2; image_yscale=2
bActive=1

//Enemy base statistics
eName="Decimator Armor"
eLevel=36
maxLife=3200
life=maxLife
pointWorth=40
atkPower=10
stunResist=50
resType[4]=5
affiliation=7
dieEffect=0

bShotReady=0
myProg=0
progTime=0
shotTime=110
shotDelay=195
shotDir=0
warnRad=0
checkHP=0
deathAnim=0

jeremyText="As the name states, it's a big piece of armor. While this is active, the Decimator is completely immune to damage. Oh yeah, watch out for those lasers."
chaoText="That regeneration I mentioned from the laser pads is slower when the armor is active. Which is good because you can't deal any damage to counter that regeneration... Oh, check this out! Every time you destroy its attachments, the Decimator takes a lot of damage. Hmm, so all you gotta do is get through its attachment phases quickly and it should fall super fast. This attachment gains half resist to NORMAL attacks at 75%."
devText="This boss is definitely set to be a fairly difficult one, as it's the barrier between this point and the final level. Lore wise, it's also CHAOS's most advanced bot at their disposal."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if myProg=0
    {
      if image_alpha<1 {image_alpha+=0.05}
      if image_xscale>1 {image_xscale-=0.05; image_yscale-=0.05}
      progTime+=1
      if progTime=25
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=3; tEffect.image_yscale=3
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        bCanTakeDamage=true; bCanDealDamage=true
      }
      else if progTime>=30
      {
        oDecimator.bCanTakeDamage=false; oDecimator.bCanDealDamage=false
        oDecimator.bWave=1
        progTime=0; myProg+=1
      }
    }
    else if myProg=1
    {
      followInstance()
      shotTime+=1
      if shotTime=shotDelay {shotDir=0; warnRad=96; shotTime=1000}
      else if shotTime>=1001 and shotTime<=1048 {warnRad-=2}
      else if shotTime>=1050 and shotTime<=1120
      {
        playSound(global.snd_CShotB,0,0.9,60000)
        var tNewAttack;
        shotDir+=8
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=shotDir
        tNewAttack=instance_create(x,y,oPassBulletRed)
        tNewAttack.sprite_index=sDeci_SmallLaserRed; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=shotDir+180
      }
      else if shotTime>=1121 {shotTime=0}
    }

    if checkHP=0
    {
      if lifePercent<=0.75
      {
        resType[0]=2
        checkHP=1
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-30,30),y+random_range(-18,18),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if warnRad>0
{
  draw_set_alpha(0.75)
  draw_set_color(c_white)
  draw_circle(x,y,warnRad,1)
}
