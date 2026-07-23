#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0.33

//Enemy base statistics
eName="Cave Buzzard"
eLevel=12
maxLife=300
life=maxLife
pointWorth=17
atkPower=5
stunResist=4
baseItemChance=60
baseDropIndex=85
moneyWorth=5
dieSound=0
dieEffect=0
weight=90

currHspd=0
maxSpeed=4

shootTime=50
shootDelay=100

bSpotted=0
deathAnim=0

jeremyText="This buzzard is mostly seen in caves. It has a somewhat weird movement system. It has a slow rate of fire on its attack, which is 3 balls of gravity based energy."
chaoText="It's kind of weird to see a buzzard like this in caves, but I guess... that's what it does? I don't know, I'm in a weird mood."
devText="This buzzard enemy didn't get coded till waaay later in the game's development... just before creating the final level."
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
    if x>oPlayer1.x {image_xscale=-1}
    else {image_xscale=1}

    if x>oPlayer1.x
    {
      if currHspd>-maxSpeed {currHspd-=0.1}
      else {currHspd=-maxSpeed}
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed {currHspd+=0.1}
      else {currHspd=maxSpeed}
    }
    x+=currHspd

    shootTime+=1
    if shootTime>=shootDelay
    {
      var tNewAttack;
      tNewAttack=instance_create(x,y,oGravityBullet)
      tNewAttack.atkPower=atkPower; tNewAttack.sprite_index=sCaveBBall; tNewAttack.damageType="EXPLOSION"
      tNewAttack.bulletSpeed=3; tNewAttack.xVel=-2
      tNewAttack=instance_create(x,y,oGravityBullet)
      tNewAttack.atkPower=atkPower; tNewAttack.sprite_index=sCaveBBall; tNewAttack.damageType="EXPLOSION"
      tNewAttack.bulletSpeed=3
      tNewAttack=instance_create(x,y,oGravityBullet)
      tNewAttack.atkPower=atkPower; tNewAttack.sprite_index=sCaveBBall; tNewAttack.damageType="EXPLOSION"
      tNewAttack.bulletSpeed=3; tNewAttack.xVel=2
      shootTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEfCir=instance_create(x,y,oEfCircleBlast); tEfCir.image_alpha=0.75; tEfCir.myRad=6; tEfCir.radScl=4; tEfCir.fadeSpeed=0.08
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y+random_range(-10,10),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
