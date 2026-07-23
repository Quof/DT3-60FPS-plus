#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-9,-7,9,7)
image_speed=0
bCanDealDamage=false
bCanTakeDamage=false
sprite_index=sCV_Ghost_Form
visible=0

//Enemy base statistics
eName="Ghost"
eLevel=13
maxLife=330
life=maxLife
pointWorth=15
atkPower=4
resType[1]=4
resType[2]=2
resType[3]=1
resType[4]=2
stunResist=2
baseItemChance=60
baseDropIndex=90
moneyWorth=5
affiliation=3
dieEffect=0

fadeInTime=0
runAcc=1.75
abilityDrain=0

deathAnim=0

jeremyText="Just a ghost, they really aren't that big of a threat. The only issue is they don't appear until you are somewhat close to them. Still not too big of a threat, they move at a decent speed though. When one of these hits you, they drain a bit of Heart Energy."
chaoText="I bet Jeremy was thinking about band camp jokes because of the ghost stories they used to tell there."
devText="This, like the Vampire Bat, is another recycled DT1 AI. A few minor tweaks to the movement speed were made, but that's about it. The ghosts in this are faster than in DT1... except if you played DT1 on Distorted, though they were only a hair faster than this."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if fadeInTime=0
  {
    findTargetX=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
    if findTargetX<160
    {
      visible=1
      bActive=true
      fadeInTime=1
    }
  }
  else if fadeInTime=1
  {
    image_speed=0.1
    if image_index>=5.8
    {
      sprite_index=sCV_Ghost_Full
      bCanDealDamage=true
      bCanTakeDamage=true
      fadeInTime=2
    }
  }
  else if fadeInTime=2
  {
    makeEnemyActive(1)
    if bActive=true and stunnedTime=0 and life>0
    {
      image_speed=0.1
      if x>oPlayer1.x
        image_xscale=-1
      else
        image_xscale=1
      if instance_exists(oPlayer1)
      {
        dir=player_sprite_center()
        moveTo(runAcc*cos(degtorad(dir)),-runAcc*sin(degtorad(dir)))
      }
    }
    else if life<=0
    {
      deathAnim+=1
      image_speed=0
      if deathAnim mod 4=0
      {
        if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
        tEffect=instance_create(x+random_range(-9,9),y+random_range(-8,8),oEffect)
        tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
        tEffect.image_alpha=0.5+(image_alpha/3)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      image_alpha-=0.04
      if image_alpha<0 {instance_destroy()}
    }
  }
  if abilityDrain>0 {abilityDrain-=1}
  enemyStepEvent()
}
else
  image_speed=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if abilityDrain=0
{
  if global.gameProgress>=1210
  {
    global.hudBelmont_WeaponEn[0]-=10
    if global.hudBelmont_WeaponEn[0]<0 {global.hudBelmont_WeaponEn[0]=0}
  }
  abilityDrain=30
}
event_inherited()
