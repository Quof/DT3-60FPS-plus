#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false; bCanDealDamage=false
image_speed=0
image_alpha=0
bActive=1

//Enemy base statistics
eName="Decimator Laser Pad"
eLevel=36
maxLife=780
life=maxLife
pointWorth=20
atkPower=10
stunResist=50
affiliation=7
dieEffect=0

bShotReady=0
myProg=0
progTime=0
checkHP=0
deathAnim=0

jeremyText="These follow some weird rules. Note the order of the damage types on the menu here. Each of these, starting from the top, have a weakness to the damage type in the same order, but skip NORMAL type. The previous damage type it has a resistance to. While these spinning laser pads are out, do not go above the Decimator. These things seem to provide it with the ability to rapid fire if something is up there."
chaoText="I figured something out about the Decimator from these. If it has any attachments, it will constantly regenerate. It also looks like the Decimator will eventually provide itself with full invulnerability if it takes too much damage while an attachment is active. This attachment gains half resist against NORMAL attacks at 66% and full resist at 33%."
devText="At one point, this boss was near impossible to beat. Not only were these lasers roughly 50% faster, there were quite a few combinations of attacks that left the player in situations that were undodgable, at least from what I could tell after quite a few tests."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  resType[5]=2
  resType[1]=5
}
else if type=1
{
  resType[1]=2
  resType[2]=5
}
else if type=2
{
  resType[2]=2
  resType[3]=5
}
else if type=3
{
  resType[3]=2
  resType[4]=5
}
else if type=4
{
  resType[4]=2
  resType[5]=5
}
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
      if x<oDecimator.x {x+=2}
      else if x>oDecimator.x {x-=2}
      progTime+=1
      if progTime=32
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        bCanTakeDamage=true; bCanDealDamage=true
      }
      else if progTime>=40
      {
        oDecimator.bWave=1
        progTime=0; myProg+=1
      }
    }
    else if myProg=1
    {
      followInstance()
      image_index+=turnSpd
      if bShotReady=1
      {
        if image_index<1
        {
          playSound(global.snd_CShotA,0,0.9,42000)
          var tNewAttack;
          tNewAttack=instance_create(x+34,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack.direction=0
          tNewAttack=instance_create(x-34,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
          tNewAttack.decayTime=-100; tNewAttack.direction=180
          bShotReady=0
        }
      }
      else
      {
        if image_index>4 {bShotReady=1}
      }
    }

    if checkHP=0
    {
      if lifePercent<=0.66
      {
        resType[0]=2
        checkHP=1
      }
    }
    else if checkHP=1
    {
      if lifePercent<=0.33
      {
        resType[0]=1
        checkHP=2
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
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
