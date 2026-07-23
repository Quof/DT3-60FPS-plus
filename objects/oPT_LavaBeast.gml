#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-38,13,-1)
image_speed=0
visible=0
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Lava Beast"
eLevel=28
maxLife=300
life=maxLife
pointWorth=25
atkPower=7
damageType="ELEMENTAL"
resType[0]=2
resType[1]=4
baseItemChance=60
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=70
runAcc=2
atkTime=25
atkDelay=40
detectDistX=144
detectDistY=144
rising=0
aimAtk=1

deathAnim=0

jeremyText="As you've just seen, these hide in lava most of the time. When they sense you close by, they jump out and start throwing fireballs toward you. They cycle through a faster straight launch, then aim at you with a slower one on the next throw."
chaoText="This is from the SNES game 'Stone Protectors'."
devText="Originally the enemy levels were going to scale up with player level with a min/max for each specific area, but early testing showed that was unnecessary. While the leveling in Gate 6 is made to feel superficial, the scaling still felt awkward. Instead, most enemy spawns have a set level with a very slight variance."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Lava Beast")
pointWorth=25+round(rpgLv/7)
if rpgLv<=9
{
  expValue=5+round(rpgLv*1.5)
  maxLife=300+round(rpgLv*6.25)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=10+(rpgLv*2)
  maxLife=340+round(rpgLv*7.5)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*3.25)
  maxLife=380+round(rpgLv*9.5)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=40+(rpgLv*5)
  maxLife=440+round(rpgLv*11.25)
}
else if rpgLv>=60
{
  expValue=50+(rpgLv*6)
  maxLife=540+round(rpgLv*12.75)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Lava Beast")
  eLevel+=1
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  expValue*=6
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
  if y>oPlayer1.y and bActive=false {makeEnemyActive(1)}

  if bActive=true and life>0
  {
    makeEnemyActive(1)
    if rising>=0 and rising<=99
    {
      rising+=1
      if rising=1
      {
        var tEffect;
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(x+random_range(-12,12),y-19+random_range(-17,17),oEffect)
          tEffect.sprite_index=sWitchFire; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100
          tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_blend=c_maroon
        }
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        yVel=-12
        visible=1
      }

      if yVel<12 {yVel+=0.5}
      if yVel>5
      {
        if isCollisionBottom(1)
        {
          yVel=0
          image_speed=0.15
          sprite_index=sPT_LavaBeast_Walk
          detectDistX=264
          detectDistY=200
          bCanTakeDamage=true
          rising=100
        }
        moveTo(xVel,yVel)
      }
      else
      {
        y+=yVel
      }
    }
    else if rising>=100
    {
      if sprite_index=sPT_LavaBeast_Walk
      {
        if x<oPlayer1.x {image_xscale=1; xVel=runAcc}
        else {image_xscale=-1; xVel=-runAcc}
      }

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

      //---------- Throw Fireball ----------
      atkTime+=1
      if atkTime>=atkDelay
      {
        if atkTime=atkDelay //Change anim
        {
          xVel=0
          sprite_index=sPT_LavaBeast_Ready
          image_index=0
        }
        else if atkTime=atkDelay+12
        {
          playSound(global.snd_Fireball,0,0.9,18000)
          sprite_index=sPT_LavaBeast_Throw
          var tNewAttack;
          tNewAttack=instance_create(x+(18*image_xscale),y-31,oPassBullet)
          tNewAttack.sprite_index=sDraculaFireball; tNewAttack.atkPower=atkPower; tNewAttack.image_speed=0.5; tNewAttack.decayTime=-100
          tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
          if aimAtk=1
          {
            if image_xscale=1 {tNewAttack.direction=0}
            else {tNewAttack.direction=180}
            tNewAttack.bulletSpeed=13
          }
          else
          {
            tNewAttack.direction=point_direction(x+(18*image_xscale),y-31,oPlayer1.x,oPlayer1.y-26)
            tNewAttack.bulletSpeed=12
          }
        }
        else if atkTime=atkDelay+15 {image_index=1}
        else if atkTime=atkDelay+18 {image_index=2}
        else if atkTime=atkDelay+21 //End attack
        {
          sprite_index=sPT_LavaBeast_Walk
          if aimAtk=1 {aimAtk=3}
          else {aimAtk=1}
          atkTime=0
        }
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
