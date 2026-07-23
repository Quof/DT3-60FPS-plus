#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Test Enemy"
eLevel=28
maxLife=240
life=maxLife
pointWorth=15
atkPower=7
baseItemChance=50
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=1
blockCost=100
runAcc=2.5
atkTime=30
atkDelay=60

deathAnim=0

jeremyText="I'm not even sure what I'm looking at here. These are... just there. It will periodically fire a bullet toward you, nothing bad though. The sprite seems to be randomized and Claire... well you can parry them at any time."
chaoText="All sprites that this can use are from 'Lufia 2: Rise of the Sinistrals'."
devText="I found it difficult to reference turn-based combat in an action game without actually doing a turn-based segment, which was not going to happen."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Test Enemy")
pointWorth=15+round(rpgLv/8)
if rpgLv<=9
{
  expValue=10+round(rpgLv*1.25)
  maxLife=180+(rpgLv*3)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=15+(rpgLv*2)
  maxLife=200+(rpgLv*5)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*3)
  maxLife=220+round(rpgLv*7)
}
else if rpgLv>=50
{
  expValue=30+round(rpgLv*4)
  maxLife=250+round(rpgLv*9)
}

if image_index=3
{
  expValue=round(expValue*1.1)
  maxLife=round(maxLife*1.25)
}
else if image_index=4
{
  expValue=round(expValue*1.25)
  maxLife=round(maxLife*1.75)
}
else if image_index=5
{
  expValue=round(expValue*1.4)
  maxLife=round(maxLife*2.1)
}
life=maxLife
bCanTakeDamage=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true
    {
      if atkTime<atkDelay //Check direction
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }

      if atkTime<atkDelay //Movement
      {
        myDir=player_sprite_center()
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if myDist<=64
        {
          direction=myDir+180
          speed=runAcc*0.75
        }
        else if myDist>=80
        {
          direction=myDir
          speed=runAcc
        }
        else {speed=0}
      }
      else {speed=0}

      //---------- Fire bullet at player ----------
      atkTime+=1
      if atkTime>=atkDelay
      {
        if atkTime>=atkDelay and atkTime<=atkDelay+14
        {
          if atkTime mod 2=0
          {
            if image_blend=c_dkgray {image_blend=c_white}
            else {image_blend=c_dkgray}
          }
        }
        else if atkTime=atkDelay+15 //Change anim
        {
          image_blend=c_white
          var tNewAttack,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
          tDir-=5
          for(i=0;i<3;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sFireEyeFire; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
            tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=100; tNewAttack.bParryOpp=1
            tNewAttack.direction=tDir; tNewAttack.bulletSpeed=7
            tDir+=5
          }
        }
        else if atkTime=atkDelay+20 //End attack
        {
          atkTime=0
        }
      }
    }
    else {speed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y-1-random(44),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {speed=0}
