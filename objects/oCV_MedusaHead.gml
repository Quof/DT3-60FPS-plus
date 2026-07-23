#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
bDestroyOnDeactivate=true
inactiveDist=128

//Enemy base statistics
eName="Medusa Head"
eLevel=11
maxLife=145
life=maxLife
pointWorth=5
atkPower=5
resType[1]=4
resType[2]=5
resType[5]=2
baseItemChance=40
baseDropIndex=90
pickupDropMod=30
moneyWorth=0
affiliation=3
bGenEnemy=1
dieEffect=0

initDir=0
bobTime=0
runAcc=3
bobTime=irandom(50)
bobAmount=3.8
abilityDrain=0
tauntPlayer=0

if x>oPlayer1.x {runAcc*=-1}
xVel=runAcc
if xVel>0 {image_xscale=1}
else {image_xscale=-1}

deathAnim=0

jeremyText="Ugh, it's... this. Really, there's nothing I can say about them that will help you. Don't get hit by them, they drain Heart Energy when they hit you."
chaoText="The Medusa Heads in the Castlevania series of games are infamous for knocking heroes off of platforms and causing no end of trouble for game players. They are often considered to be one of the most annoying enemies in video game history."
devText="These, to me, are a really iconic Castlevania enemy. Even in some of the later games where the protagonist had screen filling attacks, these sometimes presented a problem. Though the first Castlevania still showcases them in their best light... or is that their worst?"
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
    if tauntPlayer>0 {tauntPlayer-=1}
    bobTime+=1
    if bobTime>=1 and bobTime<=20 {y+=bobAmount}
    else if bobTime>=28 and bobTime<=47 {y-=bobAmount}
    else if bobTime>=55 {bobTime=0}
    x+=xVel
    if abilityDrain>0 {abilityDrain-=1}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.92,1)
      visible=0
      for(i=0;i<8;i+=1)
      {
        tEffect[i]=instance_create(x+random_range(-9,9),y+random_range(-4,12),oEffectGrav)
        tEffect[i].sprite_index=sMedusaHeadSnake
        tEffect[i].type=1; tEffect[i].rotation=random_range(-15,15)
        tEffect[i].xSpd=random_range(-4,4); tEffect[i].ySpd=-1-random(4)
        tEffect[i].grav=0.2; tEffect[i].newBlend=-1; tEffect[i].decay=-100; tEffect[i].followID=-1
      }
    }
    else if deathAnim=30
    {
      for(i=0;i<8;i+=1)
      {
        with tEffect[i]
        {
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
          tEffect.image_xscale=0.8; tEffect.image_xscale=0.8; tEffect.image_alpha=0.8
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          instance_destroy()
        }
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0
{
  if abilityDrain=0
  {
    if global.gameProgress>=1210
    {
      global.hudBelmont_WeaponEn[0]-=10
      if global.hudBelmont_WeaponEn[0]<0 {global.hudBelmont_WeaponEn[0]=0}
    }
    abilityDrain=30
  }
  if tauntPlayer=0
  {
    if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.bCanTakeHit=true and random(100)<60
    {
      var newMessage;
      newMessage=instance_create(x-46,y-40,oEnemyChat)
      newMessage.enemyMessage="Senpai noticed me!"
      tauntPlayer=30
    }
  }
}
event_inherited()
