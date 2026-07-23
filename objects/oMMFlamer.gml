#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Flamer"
eLevel=18
maxLife=195
life=maxLife
pointWorth=21
atkPower=6
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=3
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=2

flameTime=20
flameDelay=60

jeremyText="These usually ride on those mobile platforms, wielding a nifty flamethrower. Not much else to really say about them."
chaoText="I have a feeling that these are meant more as something to get in the way and hinder progress than as a threatening enemy."
devText="Initially there was going to be four Mavericks, but the way the special weapons played out didn't work well with this. The levels and the bosses were also planned to be more complex than Metropolis in DT1, so it was decided to cut it down to three, which turned out to be far more manageable. That and I could use one Maverick from each of the SNES games."

curFlame=0
flameCycle=0
for(i=0;i<6;i+=1)
{
  flameAtk[i]=0
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if curFlame>0
{
  for(i=0;i<curFlame;i+=1)
  {
    tEffect=instance_create(flameAtk[i].x,flameAtk[i].y,oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.33; tEffect.image_alpha=0.8; tEffect.ySpd=-1-random(0.5)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
    with flameAtk[i] {instance_destroy()}
  }
}
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
    if flameTime<flameDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    flameTime+=1
    if flameTime>=flameDelay and flameTime<=flameDelay+100
    {
      image_speed=0.33
      if curFlame<6
      {
        if flameTime mod 5=0
        {
          flameAtk[curFlame]=instance_create(x,y,oMMFlamerFlame)
          flameAtk[curFlame].atkPower=atkPower
          flameAtk[curFlame].image_xscale=1+(curFlame/10)
          flameAtk[curFlame].image_yscale=1+(curFlame/10)
          curFlame+=1
        }
      }
      else
      {
        image_speed=0; image_index=0
        flameTime=flameDelay+100
      }
    }
    else if flameTime>=flameDelay+140 and flameTime<=flameDelay+240
    {
      image_speed=0.33
      if flameTime mod 5=0
      {
        curFlame-=1
        with flameAtk[curFlame] {instance_destroy()}
        if curFlame=0
        {
          image_speed=0; image_index=0
          flameTime=0
        }
      }
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-12,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }

  followInstance()
  if curFlame>0
  {
    for(i=0;i<curFlame;i+=1)
    {
      flameAtk[i].x=x+((22+(i*13))*image_xscale)
      flameAtk[i].y=y-12
    }
  }

  enemyStepEvent()
}
