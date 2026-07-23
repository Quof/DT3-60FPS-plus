#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false; bCanDealDamage=false
image_alpha=0
bActive=1

//Enemy base statistics
eName="Decimator Protector"
eLevel=36
maxLife=300
life=maxLife
pointWorth=10
atkPower=10
stunResist=50
affiliation=7
dieEffect=0

spin=0
myProg=0
progTime=0
shotDelay=560
checkHP=0
deathAnim=0

jeremyText="There are 4 types of these as you can see. Each one with its own attacks and resistances. The weaknesses are:#Fuchsia: PIERCE#Orange: SPECIAL#Blue: SHOT#Green: ELEMENTAL"
chaoText="Its regeneration is at its fastest with this attachment. I'd recommend getting rid of the green ones first. I personally think they're the most threatening. The orange ones have that flame thrower, but as long as you keep your distance, it's a useless attack for it. This attachment gains half resist to NORMAL attacks at 75%."
devText="These were the hardest part to get right with the Decimator. I definitely didn't want all of them attacking at the same time or out of sequence. When testing that, it was way too chaotic when mixed with the missiles from the sky, as well as a new attack the Decimator gains on the second half of the fight."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 or type=4
{
  baseColor=c_fuchsia
  resType[1]=4
}
else if type=1 or type=5
{
  baseColor=c_orange
  resType[5]=4
}
else if type=2 or type=6
{
  baseColor=c_blue
  resType[3]=4
}
else if type=3 or type=7
{
  baseColor=c_green
  resType[2]=4
}
image_blend=baseColor
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
      progTime+=1
      if progTime=25
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        bCanTakeDamage=true; bCanDealDamage=true
      }
      else if progTime>=30
      {
        oDecimator.bWave=1
        progTime=0; myProg+=1
      }
    }
    else if myProg=1
    {
      spin+=2
      shotTime+=1
      if shotTime>=shotDelay and shotTime<=shotDelay+100
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if baseColor=c_fuchsia {shotTime=1000}
        else if baseColor=c_orange {shotTime=2000}
        else if baseColor=c_blue {shotTime=3000}
        else if baseColor=c_green {shotTime=4000}
      }
      else if shotTime=1030 //Fuchsia
      {
        var tMissile;
        for(i=0;i<4;i+=1)
        {
          tMissile=instance_create(x,y-16,oHomingMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sDeci_Missile
          tMissile.bulletSpeed=4; tMissile.seekThres=15; tMissile.minSpd=3; tMissile.maxSpd=7
          tMissile.turnSpd=4; tMissile.accel=0.2; tMissile.direction=45+(i*90)
        }
        shotTime=0
      }
      else if shotTime>=2031 and shotTime<=2100 //Orange
      {
        var tNewAttack;
        for(i=0;i<2;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sMMFlamerFlame; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10; tNewAttack.image_alpha=0.75
          tNewAttack.decayTime=17; tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
          tNewAttack.damageType="ELEMENTAL"
        }
        if shotTime>=2070 {shotTime=0}
      }
      else if shotTime=3030 //Blue
      {
        var tNewAttack,tDir;
        tDir=0
        for(i=0;i<12;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=tDir
          tDir+=360/12
        }
        shotTime=0
      }
      else if shotTime>=4030 //Green
      {
        var tNewAttack;
        if shotTime mod 10=0
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sDeci_SmallLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7; tNewAttack.image_blend=make_color_rgb(150,255,150)
          tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        }
        if shotTime>=4070 {shotTime=0}
      }
    }

    x=oDecimator.x+lengthdir_x(oDecimator.protectorDist,myDir+spin)
    y=oDecimator.y+lengthdir_y(oDecimator.protectorDist,myDir+spin)

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
