#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=false

//Enemy base statistics
eName="Warship Latch"
eLevel=38
maxLife=10
life=maxLife
pointWorth=10
atkPower=1
baseItemChance=10
moneyWorth=0
affiliation=7

deathAnim=0

jeremyText="This is just like the Useless Data that we first ran into in the Vault. It is destroyed by anything and only seems to be useful for getting extra jumps."
chaoText="I'm not sure what purpose these latches serve for the ship, so I guess destroy them or... don't?"
devText="Dopple 3.0."
extraInfo="Completely useless."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(x+random_range(-7,7),y+random_range(-7,7),oEffect)
        tEffect.sprite_index=sEfFacLasTurExp; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
