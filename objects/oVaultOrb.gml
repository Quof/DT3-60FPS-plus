#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
visible=0
bCanTakeDamage=false
bCanDealDamage=false
detectDistX=192
detectDistY=160

myColor=irandom_range(1,4)
if myColor=1 {baseColor=c_red; image_blend=baseColor}
else if myColor=2 {baseColor=c_blue; image_blend=baseColor}
else if myColor=3 {baseColor=c_green; image_blend=baseColor}
else if myColor=4 {baseColor=c_yellow; image_blend=baseColor}

//Enemy base statistics
eName="Vault Orb"
eLevel=20
maxLife=800
life=maxLife
pointWorth=37
atkPower=6
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
stunResist=50
baseItemChance=70
baseDropIndex=85
moneyWorth=5
dieEffect=0

init=0
runAcc=1.4
teleProg=0
teleTime=irandom(10)
revertTime=-1

jeremyText="These have the simple AI of just tracking you, though I have noticed a slight speed increase if they're further away. At near set intervals, they will flash and boost itself at an impressive speed. Their stun resist is also amazing, I wish I could help you out more here..."
chaoText="The color of these orbs is always 1 of 4 random colors, but all it does is affect what color field they can be damaged in effectively."
devText="You know... I'm not gonna write up any commentary in this enemy scan."
extraInfo="Capable of incredible speed."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myColor=colorSet
if myColor=1 {baseColor=c_red; image_blend=baseColor}
else if myColor=2 {baseColor=c_blue; image_blend=baseColor}
else if myColor=3 {baseColor=c_green; image_blend=baseColor}
else if myColor=4 {baseColor=c_yellow; image_blend=baseColor}
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
    if bActive=true and stunnedTime=0
    {
      if init=0
      {
        visible=1
        image_index+=0.2
        if image_index>=7
        {
          image_index=7
          bCanTakeDamage=true
          bCanDealDamage=true
          init=1
        }
      }
      else if init=1
      {
        revertTime-=1
        if revertTime=0
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=2
          }
          stunResist=50
        }

        teleTime+=1
        if teleProg=0 //Normal behavior
        {
          direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())

          findTargetX=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
          if findTargetX<160 {speed=runAcc}
          else {speed=runAcc*1.2}

          if teleTime>=50
          {
            speed=0
            teleTime=0; teleProg+=1
          }
        }
        else if teleProg=1 //Wait - Teleport
        {
          if teleTime mod 2=0 and teleTime<=20 //Flash
          {
            if image_blend=baseColor {image_blend=c_purple}
            else {image_blend=baseColor}
          }
          if teleTime=17 //Warn
          {
            tEffect=instance_create(x,y,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=1
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          else if teleTime=21 {image_blend=baseColor} //Reset color
          else if teleTime>=25 //Teleport
          {
            direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
            for(i=0;i<10;i+=1)
            {
              tEffect=instance_create(x+lengthdir_x(i*8,direction),y+lengthdir_y(i*8,direction),oEffect)
              tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=1-(i*0.09)
              tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
              tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
            }
            x+=lengthdir_x(80,direction)
            y+=lengthdir_y(80,direction)
            teleTime=0; teleProg+=1
          }
        }
        else if teleProg=2 //Teleport
        {
          if teleTime>=20 {teleTime=irandom(10); teleProg=0}
        }
      }
    }
    else {speed=0}
  }
  else if life<=0
  {
    for(i=0;i<10;i+=1)
    {
      tEffect=instance_create(x+random_range(-22,22),y-1-random(21),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oColorZone
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if myColor=other.zoneColor
{
  for(i=0;i<6;i+=1)
  {
    resType[i]=4
  }
  stunResist=5
  revertTime=2
}
