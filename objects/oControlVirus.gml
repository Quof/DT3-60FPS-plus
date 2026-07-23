#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Control Virus"
eLevel=10
maxLife=1700
life=maxLife
atkPower=5
resType[1]=2
resType[3]=2
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
xCenter=264
yGround=288
roomSpan=136

deathAnim=0

for(i=0;i<3;i+=1)
{
  turretSummon[i]=i*200
  atkTurret[i]=0
}
turretDelay=480

laserSummon=120
laserDelay=500
lineA_Length=0
lineB_Length=0

wrenchSummon=1020
wrenchDelay=510

jeremyText="It only has 2 attacks. The first are the turrets it summons on the walls. It will summon up 2 on the right side and 1 on the left. Take them out quickly, not for just your health, but the health of your Pincher Bot. The other attack is its Laser Bots. Take them out as quickly as possible."
chaoText="This is the Virus attempting to control the city's defense grid. Once it loads itself completely into that system, there will be no removing it, so you need to get rid of it before the upload is complete."
devText="Making timed scenarios, whether it be boss encounters or not, always seems like a risky thing to do. After deciding the boss HP and the timer, everything else was based on those two values. I knew I wanted a quick and intense encounter. There was no one thing that gave me the most trouble when designing this. Every change affected the outcome to a great degree."
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
    oBotDoorA.bFunctional=1
    oCh5CC_CompScr.sequence=1
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    for(i=0;i<3;i+=1) //---------- Create turrets ----------
    {
      if !instance_exists(atkTurret[i])
      {
        turretSummon[i]+=1
        if turretSummon[i]=turretDelay
        {
          var tNX,tNY,tEffect;
          if i=0 {tNX=416; tNY=192}
          else if i=1 {tNX=128; tNY=192}
          else if i=2 {tNX=400; tNY=240}
          tEffect=instance_create(tNX,tNY,oEffect)
          tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.34
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if turretSummon[i]>=turretDelay+30
        {
          if i=0
          {
            atkTurret[0]=instance_create(416,192,oControlVirusTurret)
            atkTurret[0].image_xscale=-1
          }
          else if i=1
            atkTurret[1]=instance_create(128,192,oControlVirusTurret)
          else if i=2
          {
            atkTurret[2]=instance_create(400,240,oControlVirusTurret)
            atkTurret[2].image_xscale=-1
          }

          var tEffect;
          for(ii=0;ii<4;ii+=1)
          {
            tEffect=instance_create(atkTurret[i].x-12+random(8),atkTurret[i].y-12+random(24),oEffect)
            tEffect.sprite_index=sSamusMissileEffect
            tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_speed=0.75
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          turretSummon[i]=0
        }
      }
    }

    //---------- Create laser bots ----------
    laserSummon+=1
    if laserSummon=laserDelay {playSound(global.snd_Alert,0,0.96,8000)}
    if laserSummon>=1020
    {
      with oControlVirusLaserBot
        instance_destroy()

      for(i=0;i<5;i+=1)
      {
        var tEffect;
        tEffect=instance_create(176+(i*48),176,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_create(176+(i*48),176,oControlVirusLaserBot)
      }
      lineA_Length=0
      lineB_Length=0
      laserSummon=0
    }

    if !instance_exists(oWrenchBlock) //---------- Create wrench blocks ----------
    {
      wrenchSummon+=1
      if bossProgress!=3
      {
        if wrenchSummon=wrenchDelay
        {
          var tNX,tNY,tEffect;
          tNX=400; tNY=272
          tEffect=instance_create(tNX,tNY,oEffect)
          tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.34
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if wrenchSummon>=wrenchDelay+30
        {
          instance_create(384,256,oWrenchBlock)
          var tEffect;
          for(i=0;i<4;i+=1)
          {
            tEffect=instance_create(oWrenchBlock.x+random(32),oWrenchBlock.y+random(32),oEffect)
            tEffect.sprite_index=sSamusMissileEffect
            tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_speed=0.75
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
          wrenchSummon=0
        }
      }
      else
      {
        if wrenchSummon=1
        {
          for(i=0;i<4;i+=1)
          {
            tEffect=instance_create(304+(i*32),272,oEffect)
            tEffect.sprite_index=sEfEnemyAppear; tEffect.image_speed=0.34
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
        else if wrenchSummon>=30
        {
          for(i=0;i<4;i+=1)
          {
            instance_create(288+(i*32),256,oWrenchBlock)
          }
          wrenchSummon=0
          bossProgress+=1
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      turretDelay-=20
      laserDelay-=10
      wrenchDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      turretDelay-=20
      laserDelay-=10
      wrenchDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      turretDelay-=20
      laserDelay-=10
      wrenchDelay-=15
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.25
      with oPincherBot {instance_destroy()}
      with oWrenchBlock {instance_destroy()}
      wrenchSummon=0
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oControlVirusTurret {instance_destroy()}
      with oControlVirusLaserBot {instance_destroy()}
      with oPassBullet {instance_destroy()}
      with oPincherBot {instance_destroy()}
      with oWrenchBlock {instance_destroy()}
      oBotDoorA.bFunctional=0
      if oCh5CC_CompScr.timer>=1000
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,13)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Quick Engineer"; tAchievement.checkNum=13
        }
      }
      oCh5CC_CompScr.sequence=2
    }
    if deathAnim mod 5=0
    {
      var tEffect;
      tEffect=instance_create(x-16+random(32),y-16+random(32),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if deathAnim>=90
    {
      if global.bBossGallery=1
      {
        bossRoomTally(9)
        global.newMapX=2008; global.newMapY=1280; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if laserSummon>=laserDelay
{
  if lineA_Length<96
    lineA_Length+=4
  else
  {
    lineB_Length+=8
    if lineB_Length>=368
    {
      if laserSummon<1000
        laserSummon=1000
    }
  }


  draw_set_color(c_green)
  draw_set_alpha(1)
  draw_line_width(x,y,x,y-lineA_Length,2)
  if lineB_Length>0
    draw_line_width(x,y-lineA_Length,x-lineB_Length,y-lineA_Length,2)

  if lineB_Length>=160
  {
    draw_line_width(368,y-lineA_Length-23,368,y-lineA_Length+23,2)
    draw_circle(368,y-lineA_Length,16,1)
  }
  if lineB_Length>=208
  {
    draw_line_width(320,y-lineA_Length-23,320,y-lineA_Length+23,2)
    draw_circle(320,y-lineA_Length,16,1)
  }
  if lineB_Length>=256
  {
    draw_line_width(272,y-lineA_Length-23,272,y-lineA_Length+23,2)
    draw_circle(272,y-lineA_Length,16,1)
  }
  if lineB_Length>=304
  {
    draw_line_width(224,y-lineA_Length-23,224,y-lineA_Length+23,2)
    draw_circle(224,y-lineA_Length,16,1)
  }
  if lineB_Length>=352
  {
    draw_line_width(176,y-lineA_Length-23,176,y-lineA_Length+23,2)
    draw_circle(176,y-lineA_Length,16,1)
  }
}
