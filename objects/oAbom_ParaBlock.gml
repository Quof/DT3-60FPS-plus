#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Parasite"
eLevel=40
maxLife=80
life=maxLife
pointWorth=10
atkPower=10
stunResist=50
affiliation=9
dieEffect=0

jeremyText="These small parasites seem to clog pathways in the Abomination. They don't do much of anything else, but you can't damage them with your weapons."
chaoText="Hmm, I think I can do something with those green fields."
devText="I'd say something, but it would be a spoiler."

waveOffset=y/16

deathAnim=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mySolid=instance_create(x,y,oInvisibleSolid)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and life>0
  {
    x+=sin(oGame.time/2.5+waveOffset)
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-8,8),y+random_range(-8,8),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      with mySolid {instance_destroy()}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag=120
{
  event_inherited()
}
