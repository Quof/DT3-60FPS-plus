#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Evir"
eLevel=24
maxLife=420
life=maxLife
pointWorth=37
atkPower=8
resType[0]=2
resType[1]=2
resType[4]=2
resType[5]=4
stunResist=5
baseItemChance=90
baseDropIndex=70
moneyWorth=10
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
inactiveDist*=1.25

runAcc=2
moveWave=pi/2
fireTime=40
fireDelay=75

deathAnim=0

jeremyText="These simply move along a simple sin wave and fire a spike ball toward you from their tail. The movement behavior isn't the same as the original source, but what can ya do?"
chaoText="'These creatures fire thorny bullets from their tails.'#Something else I found in the Super Metroid manual. No one knows officially, but we all state that these serve under Draygon and are by extension, part of the Space Pirate's group."
devText="This Maridia sector was set to be the largest of the 3 main sectors, but it turned out that Brinstar became the biggest after a few changes during the Gate's development. It became the second biggest of the 3, but has the fewest maps. It feels shorter than the others due to the maps being easier to traverse overall."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //Movement
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    moveWave+=pi/60
    y+=sin(moveWave)*4

    //Attack
    fireTime+=1
    if fireTime>=fireDelay
    {
      var tNewAttack;
      tNewAttack=instance_create(x,y+16,oPassBullet)
      tNewAttack.sprite_index=sEvirSpikeball; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5; tNewAttack.depth=8
      tNewAttack.decayTime=-100; tNewAttack.direction=player_sprite_center()
      fireTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
    if deathAnim mod 3=0
    {
      tEffect=instance_create(x+random_range(-14,14),y+random_range(-20,20),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
