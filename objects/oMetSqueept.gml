#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
visible=false

//Enemy base statistics
eName="Squeept"
eLevel=22
maxLife=180
life=maxLife
pointWorth=20
atkPower=8
damageType="ELEMENTAL"
resType[0]=2
resType[1]=2
resType[2]=4
stunResist=3
baseItemChance=60
baseDropIndex=85
moneyWorth=5
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
detectDistX=120
detectDistY=272

rising=0
yVel=0

jeremyText="These behave just like Podobos, except their jump speed is different and they can be destroyed. They even deal ELEMENTAL type damage like Podobos."
chaoText="These are pretty weird, just like most Metroid creatures. They use a biological combustion system to propel themselves upward... like a really powerful fart...#What, it is!"
devText="Originally this lower area of Norfair was going to be in a completely different spot and come at a way different time in the Gate. It wasn't till midway through Gate 5 development, that a rather large change to Gate 5 took place, that revolved around repurposing this Lower Norfair level. It turned out better for it though."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true and rising>=0
  {
    if yVel<-2 {image_index=0}
    else if yVel>-1.99 and yVel<=-1 {image_index=1}
    else if yVel>=-0.99 and yVel<=1 {image_index=2}
    else if yVel>=1.01 and yVel<=2 {image_index=2; image_yscale=-1}
    else if yVel>=2.01 and yVel<=3 {image_index=1; image_yscale=-1}
    else {image_index=0; image_yscale=-1}

    if rising=0
    {
      yVel-=12
      visible=true
      image_yscale=1
      rising=1
    }
    if yVel<0
      image_yscale=1
    else
      image_yscale=-1
    yVel+=0.5
    y+=yVel
    if yVel>1 and y>ystart
    {
      var tEffect;
      tEffect=instance_create(x+2,ystart-12,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33
      tEffect.type=1; tEffect.decay=12 tEffect.xSpd=1; tEffect.ySpd=-2; tEffect.grav=0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0
      tEffect=instance_create(x-2,ystart-12,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_xscale=-1
      tEffect.type=1; tEffect.decay=12 tEffect.xSpd=-1; tEffect.ySpd=-2; tEffect.grav=0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0

      yVel=0
      y=ystart
      bActive=false
      visible=false
      rising=-15
    }
  }
  if rising<0
    rising+=1
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
