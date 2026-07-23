#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-19,-45,19,-1)
sprite_index=sPT_Skeleton_Rise
image_speed=0
visible=0
bCanDealDamage=false
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Skeleton"
eLevel=28
maxLife=300
life=maxLife
pointWorth=35
atkPower=7
resType[3]=1
resType[5]=4
baseItemChance=65
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=50
detectDistX=176
detectDistY=144

bJumpReady=1
bBlocking=0
rising=0
runAcc=2.25
turnTime=20
atkTime=20
atkDelay=35

deathAnim=0

jeremyText="When you attack this from the front, if it's not attacking, it will guard. Best way to deal with this is to either sneak in an attack while it's attacking or parry. I suppose you could jump over it too."
chaoText="This comes from the game 'King of Dragons'. In that game, they could also throw spears, but it doesn't look like this has access to that."
devText="When designing the parry system, it went through quite a few iterations. The original idea is what the game has now, but I toyed with both characters having their own shield meter, as well as both having the same shielding mechanics. I wanted to further separate the playstyles and make them fit with their intended ranges, so a lot of them were thrown out pretty quick."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(rpgLv) +string(" Prototype Skeleton")
pointWorth=35+round(rpgLv/5)
if rpgLv<=9
{
  expValue=5+(rpgLv*2)
  maxLife=300+(rpgLv*7)
}
else if rpgLv>=10 and rpgLv<=25
{
  expValue=10+(rpgLv*3)
  maxLife=370+round(rpgLv*9.75)
}
else if rpgLv>=26 and rpgLv<=49
{
  expValue=15+round(rpgLv*4.25)
  maxLife=440+(rpgLv*11)
}
else if rpgLv>=50 and rpgLv<=59
{
  expValue=30+round(rpgLv*5.5)
  maxLife=520+(rpgLv*14)
}
else if rpgLv>=60
{
  expValue=40+round(rpgLv*6.75)
  maxLife=650+(rpgLv*16)
}
life=maxLife

if global.location=107
{
  eName=string("Lv.") +string(rpgLv) +string(" Betatype Skeleton")
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
  if y+48>oPlayer1.y and bActive=false {makeEnemyActive(1)}

  if bActive=true and life>0
  {
    makeEnemyActive(1)
    if rising>=0 and rising<=99
    {
      rising+=1
      if rising=1
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
        visible=1
      }
      else if rising=5 {image_index=1}
      else if rising=9 {image_index=2}
      else if rising=13 {image_index=3}
      else if rising>=17
      {
        image_speed=0.15
        sprite_index=sPT_Skeleton_Walk
        detectDistX=264
        detectDistY=200
        bCanDealDamage=true
        bCanTakeDamage=true
        rising=100
      }
    }
    else if rising>=100
    {
      //Turn around if turn timer is 0
      if bJumpReady=1
      {
        if (x<oPlayer1.x and image_xscale=-1) or (x>oPlayer1.x and image_xscale=1)
        {
          turnTime-=1
          if turnTime=0
          {
            xVel*=-1
            turnTime=20
          }
        }

        if atkTime<atkDelay //Check direction
        {
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}

          if point_distance(x,0,oPlayer1.x,0)<96
          {
            if oPlayer1.attackState=oPlayer1.ACT_ATK {bBlocking=1; sprite_index=sPT_Skeleton_Block}
            else {bBlocking=0; sprite_index=sPT_Skeleton_Walk}
          }
          else {bBlocking=0; sprite_index=sPT_Skeleton_Walk}

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
      }

      //Check if cliff edge and jump
      if yVel=0 and bJumpReady=1
      {
        var tDrop;
        tDrop=0
        if aiCheckHoriz(1,1,0,16,4)
        {
          if aiCheckVert(0,3,24,16,4)=1
          {
            tDrop=1
          }
        }

        if tDrop=0
        {
          xVel=(runAcc*1.25)*image_xscale
          y-=4
          yVel=-4
          sprite_index=sPT_Skeleton_Jump
          bJumpReady=0
        }
      }

      //---------- Swing sword ----------
      if sprite_index!=sPT_Skeleton_Block {atkTime+=1}
      if atkTime>=atkDelay and bJumpReady=1
      {
        if atkTime=atkDelay //Change anim
        {
          if point_distance(x,0,oPlayer1.x,0)<80
          {
            xVel=0
            instance_create(x-(74*image_xscale),y-19,oG6_CounterSpark)
            sprite_index=sPT_Skeleton_Swing
            bBlocking=0
            image_speed=0; image_index=0
          }
          else {atkTime=atkDelay-5}
        }
        else if atkTime=atkDelay+18 {image_index=1}
        else if atkTime=atkDelay+22
        {
          playSound(global.snd_DeathSlash,0,0.98,20000)
          bParryOpp=1
          image_index=2
        }
        else if atkTime=atkDelay+26 {image_index=3}
        else if atkTime=atkDelay+30
        {
          bParryOpp=0
          image_index=3
        }
        else if atkTime>=atkDelay+34 //End attack
        {
          sprite_index=sPT_Skeleton_Walk
          image_speed=0.15
          atkTime=0
        }
      }

      yVel+=0.3
      if isCollisionBottom(1)
      {
        yVel=0
        bJumpReady=1
        if sprite_index=sPT_Skeleton_Jump {sprite_index=sPT_Skeleton_Walk}
      }
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
if enemyDeflect(1,1,1,1,1,1)=1 and bBlocking=1 and global.stJGame_C[0]<4000
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x+random_range(-11,11),y-4-random(44),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else {event_inherited()}
