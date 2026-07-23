#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-42,16,-1)
image_speed=0.15
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Slime"
eLevel=27
maxLife=120
life=maxLife
pointWorth=15
atkPower=6
resType[3]=2
baseItemChance=45
affiliation=6
dieSound=5
dieEffect=0

runAcc=1.5
biteTime=35
biteDelay=60
bCanBeBlocked=1
bParryOpp=0
blockCost=50
bAttacking=0

deathAnim=0
yDeath=0

jeremyText="These out of place slimes don't pose too much of a threat. When you're close enough, it will begin the strike. Watch out for that, because it lunges forward a fair bit."
chaoText="Slimes, the staple of a good generic rpg. Their behavior code is pretty bad. They often get stuck on things."
devText="When I removed Gate 7 and decided to turn Gate 6 into a place for both characters, there were two big ideas that came to mind. RPG and arcade. The arcade idea was already present in Chapter 14, and will pop up again later, I felt it a waste to have an entire Gate around the concept."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Slime")
pointWorth=15+round(rpgLv/9)
if rpgLv<=9
{
  expValue=2+rpgLv
  maxLife=120+(rpgLv*6)
}
else if rpgLv>=10 and rpgLv<=25
{
  expValue=3+round(rpgLv*1.5)
  maxLife=170+round(rpgLv*7)
}
else if rpgLv>=26 and rpgLv<=49
{
  expValue=4+round(rpgLv*2.5)
  maxLife=220+(rpgLv*9)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=5+(rpgLv*4)
  maxLife=300+round(rpgLv*11.5)
}
else if rpgLv>=60
{
  expValue=6+(rpgLv*5)
  maxLife=360+round(rpgLv*13.5)
}
life=maxLife
bCanTakeDamage=true

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Slime")
  eLevel+=1
  maxLife=round(maxLife*1.1)
  life=maxLife
  pointWorth=round(pointWorth*1.2)
  baseItemChance=5
  expValue*=5
  if rpgLv>1 {atkPower+=1}
  else {atkPower=1}
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
  if bActive=true and life>0
  {
    if sprite_index=sPT_Slime_Walk
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
    }

    //---------- Bite ----------
    biteTime+=1
    if biteTime>=biteDelay
    {
      if biteTime=biteDelay //Change anim
      {
        if point_distance(x,0,oPlayer1.x,0)<80
        {
          xVel=0
          instance_create(x-(18*image_xscale),y-43,oG6_CounterSpark)
          sprite_index=sPT_Slime_Bite
          bAttacking=1
          image_speed=0; image_index=0
        }
        else {biteTime=biteDelay-5}
      }
      else if biteTime=biteDelay+11
      {
        x+=32*image_xscale
        playSound(global.snd_Bite,0,1,1)
        bParryOpp=1
        image_index=1
      }
      else if biteTime=biteDelay+15 {image_index=2}
      else if biteTime=biteDelay+19
      {
        x-=32*image_xscale
        bParryOpp=0
        image_index=3
      }
      else if biteTime>=biteDelay+23 //End attack
      {
        bAttacking=0
        sprite_index=sPT_Slime_Walk
        image_speed=0.15
        biteTime=0
      }
    }

    if bAttacking=0
    {
      yVel+=0.3
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionSolid() and rpgLv>1
        y-=2
      moveTo(xVel,yVel)
    }
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
