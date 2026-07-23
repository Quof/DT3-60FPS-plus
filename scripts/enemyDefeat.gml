/*
This script is used when an enemy is defeated
argument0: kill type
-- 0: Normal enemy
-- 1: Mario enemy
argument1: weapon tag
*/
life=0
var tKillType,tKillTag;
tKillType=argument0
tKillTag=argument1

expAward=pointWorth

if tKillType=0 //----- Enemy death sound -----
{
  if dieSound=1 {playSound(global.snd_EnemyDie,0,1,1)}
  else if dieSound=2 {playSound(global.snd_BombExplode,0,0.92,1)}
  else if dieSound=3 {playSound(global.snd_EnemyDieZelda,0,0.92,1)}
  else if dieSound=4 {playSound(global.snd_MetEnemyDieA,0,0.92,1)}
  else if dieSound=5 {playSound(global.snd_RPG_Destroy,0,0.95,1)}
}

if parent="enemy"
{
  //---------- kill chain ----------
  if bNoBonus=false
  {
    oHUD.killChainAlpha=1
    oHUD.killChainFadeTime=95+(global.skillTree[25]*6)
    oPlayer1.killChain+=1

    //-- Unreal Guy --
    if global.optUnrealGuyChainAudio=1
    {
      if oPlayer1.killChain>=2 and oPlayer1.killChain<=10
        playSound(global.snd_killChain[oPlayer1.killChain-2],0,1-(1-(global.optUnrealVolume/100)),22050*global.optUnrealPitch)
    }
    if global.optUnrealGuyChainVisual=1
    {
      if oPlayer1.killChain>=2 and oPlayer1.killChain<=10
      {
        with oKillChainAlert {instance_destroy()}
        var tMyCurKillChain;
        tMyCurKillChain=instance_create(0,0,oKillChainAlert)
        tMyCurKillChain.currentKillChain=""
        if oPlayer1.killChain=2 {tMyCurKillChain.currentKillChain="DOUBLE KILL!!"}
        else if oPlayer1.killChain=3 {tMyCurKillChain.currentKillChain="MULTI KILL!!"}
        else if oPlayer1.killChain=4 {tMyCurKillChain.currentKillChain="MEGA KILL!!"}
        else if oPlayer1.killChain=5 {tMyCurKillChain.currentKillChain="ULTRA KILL!!"}
        else if oPlayer1.killChain=6 {tMyCurKillChain.currentKillChain="MONSTER KILL!!"}
        else if oPlayer1.killChain=7 {tMyCurKillChain.currentKillChain="LUDICROUS KILL!!"}
        else if oPlayer1.killChain=8 {tMyCurKillChain.currentKillChain="WRECKER!!"}
        else if oPlayer1.killChain=9 {tMyCurKillChain.currentKillChain="SILENCER!!"}
        else if oPlayer1.killChain=10 {tMyCurKillChain.currentKillChain="HEADHUNTER!!"}
      }
    }

    if oPlayer1.killChain>=global.recBestChain {global.recBestChain=oPlayer1.killChain}
    //---------- killing spree ----------
    global.killStreak+=1

    //-- Unreal Guy --
    if global.optUnrealGuySpreeAudio=1
    {
      var tUnrealGuyVol;
      tUnrealGuyVol=1-(1-(global.optUnrealVolume/100))
      if global.killStreak=5 {playSound(global.snd_killingSpree[0],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=10 {playSound(global.snd_killingSpree[1],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=15 {playSound(global.snd_killingSpree[2],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=20 {playSound(global.snd_killingSpree[3],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=25 {playSound(global.snd_killingSpree[4],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=30 {playSound(global.snd_killingSpree[5],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=40 {playSound(global.snd_killingSpree[6],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=50 {playSound(global.snd_killingSpree[7],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=100 {playSound(global.snd_killingSpree[8],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
      else if global.killStreak=150 {playSound(global.snd_killingSpree[9],0,tUnrealGuyVol,22050*global.optUnrealPitch)}
    }
    if global.optUnrealGuySpreeVisual=1
    {
      if global.killStreak=5 or global.killStreak=10 or global.killStreak=15 or global.killStreak=20 or global.killStreak=25 or global.killStreak=30 or global.killStreak=40 or global.killStreak=50 or global.killStreak=100 or global.killStreak=150
      {
        with oKillSpreeAlert {instance_destroy()}
        var tMyCurKillSpree;
        tMyCurKillSpree=instance_create(0,0,oKillSpreeAlert)
        tMyCurKillSpree.currentKillSpree=""
        if global.killStreak=5 {tMyCurKillSpree.currentKillSpree="KILLING SPREE!!"}
        else if global.killStreak=10 {tMyCurKillSpree.currentKillSpree="DOMINATING!!"}
        else if global.killStreak=15 {tMyCurKillSpree.currentKillSpree="EXTERMINATION!!"}
        else if global.killStreak=20 {tMyCurKillSpree.currentKillSpree="SLAUGHTER!!"}
        else if global.killStreak=25 {tMyCurKillSpree.currentKillSpree="BLOOD BATH!!"}
        else if global.killStreak=30 {tMyCurKillSpree.currentKillSpree="ERADICATION!!"}
        else if global.killStreak=40 {tMyCurKillSpree.currentKillSpree="WICKED SICK!!"}
        else if global.killStreak=50 {tMyCurKillSpree.currentKillSpree="RAMPAGE!!"}
        else if global.killStreak=100 {tMyCurKillSpree.currentKillSpree="UNSTOPPABLE!!"}
        else if global.killStreak=150 {tMyCurKillSpree.currentKillSpree="GOD LIKE!!"}
      }
    }

    if global.killStreak>=global.recBestStreak {global.recBestStreak=global.killStreak}

    var tAwardAP;
    tAwardAP=1
    if bGenEnemy=1
    {
      if global.genEnemyAward>0 {global.genEnemyAward-=1}
      else {tAwardAP=0}
    }

    if expAward>0 and tAwardAP=1 //----- Award AP -----
    {
      //Level mod
      if global.pAPLevel>eLevel //Smaller award
      {
        var tLvDif,tLvMod,tLvTotal;
        tLvDif=abs(global.pAPLevel-eLevel)
        tLvMod=expAward*0.07
        tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

        expAward-=tLvTotal
        if expAward<round(pointWorth/3) {expAward=round(pointWorth/3)}
      }
      else if global.pAPLevel<eLevel //Bigger award
      {
        var tLvDif,tLvMod,tLvTotal;
        tLvDif=abs(global.pAPLevel-eLevel)
        tLvMod=expAward*0.08
        tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

        if expAward>pointWorth*3 {expAward=pointWorth*3}
        expAward+=tLvTotal
      }

      if tKillType=1 and oPlayer1.hopOnCount>1 //Mario multi-hop award
      {
        awardAwesome(10*oPlayer1.hopOnCount)
        var tHopCheck,tHopMax;
        tHopMax=oPlayer1.hopOnCount
        if tHopMax>8 {tHopMax=8}
        tHopCheck=tHopMax/2
        if tHopCheck>1 {expAward*=tHopCheck}
        expAward+=1
      }

      if tKillTag=102
      {
        expAward/=2
        if expAward<1 {expAward=1}
      }
      else if tKillTag=170 //Killed by Mario platform bump
      {
        global.recBumpKills+=1
      }

      if global.location=58 or global.location=107 //----- Award Exp in Gate 6 -----
      {
        if global.stJGame_C[1]<64
        {
          if expValue>0
          {
            if instance_exists(oExpAward)
            {
              with oExpAward {yy+=14}
            }

            var tFinalExpAward;
            tFinalExpAward=round(expValue)
            if global.skillTree[12]>0 {tFinalExpAward*=1+(global.skillTree[12]*0.06)}
            newAward=instance_create(0,0,oExpAward)
            newAward.pointValue=round(tFinalExpAward); newAward.type=0; newAward.yy=0

            global.recG6TotalExp+=round(tFinalExpAward)
            global.stJGame_C[2]+=round(tFinalExpAward)
            while (global.stJGame_C[2]>=global.stCGame_C[0])
            {
              with oExpAward {yy+=14}
              newAward=instance_create(0,0,oExpAward)
              newAward.type=1; newAward.yy=0
              global.stJGame_C[1]+=1 //Add 1 to rpg level
              global.stJGame_C[2]-=global.stCGame_C[0] //Reduce current exp by next exp
              if global.stJGame_C[1]>=1 and global.stJGame_C[1]<=14
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.15)-global.stCGame_C[0]
              if global.stJGame_C[1]>=15 and global.stJGame_C[1]<=19
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.13)-global.stCGame_C[0]
              else if global.stJGame_C[1]>=20 and global.stJGame_C[1]<=29
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.11)-global.stCGame_C[0]
              else if global.stJGame_C[1]>=30 and global.stJGame_C[1]<=39
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.09)-global.stCGame_C[0]
              else if global.stJGame_C[1]>=40 and global.stJGame_C[1]<=49
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.07)-global.stCGame_C[0]
              else if global.stJGame_C[1]>=50 and global.stJGame_C[1]<=63
                global.stCGame_C[0]+=round(global.stCGame_C[0]*1.05)-global.stCGame_C[0]

              var tNewLevelNotice;
              tNewLevelNotice=instance_create(0,0,oG6LevelUpNotice)
              tNewLevelNotice.myLevel=global.stJGame_C[1]

              if global.stJGame_C[1]=64
              {
                var tCheckAchieve;
                tCheckAchieve=string_char_at(global.tokenRecognitions,23)
                if tCheckAchieve="0"
                {
                  var tAchievement;
                  tAchievement=instance_create(0,0,oAchievementNotice)
                  tAchievement.myAchievement="Level 64"; tAchievement.checkNum=23
                }
                break;
              }
            }
          }
        }
      }

      if global.pAPLevel<40 //Award AP if below the level cap
      {
        if bFixedAP=1 {expAward=pointWorth}
        if global.difficulty>=2
        {
          awardAP(floor(expAward))
          if global.optShowPointsEarned=true
          {
            newAward=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oKillAward)
            newAward.pointValue=round(expAward)
          }
        }
      }
    }
  }
  else
  {
    if oHUD.killChainFadeTime>0
    {
      oHUD.killChainAlpha=1
      oHUD.killChainFadeTime=120
    }
  }
  global.recKillCount+=1
}

//------------------------------ Item drop ------------------------------
var tItemChance,tItemCheck,tDropInd,tLifeDif,tEqpAdj,tWepDropped,tChainBonus;
tWepDropped=0
tEqpAdj=0
if global.activeCharacter=0
{
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=4 {tEqpAdj+=15} //Equipment: Gauntlets of Desire
    if global.equipJerry[i]=5 {tEqpAdj+=30} //Equipment: Gauntlets of Greed
  }
}
else if global.activeCharacter=1
{
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=4 {tEqpAdj+=15} //Equipment: Gauntlets of Desire
    if global.equipClaire[i]=5 {tEqpAdj+=30} //Equipment: Gauntlets of Greed
  }
}

if oPlayer1.killChain>=2
{
  tChainBonus=oPlayer1.killChain*0.75
  if tChainBonus>15 {tChainBonus=15}
}
else {tChainBonus=0}

tItemChance=round(random(100))+(global.skillTree[18]*2)+tEqpAdj+tChainBonus
if tItemChance>=(100-baseItemChance) //---------- Item drop chance ----------
{
  //----- Consumable Weapon Item Drops -----
  if global.activeCharacter=0
  {
    if global.activeAbility[0]=1 //-- Arrows --
    {
      if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
      {
        var tWepBase;
        tWepBase=(100-(global.hudLink_Arrows[0]/global.hudLink_Arrows[1]*100))/2
        if random(100)<tWepBase+pickupDropMod+2.5
        {
          var tWepDrop;
          tWepDrop=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oWeaponPickup)
          tWepDropped=1
        }
      }
    }
  }
  else if global.activeCharacter=1
  {
    if global.activeAbility[1]=1 //-- Weapon Hearts --
    {
      if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
      {
        var tWepBase;
        tWepBase=(100-(global.hudBelmont_WeaponEn[0]/global.hudBelmont_WeaponEn[1]*100))/2
        if random(100)<tWepBase+pickupDropMod+2.5
        {
          var tWepDrop;
          tWepDrop=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oWeaponPickup)
          tWepDrop.sprite_index=sCVHeart
          tWepDropped=1
        }
      }
    }
    else if global.activeAbility[1]=2 //-- Missiles --
    {
      if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
      {
        var tWepBase;
        tWepBase=(100-(global.hudSamus_Missiles[0]/global.hudSamus_Missiles[1]*100))/2
        if random(100)<tWepBase+pickupDropMod+2.5
        {
          var tWepDrop;
          tWepDrop=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oWeaponPickup)
          tWepDrop.sprite_index=sMetroidMissile
          tWepDropped=1
        }
      }
    }
  }

  //----- Normal Item Drops -----
  if tWepDropped=0
  {
    if oPlayer1.lifePercent>=0.95 //-- Extra Heart % --
      tDropInd=-1000
    else
      tDropInd=round((1-oPlayer1.lifePercent)*15)

    tItemCheck=round(random(100))
    if tItemCheck+(baseDropIndex-tDropInd)>100 //-- Money --
    {
      if moneyWorth>0 and global.difficulty=2 //Can the enemy drop money
      {
        internetzDrop(1)
      }
    }
    else //-- Heart --
    {
      var tHeartDrop;
      tHeartDrop=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oHealthPickup)
      if global.location=49 {tHeartDrop.sprite_index=sMetroidHealthPickup}
    }
  }
}

if questType>0 {enemyQuest(questType)}
bCanTakeDamage=false
bCanDealDamage=false

var tAstreak,tAchain;
if global.bTowerDefense=0
{
  tAstreak=global.killStreak*(1+(eLevel/10))
  tAchain=oPlayer1.killChain*(1+(eLevel/10))
}
else
{
  tAstreak=(global.killStreak/10)*(1+(eLevel/10))
  tAchain=(oPlayer1.killChain/10)*(1+(eLevel/10))
}
awardAwesome(round(pointWorth+tAstreak+tAchain)*10) //Award Awesome Points

var tEffect;
if dieEffect=1 //Enemy death effect - Standard
{
  for(i=0;i<6;i+=1)
  {
    tEffect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
    tEffect.speed=2.66; tEffect.direction=i*60; tEffect.friction=0.11
    tEffect.fadeAlpha=0.025; tEffect.imageRot=0
  }
}
else if dieEffect=2 //Enemy death effect - Explosion
{
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sShipExplosion; tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else if dieEffect=3 //Enemy death effect - Zelda poof
{
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.33; tEffect.xSpd=0.5; tEffect.ySpd=-0.5
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.33; tEffect.xSpd=-0.5; tEffect.ySpd=-0.5; tEffect.image_angle=90
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.33; tEffect.xSpd=-0.5; tEffect.ySpd=0.5; tEffect.image_angle=180
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.33; tEffect.xSpd=0.5; tEffect.ySpd=0.5; tEffect.image_angle=270
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
}
else if dieEffect=4 //Enemy death effect - Standard Metroid enemy explosion
{
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sSamusMissileHit; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}

if bIsBoss=0
{
  if dieEffect!=0 {instance_destroy()}
}
