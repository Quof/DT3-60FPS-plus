#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-18,-60,18,-1)
image_speed=0.08

//Enemy base statistics
eName="Sword Knight"
eLevel=15
maxLife=610
life=maxLife
pointWorth=21
atkPower=5
resType[4]=4
stunResist=9
baseItemChance=65
moneyWorth=5
affiliation=3
dieEffect=0
inactiveDist*=1.5

runAcc=0.5
xAdj=0
yAdj=0
swordAng=0
checkSound=0

swingTime=35
swingDelay=70
chargeChance=0
forceCharge=0

deathAnim=0
swdVelY=0

jeremyText="These guys can pose a threat. They have a nice amount of HP, but keep your cool and you'll be fine. When you see it stop, it's going to do one of two things. When its sword is at its back, it's going to swing. If it points the sword at you, get out of the way, cause it's going to charge."
chaoText="Sometimes these were the worst enemies in Castlevania. So much HP and their attack range is pretty big. Though they aren't very fast, so it's nothing TOO bad."
devText="I didn't know about the fighting game term 'zoning' until my roommate, Jerry, saw me testing and these guys showed up. He shouted out 'WTF, he's zoning!', to which I replied, 'WTF is zoning'. And now I know."

mySword=instance_create(x-18,y-32,oSwordKnightSword)
mySword.ownerID=id
mySword.atkPower=atkPower
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with mySword {instance_destroy()}
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
    if sprite_index=sCV_SwordKnightWalk //----- Movement -----
    {
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}

      if point_distance(x,0,oPlayer1.x,0)>76
      {
        if image_xscale=1 {xVel=runAcc}
        else {xVel=-runAcc}
      }
      else if point_distance(x,0,oPlayer1.x,0)<72
      {
        //Check if cliff edge and stop
        var tStop;
        tStop=0
        if !collision_point(x+(16*image_xscale),y+4,oSolid,0,1)
        {
          for(i=0;i<3;i+=1)
          {
            if !collision_point(x+(16*image_xscale),y+4+(i*24),oSolid,0,1)
            {
              tStop=1
            }
            else {tStop=0}
          }
        }

        if tStop=0
        {
          if x<oPlayer1.x {xVel=-runAcc*1.5}
          else {xVel=runAcc*1.5}
        }
        else {xVel=0}
      }
      else {xVel=0}
    }
    else {xVel=0}

    //----- Sword swing -----
    swingTime+=1
    if swingTime>=swingDelay and swingTime<=swingDelay+99 //Begin
    {
      if point_distance(x,0,oPlayer1.x,0)<80
      {
        sprite_index=sCV_SwordKnightSwing
        image_index=0; image_speed=0
        mySword.bAfterImage=1
        swingTime=swingDelay+100
      }
      else
      {
        chargeChance+=1
        if chargeChance>random(125) or forceCharge>=3
        {
          sprite_index=sCV_SwordKnightCharge
          image_index=0; image_speed=0
          mySword.bAfterImage=1
          forceCharge=0
          chargeChance=0
          swingTime=swingDelay+100
        }
        else {swingTime=swingDelay-5}
      }
    }
    else if swingTime>=swingDelay+115 and swingTime<=swingDelay+999 //Swing
    {
      if sprite_index=sCV_SwordKnightSwing
      {
        if checkSound=0 and image_index>=1
        {
          if checkScreenArea(x,y,48)=1 {playSound(global.snd_KnightSwordSwing,0,0.93,20500)}
          checkSound=1
        }
        image_index+=0.5
        if image_index>=7.4
        {
          image_index=7
          swingTime=swingDelay+1000
        }
      }
      else
      {
        if checkSound=0
        {
          if checkScreenArea(x,y,48)=1 {playSound(global.snd_ChargeStrike,0,0.96,1)}
          checkSound=1
        }
        image_index=1
        if image_xscale=1 {xVel=12}
        else {xVel=-12}
        //Check if cliff edge and stop
        var tStop;
        tStop=0
        if !collision_point(x+(16*image_xscale),y+4,oSolid,0,1)
        {
          for(i=0;i<3;i+=1)
          {
            if !collision_point(x+(16*image_xscale),y+4+(i*24),oSolid,0,1)
            {
              tStop=1
            }
            else {tStop=0}
          }
        }

        if swingTime>=swingDelay+140 or tStop=1 or (xVel>0 and x>oPlayer1.x) or (xVel<0 and x<oPlayer1.x)
          swingTime=swingDelay+1000
      }
    }
    else if swingTime>=swingDelay+1000 and swingTime<=swingDelay+1999 //End (When swinging)
    {
      if sprite_index=sCV_SwordKnightSwing and swingTime>=swingDelay+1009
      {
        if x>oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}
        sprite_index=sCV_SwordKnightWalk
        mySword.bAfterImage=0
        image_index=0; image_speed=0.08
        checkSound=0
        swingTime=0
      }
      else if sprite_index=sCV_SwordKnightCharge and swingTime>=swingDelay+1003
      {
        xVel=0
        if x>oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}
        sprite_index=sCV_SwordKnightSwing
        mySword.bAfterImage=0
        image_index=4
        swingTime=swingDelay+2000
      }
    }
    else if swingTime>=swingDelay+2010 //End (When charging)
    {
      sprite_index=sCV_SwordKnightWalk
      image_index=0; image_speed=0.08
      checkSound=0
      swingTime=0
    }

    if sprite_index=sCV_SwordKnightSwing //Sword placement
    {
      xAdj=0; yAdj=0
      if image_index>=0 and image_index<=0.99
      {
        xAdj=25; yAdj=34
        if image_xscale=1 {swordAng=180}
        else {swordAng=0}
      }
      else if image_index>=1 and image_index<=1.99
      {
        xAdj=24; yAdj=44
        if image_xscale=1 {swordAng=160}
        else {swordAng=20}
      }
      else if image_index>=2 and image_index<=2.99
      {
        xAdj=24; yAdj=47
        if image_xscale=1 {swordAng=200}
        else {swordAng=340}
      }
      else if image_index>=3 and image_index<=3.99
      {
        xAdj=16; yAdj=70
        if image_xscale=1 {swordAng=135}
        else {swordAng=45}
      }
      else if image_index>=4 and image_index<=4.99
      {
        xAdj=-4; yAdj=70
        swordAng=90
      }
      else if image_index>=5 and image_index<=5.99
      {
        xAdj=-16; yAdj=29
        if image_xscale=1 {swordAng=45}
        else {swordAng=135}
      }
      else if image_index>=6 and image_index<=6.99
      {
        xAdj=-20; yAdj=27
        if image_xscale=1 {swordAng=25}
        else {swordAng=155}
      }
      else if image_index>=7 and image_index<=7.99
      {
        xAdj=-19; yAdj=26
        if image_xscale=1 {swordAng=0}
        else {swordAng=180}
      }
    }
    else if sprite_index=sCV_SwordKnightCharge
    {
      xAdj=0; yAdj=0
      if image_index=0
      {
        xAdj=-3; yAdj=50
      }
      else if image_index=1
      {
        xAdj=-2; yAdj=41
      }
      if image_xscale=1 {swordAng=0}
      else {swordAng=180}
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)

    //----- Sword placement -----
    if sprite_index=sCV_SwordKnightWalk
    {
      xAdj=0; yAdj=0
      if image_xscale=1 {swordAng=200}
      else {swordAng=340}

      if image_index>=0 and image_index<=0.99
      {
        xAdj=18
        yAdj=32
      }
      else if image_index>=1 and image_index<=1.99
      {
        xAdj=16
        yAdj=33
      }
      else if image_index>=2 and image_index<=2.99
      {
        xAdj=17
        yAdj=34
      }
    }

    if image_xscale=1
    {
      mySword.x=x-xAdj
      mySword.y=y-yAdj
    }
    else
    {
      mySword.x=x+xAdj
      mySword.y=y-yAdj
    }
    mySword.image_angle=swordAng

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      mySword.bCanDealDamage=false
      mySword.bCanTakeDamage=false
    }
    if deathAnim mod 3=0
    {
      if deathAnim mod 6=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-19,19),y-1-random(60),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    mySword.image_alpha-=0.02
    mySword.y+=swdVelY
    swdVelY+=0.075
    image_alpha-=0.02
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType!="NORMAL"
{
  if swingTime<swingDelay {swingTime+=4}
  chargeChance+=15
  forceCharge+=1
}
if swingTime<swingDelay {swingTime+=6}
