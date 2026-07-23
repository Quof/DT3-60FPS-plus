#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Prototype Ice Spirit"
eLevel=28
maxLife=240
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
runAcc=2.5
atkTime=30
atkDelay=50
triAtk=1
inactiveDist*=1.25

deathAnim=0

jeremyText="This enemy tries to stay at a certain distance from you and shoot off ice spears at you. It alternates between one spear and three. When it's firing only one, the spear is much faster."
chaoText="This is from 'Demon Hunter Legend 3'."
devText="I needed to make sure that most of the enemies in Gate 6 had multiple ways of approaching them instead of forcing the parry system on the player every time. Though it certainly makes things easier."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Ice Spirit")
pointWorth=25+round(rpgLv/6)
if rpgLv<=9
{
  expValue=5+round(rpgLv*1.5)
  maxLife=240+(rpgLv*6)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=10+(rpgLv*2)
  maxLife=280+(rpgLv*7)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*3.25)
  maxLife=320+round(rpgLv*8.75)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=40+(rpgLv*5)
  maxLife=380+round(rpgLv*10.5)
}
else if rpgLv>=60
{
  expValue=50+(rpgLv*6)
  maxLife=460+round(rpgLv*11.75)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Ice Spirit")
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
        if myDist<=108
        {
          direction=myDir+180
          speed=runAcc*0.75
        }
        else if myDist>=136
        {
          direction=myDir
          speed=runAcc
        }
        else {speed=0}
      }
      else {speed=0}

      //Effect
      if oGame.time mod 6=0
      {
        var tEffect;
        tEffect=instance_create(x+random_range(-8,8),y+random_range(-14,22),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.image_alpha=0.75
        tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.025; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-3,3)
      }

      //---------- Shoot Ice Lance ----------
      atkTime+=1
      if atkTime>=atkDelay
      {
        if atkTime=atkDelay //Change anim
        {
          xVel=0
          sprite_index=sPT_IceSpirit_Atk
          var tNewAttack,tDir;
          tDir=point_direction(x-(11*image_xscale),y-45,oPlayer1.x,oPlayer1.y-26)

          if triAtk=3 {tDir-=20}
          for(i=0;i<triAtk;i+=1)
          {
            tNewAttack=instance_create(x-(11*image_xscale),y-45,oIceSpiritAtk)
            tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100; tNewAttack.direction=tDir
            if triAtk=1 {tNewAttack.bulletSpeed=16}
            else if triAtk=3 {tNewAttack.bulletSpeed=12}
            tDir+=20
          }
        }
        else if atkTime=atkDelay+20 {image_index=1}
        else if atkTime=atkDelay+23 {image_index=2}
        else if atkTime=atkDelay+26 {image_index=3}
        else if atkTime=atkDelay+30 //End attack
        {
          sprite_index=sPT_IceSpirit_Idle
          if triAtk=1 {triAtk=3}
          else {triAtk=1}
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
