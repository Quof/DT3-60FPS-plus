#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-18,-68,18,-1)
image_speed=0.15

//Enemy base statistics
eName="Prototype Sword Armor"
eLevel=29
maxLife=500
life=maxLife
pointWorth=50
atkPower=8
resType[5]=2
baseItemChance=70
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=60

runAcc=1.75
atkTime=30
atkDelay=45
atkCount=0

deathAnim=0

jeremyText="Oh man, this guy can attack and keep his shield up. You're gonna have to either parry or get behind him just as he attacks. It attacks twice for each attack phase. I'd recommend using parry over back attacks due to its large HP pool."
chaoText="This is from 'Demon Hunter Legend' I think there were four of those games."
devText="This sprite had to be edited to work properly. The original's sword is a bit shorter and didn't work too well for the parry system."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Sword Armor")
pointWorth=50+round(rpgLv/3)
if rpgLv<=9
{
  expValue=10+(rpgLv*5)
  maxLife=500+(rpgLv*10)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=20+(rpgLv*7)
  maxLife=580+(rpgLv*14)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=35+round(rpgLv*8)
  maxLife=660+round(rpgLv*16)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=60+round(rpgLv*12)
  maxLife=780+round(rpgLv*20)
}
else if rpgLv>=60 and rpgLv<=99
{
  expValue=80+round(rpgLv*15)
  maxLife=920+round(rpgLv*24)
}
else if rpgLv>=100
{
  expValue=100+round(rpgLv*20)
  maxLife=1000+round(rpgLv*25)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Sword Armor")
  eLevel=30
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=10
  atkPower=9
  resType[1]=1
  resType[5]=1
  baseColor=make_color_rgb(255,190,180)
  image_blend=baseColor
  jeremyText+=" This upgraded version resists your secondary attacks and has slightly higher base stats."
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
  if bActive=true and life>0
  {
    if atkTime<atkDelay //Check direction
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if atkTime<atkDelay
    {
      if point_distance(x,0,oPlayer1.x,0)<56 //Movement
      {
        if image_xscale=1 {xVel=-runAcc*0.75}
        else {xVel=runAcc*0.75}
      }
      else if point_distance(x,0,oPlayer1.x,0)>64
      {
        if image_xscale=1 {xVel=runAcc}
        else {xVel=-runAcc}
      }
      else {xVel=0}
    }
    else {xVel=0}

    //Check if at cliff edge and turn around
    tDrop=0
    if aiCheckHoriz(1,1,0,8,4)
    {
      if aiCheckVert(0,1,8,8,4)=1
        tDrop=1
    }
    if tDrop=0
    {
      xVel*=-1
      turnTime=25
    }

    //---------- Swing sword ----------
    atkTime+=1
    if atkTime>=atkDelay
    {
      if atkTime=atkDelay //Change anim
      {
        if point_distance(x,0,oPlayer1.x,0)<80
        {
          xVel=0
          sprite_index=sPT_SwordArmor_Swing
          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)
          bBlocking=0
          image_speed=0; image_index=0
        }
        else {atkTime=atkDelay-5}
      }
      else if atkTime=atkDelay+10
      {
        playSound(global.snd_DeathSlash,0,0.98,17000)
        bParryOpp=1
        image_index=1
      }
      else if atkTime=atkDelay+14 {image_index=2}
      else if atkTime=atkDelay+18 //End attack
      {
        atkCount+=1
        if atkCount>=2
        {
          bParryOpp=0
          sprite_index=sPT_SwordArmor_Walk
          image_speed=0.15
          atkCount=0
          atkTime=0
        }
        else
        {
          instance_create(x-(44*image_xscale),y-101,oG6_CounterSpark)
          image_index=0
          bParryOpp=0
          atkTime=atkDelay+20
        }
      }
      else if atkTime=atkDelay+32 {atkTime=atkDelay+1}
    }

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
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
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if enemyDeflect(1,1,1,1,1,1)=1 and global.stJGame_C[0]<4000
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x+random_range(-11,11),y-4-random(44),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else {event_inherited()}
