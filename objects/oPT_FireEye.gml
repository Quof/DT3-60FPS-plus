#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_alpha=0

//Enemy base statistics
eName="Prototype Fire Eye"
eLevel=27
maxLife=210
life=maxLife
pointWorth=25
atkPower=7
damageType="ELEMENTAL"
resType[5]=4
baseItemChance=45
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=70

runAcc=1
atkTime=30
atkDelay=50
octoAtk=4

moveToward=1
moveChange=0
approaching=0
detectDistX=168
detectDistY=168

deathAnim=0

jeremyText="This cycles through 2 different attacks. The first is a 4-way fireball attack which is based on its angle to you. The next is an 8-way fireball attack, which behaves the same, but the fireballs are much slower. Its behavior is a bit weird. It tracks you and has a minimun distance till it backs off, but that action is delayed a bit."
chaoText="This enemy sprite comes from the first Act Raiser game."
devText="On top of having Gate 6 be RPG themed, I also wanted it to have a bit of an 'unfinished game' feel to it."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Fire Eye")
pointWorth=25+round(rpgLv/6)
if rpgLv<=9
{
  expValue=5+round(rpgLv*1.5)
  maxLife=210+(rpgLv*5)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=10+(rpgLv*2)
  maxLife=250+(rpgLv*6)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*3.25)
  maxLife=290+round(rpgLv*7.75)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=40+round(rpgLv*5)
  maxLife=350+round(rpgLv*9.5)
}
else if rpgLv>=60
{
  expValue=50+round(rpgLv*6)
  maxLife=450+(rpgLv*11)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Fire Eye")
  eLevel+=1
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=7
  atkPower+=1
  baseColor=make_color_rgb(255,190,180)
  image_blend=baseColor
  jeremyText+=" This upgraded version simply has slightly higher base stats."
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if life>0
  {
    if bActive=true
    {
      if approaching=0
      {
        image_alpha+=0.08
        if image_alpha>=1
        {
          image_alpha=1
          detectDistX=264
          detectDistY=200
          bCanDealDamage=true
          bCanTakeDamage=true
          approaching=100
        }
      }
      else if approaching=100
      {
        myDir=player_sprite_center()
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if moveToward=1
        {
          direction=myDir
          speed=runAcc
        }
        else
        {
          direction=myDir+180
          speed=runAcc
        }

        if runAcc<2.5 {runAcc+=0.05}

        moveChange+=1
        if moveChange>=30
        {
          if myDist<=108
          {
            if moveToward=1 {runAcc=1}
            moveToward=0
            moveChange=0
          }
          else if myDist>=136
          {
            if moveToward=0 {runAcc=1}
            moveToward=1
            moveChange=0
          }
        }

        //---------- Shoot Fireballs ----------
        atkTime+=1
        if atkTime>=atkDelay
        {
          if atkTime>=atkDelay and atkTime<=atkDelay+14
          {
            if atkTime mod 2=0
            {
              if image_alpha=1 {image_alpha=0.6}
              else {image_alpha=1}
            }
          }
          else if atkTime=atkDelay+15 //Change anim
          {
            image_alpha=1
            playSound(global.snd_Flame1,0,0.9,29000)
            var tNewAttack,tDir;
            tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
            for(i=0;i<octoAtk;i+=1)
            {
              tNewAttack=instance_create(x,y,oPassBullet)
              tNewAttack.sprite_index=sFireEyeFire; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
              tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
              tNewAttack.direction=tDir; tNewAttack.depth=9
              if octoAtk=4 {tDir+=90; tNewAttack.bulletSpeed=8}
              else {tDir+=45; tNewAttack.bulletSpeed=5}
            }
          }
          else if atkTime=atkDelay+30 //End attack
          {
            if octoAtk=4 {octoAtk=8}
            else {octoAtk=4}
            atkTime=0
          }
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
      tEffect=instance_create(x+random_range(-13,13),y+random_range(-13,13),oEffect)
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
