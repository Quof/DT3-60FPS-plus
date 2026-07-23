#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.3
bActive=1

//Enemy base statistics
eName="Injector Virus"
eLevel=25
maxLife=45
life=maxLife
pointWorth=8
atkPower=8
resType[1]=4
stunResist=50
baseItemChance=-10
baseDropIndex=60
pickupDropMod=10
dieEffect=0
dieSound=0
startUpTime=0

deathAnim=0

jeremyText="Take these out as quick as you can, if they reach any of the facility's bots, they'll infect them and turn that bot on you. It's very very worth noting that the blue ones can infect non-aggressive bots such as consoles affecting doors and bridges. These have a limited sight distance, keep that in mind."
chaoText="The Virus hasn't been as actively aggressive toward you as it has been here. It knows you're close to shutting it down. We've come this far though, I know it won't stop us."
devText="Early on, the way these infect friendly bots and then turn those bots on the player was how all Virus infected enemies were going to work, but I scrapped that idea and decided to save it for late game only. There were a few complications back then that were later worked out, but over all, it felt better to save this till now."
extraInfo="Infects bots."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      startUpTime+=1
      if startUpTime=1 //Appear
      {
        visible=1
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sAtkTypeShield; tEffect.followID=-1; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75; tEffect.image_speed=0.75
      }
      if startUpTime>=15
      {
        speed=moveSpeed
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {speed=0}
