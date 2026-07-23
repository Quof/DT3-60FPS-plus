#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Top
event_inherited()
bActive=true
image_speed=0.33
image_angle=270
bShowDamagePopout=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanDealDamage=false
damageType="ELEMENTAL"

eName="Warmaster Spin Turret"
eLevel=40
maxLife=10
life=maxLife
atkPower=12
affiliation=7
bIsBoss=true
bNoBonus=true
hitSound=0
dieSound=0
dieEffect=0

size=2
atkTime=0
decay=300

jeremyText="It's a spinning turret that simply hovers and fires bullets downward roughly every 2 seconds. These will persist over his form change so if he switches to fire or wind form, you may want to take these out quickly. That said, they will time out after 10 seconds."
chaoText="Guys, seriously. Stop trying to scan every little thing. He's probably destroying you right now."
devText="Fun fact, I typed out this very message you're reading about an hour before uploading the update."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkTime<=99
  {
    y+=4
    if y>=96
    {
      atkTime=130
    }
  }

  if atkTime>=135 and atkTime mod 55=0
  {
    var tAtk;
    tAtk=instance_create(x,y+7,oPassBullet)
    tAtk.sprite_index=sWarmasterD_EX_Ball; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
    tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk.direction=image_angle
  }
  enemyStepEvent()

  decay-=1
  if decay<=0 {life=0}

  if life<=0
  {
    playSound(global.snd_BombExplode,0,0.9,1)
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.45; tEffect.image_yscale=0.45
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
