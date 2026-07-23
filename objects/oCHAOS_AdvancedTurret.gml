#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bWall (myWallX,myWallY,myWallScale)
event_inherited()
y+=2

//Enemy base statistics
eName="CHAOS Advanced Turret"
eLevel=33
maxLife=520
life=maxLife
pointWorth=72
atkPower=9
resType[1]=1
resType[3]=4
stunResist=5
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0
inactiveDist*=2

attachState=0
attachTime=0
currHspd=0; currVspd=0
xPoint=0
yPoint=0
atkSide=0
maxSpeedX=3
maxSpeedY=4
wallSet=0

shotTime=15
shotDelay=35
bulletCycle=0
atkChange=0
bombTime=25
bombDelay=70
bombType=0
hideDelay=0

deathAnim=0

jeremyText="At first glance, this is simply a turret that can fire rapidly. However, after some time or taking damage, it will detach itself from its mount. From there, it will keep its distance and periodically pass by you, dropping lots of bombs. There is an assist function for something called the 'CHAOS Sabotage.'"
chaoText="That line you see sometimes is when its assist function is active. I think that is distance based; I'm pretty sure it is buffing its ally's resistances while it's on."
devText="Major changes in behavior for standard enemies (while certain events are occurring) is a rare thing in DT. I aimed to change that as it seems to create more engaging and differing encounters. In this case, an ally that's close by with a shield can cause this one to hide behind it."
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
    if wallSet=0 //Create wall
    {
      if bWall=1
      {
        myWall=instance_create(myWallX,myWallY,oCAdvT_Door); myWall.image_yscale=myWallScale
        tgtWallX=myWallX+8
        tgtWallY=myWallY+(myWallScale*8)
        wallSet=1
      }
      else {wallSet=100}
    }
    else if wallSet>=1 and wallSet<=80
    {
      wallSet+=1
      if wallSet mod 3=0
      {
        var tEffect,tSetPartDir,tSetPartTime,tRanPartY;
        tRanPartY=random_range(tgtWallY-32,tgtWallY+32)
        tSetPartDir=point_direction(x,y,tgtWallX,tRanPartY)
        tSetPartTime=round(point_distance(x,y,tgtWallX,tRanPartY)/8)
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.speed=8; tEffect.direction=tSetPartDir; tEffect.image_speed=0.33
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=tSetPartTime; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }

    if shotTime<shotDelay and bombTime<bombDelay+11 //Facing direction
    {
      if attachState!=3 //To Ally
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }
    }

    if attachState=0 //Hanging
    {
      attachTime+=1
      if attachTime>=285 or life<maxLife
      {
        attachTime=0; attachState=1
      }
    }
    else if attachState=1 //Detach
    {
      attachTime+=1
      if attachTime=15
      {
        var tEffect,tEfCir,tDir;
        tDir=random_range(-1.5,1.5)
        tEffect=instance_create(x,y-19,oEffectGrav); tEffect.sprite_index=sCHAOS_AdvancedTurretHook
        tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=0; tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
        tEffect.grav=0.15; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1

        tEfCir=instance_create(x,y-10,oEfCircleSoftFade)
        tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=2; tEfCir.fadeSpeed=0.1
        for(i=0;i<10;i+=1)
        {
          tEffect=instance_create(x,y-10,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.newBlend=-1
          tEffect.speed=random(1)+1; tEffect.image_speed=0.25; tEffect.fadeSpd=0.1; tEffect.direction=random(360)
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
        if x>=oPlayer1.x {atkSide=1}
        else {atkSide=-1}
        attachTime=0; attachState=2
      }
    }
    else if attachState=2 //Standard
    {
      if atkChange=0 and shotTime<shotDelay-5 {atkChange=1} //Stop using spam shot

      if oGame.time mod 8=0 //Smoke
      {
        var tEffect;
        tEffect=instance_create(x-(9*image_xscale),y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
        tEffect.fadeSpd=0.05; tEffect.image_blend=make_color_rgb(190+random(20),190+random(20),190+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        if image_xscale=1 {tEffect.direction=random_range(100,110)}
        else {tEffect.direction=random_range(70,80)}
      }

      //Movement
      if bombTime<bombDelay {xPoint=oPlayer1.x+(104*atkSide)}
      else
      {
        if bombTime=bombDelay
        {
          var tEffect,tMyDir;
          if atkSide=1 {tMyDir=0}
          else {tMyDir=180}
          for(i=0;i<6;i+=1)
          {
            tEffect=instance_create(x+lengthdir_x(i*8,tMyDir),y+lengthdir_y(i*8,tMyDir),oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=1-(i*0.09)
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
          }
          x+=48*atkSide
          currHspd=0
        }
        if bombTime>=bombDelay and bombTime<=bombDelay+10
        {
          xPoint=oPlayer1.x+(160*atkSide)
          maxSpeedX=4
        }
        else if bombTime=bombDelay+11
        {
          maxSpeedX=9
          if atkSide=1 {atkSide=-1}
          else {atkSide=1}
        }
        else if bombTime>=bombDelay+12 {xPoint=oPlayer1.x+(160*atkSide)}
      }
      yPoint=oPlayer1.y-104

      if x>xPoint
      {
        if currHspd>-maxSpeedX {currHspd-=0.5}
        else {currHspd+=0.5}
      }
      else if x<xPoint
      {
        if currHspd<maxSpeedX {currHspd+=0.5}
        else {currHspd-=0.5}
      }
      if y>yPoint
      {
        if currVspd>-maxSpeedY {currVspd-=0.15}
        else {currVspd+=0.6}
      }
      else if y<yPoint
      {
        if currVspd<maxSpeedY {currVspd+=0.6}
        else {currVspd-=0.15}
      }
      hspeed=currHspd; vspeed=currVspd

      //ATTACK: Bombing run
      bombTime+=1
      if bombTime>=bombDelay+15
      {
        if bombTime mod 6=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y,oGravityBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.direction=270; tNewAttack.bulletSpeed=3; tNewAttack.damageType="EXPLOSION"
          if bombType=0 {tNewAttack.sprite_index=sC_TurretBombA; bombType=1}
          else if bombType=1 {tNewAttack.sprite_index=sC_TurretBombB; bombType=0}
        }
      }
      if bombTime>=bombDelay+65
      {
        maxSpeedX=3
        bombTime=0
      }

      if hideDelay=0 //Hide delay
      {
        if bombTime<bombDelay-3 and atkChange=1 //Cannot be performing a Bomb Run or Spam Shot
        {
          if instance_exists(oCSU_Shield)
          {
            findShield=instance_nearest(x,y,oCSU_Shield)
            if point_distance(x,y,findShield.x,findShield.y)<176 //Shock Unit must be close enough
            {
              maxSpeedX=4; maxSpeedY=4
              myAlly=findShield.id
              attachState=3
            }
          }
        }
      }
      else {hideDelay-=1}
    }
    else if attachState=3 //Hide behind Shock Unit selected with shield
    {
      if instance_exists(myAlly)
      {
        if x<myAlly.x {image_xscale=1}
        else {image_xscale=-1}

        xPoint=myAlly.x-(60*myAlly.image_xscale)
        yPoint=myAlly.y

        if x>xPoint
        {
          if currHspd>-maxSpeedX {currHspd-=0.4}
          else {currHspd+=0.4}
        }
        else if x<xPoint
        {
          if currHspd<maxSpeedX {currHspd+=0.4}
          else {currHspd-=0.4}
        }
        if y>yPoint
        {
          if currVspd>-maxSpeedY {currVspd-=0.4}
          else {currVspd+=0.4}
        }
        else if y<yPoint
        {
          if currVspd<maxSpeedY {currVspd+=0.4}
          else {currVspd-=0.4}
        }
        hspeed=currHspd; vspeed=currVspd

        if point_distance(x,y,xPoint,yPoint)<34
        {
          if oGame.time mod 7=0
          {
            if image_xscale=1 {targetAngle=0}
            else {targetAngle=180}
            event_user(0)
          }
        }
      }
      else
      {
        maxSpeedX=3; maxSpeedY=4
        attachState=2
      }
    }

    //ATTACK: Spam Shot
    if atkChange=0
    {
      shotTime+=1
      if shotTime=shotDelay //Shot warning
      {
        var tEffect;
        tEffect=instance_create(x+(image_xscale*10),y+5,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=1
        tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
        targetAngle=point_direction(x+(image_xscale*10),y+5,oPlayer1.x,oPlayer1.y-26)
        if image_xscale=1 {targetAngle-=10}
        else {targetAngle+=10}
        bulletCycle=0
      }
      if shotTime>=shotDelay+10
      {
        if shotTime mod 2=0
        {
          event_user(0)
        }
        targetAngle+=1.5*image_xscale
      }
      if shotTime>=shotDelay+50
      {
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-7,7),y+1+random(30),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.075
    if image_alpha<0
    {
      if bWall=1
      {
        myWall.myProg=1
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Spam Shot
var tNewAttack,tXOff,tYOff;
tXOff=0; tYOff=0
bulletCycle+=1
if bulletCycle=1 {tXOff=6; tYOff=4}
else if bulletCycle=2 {tXOff=17; tYOff=2}
else if bulletCycle=3 {tXOff=17; tYOff=2}
else if bulletCycle>=4 {tXOff=3; tYOff=11; bulletCycle=0}
tNewAttack=instance_create(x+(tXOff*image_xscale),y+tYOff,oNormalBullet)
tNewAttack.sprite_index=sC_TurretBullet; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=targetAngle
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if attachState=0 or attachState=1 {draw_sprite(sCHAOS_AdvancedTurretHook,0,x,y-19)}
