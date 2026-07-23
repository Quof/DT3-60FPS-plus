#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=0

//Enemy base statistics
eName="Deadeye"
eLevel=40
maxLife=1
life=maxLife
atkPower=12
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=1
//--------------------
bossPhase=0
//--------------------

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="N/A"
    chaoText="There's a weird thing masking some of its defensive data, but its offensive capabilities look to be wide open for me to read. It has two danmaku like attacks, some sort of scatter-missile attack that then burst into... ugh, homing missiles. Use bombs to blow those away. Oh yeah, dodge the big laser."
    devText="Prepare yourself for quite the fight. This boss probably took the longest to make of any boss fight I've ever made."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bossPhase=0
    {
      y-=2
      if y<=room_height
      {
        bCanTakeDamage=1
        bossPhase=1
      }
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim>=1 and deathAnim<=60
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-sprite_width,sprite_width),y+random_range(-sprite_height,sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim=61
  {
    playSound(global.snd_BombExplode,0,0.98,11025)
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x-52+(i*52),y-(sprite_height/2),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.25; tEffect.image_xscale=2.5; tEffect.image_yscale=2.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    oEvCh21Falling.sceneDelay=1
    instance_destroy()
  }
}
