#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=2.4
image_yscale=2.72

//Enemy base statistics
eName="Bospider"
eLevel=18
maxLife=2500
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
imageEffect=0
eyeFrm=0
legFrm=0
moveSpd=4

webUsed=0
dirMove=0
spiderThrow=0
numOfDescents=0

atkProg=-1
atkTime=0
atkDelay=30

//Misc Data
xCenter=240
yGround=256
roomSpan=112

deathAnim=0

body=instance_create(x,y,oBospiderBody)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="Just like where it came from, you need to watch the 'webbing' to predict where it will be. It will continually go down, and when it finds a web string next to it, will always use it to move itself to the next vertical web string. It's only vulnerable when the eye on the body is open and is using clever tricks to conceal its weakness. I only have access to whatever weakness is open at the time, so you'll need to experiment."
    chaoText="This is a boss fight from Mega Man X, and was the first boss of the Sigma levels. It's worth noting that you can't dash through the spider safely."
    devText="Here's a boss that didn't need to be changed up that much from the original concept. There are a few subtle differences that make this version a bit harder than the one appearing in MMX. I found it interesting that I didn't need to change it up all that much for it to work with DT."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    imageEffect+=1
    if imageEffect mod 8=0
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sBospiderMain; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
      tAfterI.image_alpha=0.35; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.01
      tAfterI.xScaling=0.02; tAfterI.yScaling=0.02; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
    }

    if eyeFrm=2
    {
      jeremyText="Just like where it came from, you need to watch the 'webbing' to predict where it will be. It will continually go down, when it finds a web string next to it, will always use it to move itself to the next vertical web string. It's only vulnerable when the eye on the body is open. Glad you scanned it when the eye was open so I could see what its weakness is."
      resType[0]=3
      resType[1]=2
      if bossProgress>=3 {resType[2]=3}
      else {resType[2]=4}
      resType[3]=3
      resType[4]=3
      resType[5]=2
    }
    else
    {
      jeremyText="Just like where it came from, you need to watch the 'webbing' to predict where it will be. It will continually go down, when it finds a web string next to it, will always use it to move itself to the next vertical web string. It's only vulnerable when the eye on the body is open and is using clever tricks to conseal its weakness. I only have access to whatever weakness is open at the time, so you'll need to experiment."
      for(i=0;i<6;i+=1) {resType[i]=1}
    }

    if atkProg=-1 //---------- Battle start delay ----------
    {
      atkTime+=1
      if atkTime>=25-(bossProgress*2) {atkTime=0; atkProg=0}
    }
    else if atkProg=0 //---------- Coming down ----------
    {
      if atkTime=0 //Choose x position
      {
        webUsed=choose(1,2,3,4)
        if webUsed=1 {x=168}
        else if webUsed=2 {x=216}
        else if webUsed=3 {x=264}
        else if webUsed=4 {x=312}
        atkTime=1
      }
      y+=8
      if y>=16 {atkTime=0; atkProg=1}
    }
    else if atkProg=1 //---------- Throw spiderlings? ----------
    {
      atkTime+=1
      if atkTime=1
      {
        spiderThrow+=1
        if spiderThrow=3
        {
          spiderThrow=0
        }
        else
        {
          atkTime=0
          atkProg=2
        }
      }
      else if atkTime=10
      {
        playSound(global.snd_ChargeStrike,0,0.94,36000)
        var newSpider;
        newSpider=instance_create(x,y,oBospiderling); newSpider.moveDir=1; newSpider.xVel=-1
        newSpider=instance_create(x,y,oBospiderling); newSpider.moveDir=2; newSpider.xVel=-3
        newSpider=instance_create(x,y,oBospiderling); newSpider.moveDir=3; newSpider.xVel=1
        newSpider=instance_create(x,y,oBospiderling); newSpider.moveDir=4; newSpider.xVel=3
      }
      else if atkTime=15 {atkTime=0; atkProg=6}
    }
    else if atkProg=2 //---------- Place webbing ---------- 171,219,267,315 - 69,85,187
    {
      atkTime+=1
      if atkTime=5
      {
        if numOfDescents=0 //First descent
        {
          if webUsed=1 or webUsed=2 {instance_create(167,107,oBospiderWeb); instance_create(263,171,oBospiderWeb)}
          else if webUsed=3 or webUsed=4 {instance_create(263,107,oBospiderWeb); instance_create(167,171,oBospiderWeb)}
        }
        else //All other descents
        {
          var ranControl,xWebbing,yWebbing;
          ranControl=5
          xWebbing=167
          yWebbing=choose(59,75)
          for(i=0;i<3;i+=1)
          {
            for(ii=0;ii<5;ii+=1)
            {
              if random(10)>ranControl {instance_create(xWebbing,yWebbing+(ii*32),oBospiderWeb); ranControl+=0.1}
              else {ranControl-=0.2}

              if ii=4
              {
                xWebbing+=48
                if yWebbing=59 {yWebbing=75}
                else {yWebbing=59}
              }
            }
          }
        }
      }
      else if atkTime>=25-bossProgress
      {
        playSound(global.snd_MMDoorOpen,0,0.96,18000)
        atkTime=0
        atkProg=3
      }
    }
    else if atkProg=3 //---------- Move down ----------
    {
      legFrm+=0.2+(moveSpd/30)
      var tClosestWeb,tDistToWebX,tDistToWebY;
      for(i=0;i<moveSpd;i+=1)
      {
        y+=1
        tClosestWeb=instance_position(x,y,oBospiderWeb)
        if tClosestWeb!=noone
        {
          tDistToWebX=point_distance(x,0,tClosestWeb.x+25,0)
          tDistToWebY=point_distance(0,y,0,tClosestWeb.y)
          if tDistToWebX<=27 and tDistToWebY<=2 and tClosestWeb.bUsed=0
          {
            tClosestWeb.bUsed=1
            y=tClosestWeb.y
            if x>tClosestWeb.x+21 {dirMove=1}
            else {dirMove=2}
            atkProg=4
            break;
          }
        }

        if y>=224
        {
          atkProg=5
          break;
        }
      }
    }
    else if atkProg=4 //---------- Move along cross web ----------
    {
      legFrm+=0.25
      if dirMove=1 //Move left
      {
        for(i=0;i<moveSpd;i+=1)
        {
          x-=1
          if webUsed=2 and x<=169 {x=168; webUsed-=1; atkProg=3; break;}
          else if webUsed=3 and x<=217 {x=216; webUsed-=1; atkProg=3; break;}
          else if webUsed=4 and x<=265 {x=264; webUsed-=1; atkProg=3; break;}
        }
      }
      else if dirMove=2 //Move right
      {
        for(i=0;i<moveSpd;i+=1)
        {
          x+=1
          if webUsed=1 and x>=215 {x=216; webUsed+=1; atkProg=3; break;}
          else if webUsed=2 and x>=263 {x=264; webUsed+=1; atkProg=3; break;}
          else if webUsed=3 and x>=311 {x=312; webUsed+=1; atkProg=3; break;}
        }
      }
    }
    else if atkProg=5 //---------- Stop at bottom ----------
    {
      atkTime+=1
      if atkTime=3 {eyeFrm=1}
      else if atkTime=5 {eyeFrm=2}
      else if atkTime>=atkDelay
      {
        oBospiderWeb.bUsed=2
        atkTime=0
        eyeFrm=0
        atkProg=6
      }
    }
    else if atkProg=6 //---------- Climb back up ----------
    {
      legFrm+=0.2+(moveSpd/30)
      y-=moveSpd
      if y<=-44
      {
        numOfDescents+=1
        atkProg=-1
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.85 and lifePercent>=0.71 and bossProgress=0
    {
      atkDelay-=2
      moveSpd=5
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.56 and bossProgress=1
    {
      atkDelay-=2
      moveSpd=6
      bossProgress+=1
    }
    else if lifePercent<=0.55 and lifePercent>=0.41 and bossProgress=2
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=2; tAtkShield.atkUp=1
      resType[2]-=1
      atkDelay-=2
      moveSpd=8
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.26 and bossProgress=3
    {
      atkDelay-=2
      moveSpd=9
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=4
    {
      atkDelay-=2
      moveSpd=11
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sBospiderMain
      image_xscale=1; image_yscale=1
      with oBospiderBody {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(21)
        global.newMapX=1560; global.newMapY=992; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  oBospiderBody.x=x; oBospiderBody.y=y
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {redDmgHit(0)}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sBospiderMain,legFrm,x,y)
draw_sprite(sBospiderEye,eyeFrm,x,y)
