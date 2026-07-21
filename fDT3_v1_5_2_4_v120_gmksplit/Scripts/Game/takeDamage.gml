/* !scriptId=27 */
/*
This script is used when an object takes damage
bPlayable is used to tell whether the object is your character or an enemy
argument0: id of the object dealing damage
*/
var tObjHit;
tObjHit=argument0

if bCanTakeDamage=true
{
  var totalDamage,initialDamage,tDmgColor;
  totalDamage=0
  //tAdjExp=0
  if bPlayable=false //---------------------------------------- Enemy takes damage ----------------------------------------
  {
    if tObjHit.weaponTag<100 {global.recAtkHit+=1}
    //Show enemy health
    if parent="enemy" and global.optEnemyHP=true and bShowHealthBar=true and global.charScan[0]=1 and bIsBoss=false
    {
      with oEnemyLifeDisplay {instance_destroy()}
      eLifeDisplay=instance_create(0,0,oEnemyLifeDisplay)
      eLifeDisplay.eID=id
    }
    
    initialDamage=tObjHit.atkPower //Initial damage
    totalDamage=initialDamage
    
    //---------- Skill & Equipment Damage Mods ----------
    /*var tDmgType,tDmgMod,tEqpAdj,tCurseCheck;
    tEqpAdj=0
    tCurseCheck=0
    tDmgMod=1
    if tObjHit.weaponTag<100
    {
      if global.activeCharacter=0
      {
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=1 {tEqpAdj+=0.05} //Equipment: Magic Sword
          else if global.equipJerry[i]=2 {tEqpAdj+=0.1} //Equipment: Sword Bravery
          else if global.equipJerry[i]=3 {tEqpAdj+=0.15} //Equipment: Power Glove
          else if global.equipJerry[i]=18 {tEqpAdj-=0.1} //Equipment: Plot Armor (-10% damage)
          
          if global.challengeRoom>0 //Cursed Equipment
          {
            if global.equipJerry[i]=10 {tCurseCheck+=1}
            else if global.equipJerry[i]=11 {tCurseCheck+=1}
            else if global.equipJerry[i]=12 {tCurseCheck+=1}
          }
        }
        tDmgMod=1+(global.skillTree[20]*0.02+tEqpAdj)
      }
      else if global.activeCharacter=1
      {
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=1 {tEqpAdj+=0.05} //Equipment: Magic Sword
          else if global.equipClaire[i]=2 {tEqpAdj+=0.1} //Equipment: Sword Bravery
          else if global.equipClaire[i]=3 {tEqpAdj+=0.15} //Equipment: Power Glove
          else if global.equipClaire[i]=18 {tEqpAdj-=0.1} //Equipment: Plot Armor (-10% damage)
          
          if global.challengeRoom>0 //Cursed Equipment
          {
            if global.equipClaire[i]=10 {tCurseCheck+=1}
            else if global.equipClaire[i]=11 {tCurseCheck+=1}
            else if global.equipClaire[i]=12 {tCurseCheck+=1}
          }
        }
        tDmgMod=1+(global.skillTree[21]*0.02+tEqpAdj)
      }
      initialDamage*=tDmgMod
      if tCurseCheck=3 {initialDamage*=2}
    }
    totalDamage=initialDamage*/
    
    //---------- Attack Type Damage Mods ----------
    var tDmgType;
    tDmgType=1
    if tObjHit.damageType="NORMAL"
    {
      if resType[0]=1 {tDmgType=0}
      else if resType[0]=2 {tDmgType=0.5}
      else if resType[0]=4 {tDmgType=2}
      else if resType[0]=5 {tDmgType=3}
    }
    else if tObjHit.damageType="PIERCE"
    {
      if resType[1]=1 {tDmgType=0}
      else if resType[1]=2 {tDmgType=0.5}
      else if resType[1]=4 {tDmgType=2}
      else if resType[1]=5 {tDmgType=3}
    }
    else if tObjHit.damageType="ELEMENTAL"
    {
      if resType[2]=1 {tDmgType=0}
      else if resType[2]=2 {tDmgType=0.5}
      else if resType[2]=4 {tDmgType=2}
      else if resType[2]=5 {tDmgType=3}
    }
    else if tObjHit.damageType="SHOT"
    {
      if resType[3]=1 {tDmgType=0}
      else if resType[3]=2 {tDmgType=0.5}
      else if resType[3]=4 {tDmgType=2}
      else if resType[3]=5 {tDmgType=3}
    }
    else if tObjHit.damageType="EXPLOSION"
    {
      if resType[4]=1 {tDmgType=0}
      else if resType[4]=2 {tDmgType=0.5}
      else if resType[4]=4 {tDmgType=2}
      else if resType[4]=5 {tDmgType=3}
    }
    else if tObjHit.damageType="SPECIAL"
    {
      if resType[5]=1 {tDmgType=0}
      else if resType[5]=2 {tDmgType=0.5}
      else if resType[5]=4 {tDmgType=2}
      else if resType[5]=5 {tDmgType=3}
    }
    //Damage text color and ability exp adjust
    if tDmgType=0 {tDmgColor=make_color_rgb(245,16,2)}
    else if tDmgType=0.5 {tDmgColor=make_color_rgb(247,137,8)}
    else if tDmgType=1 {tDmgColor=make_color_rgb(255,247,152)}
    else if tDmgType=2 {tDmgColor=make_color_rgb(113,239,14)}
    else if tDmgType=3 {tDmgColor=c_white}
    totalDamage*=tDmgType
  }    
  else //-------------------------------------------------- Player takes damage --------------------------------------------------
  {
    initialDamage=tObjHit.atkPower //Initial damage
    totalDamage+=initialDamage
    
    //---------- Skill & Equipment Damage Mods ----------
    var tEqpAdj,tCurseCheck;
    tEqpAdj=0
    tCurseCheck=0
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=18 {tEqpAdj+=1} //Equipment: Plot Armor
        else if global.equipJerry[i]=3 {tEqpAdj-=2} //Equipment: Power Glove (+2 damage)
        
        if tObjHit.damageType="NORMAL"
        {
          if global.equipJerry[i]=17 {tEqpAdj+=1} //Equipment: Force Armor
        }
        else if tObjHit.damageType="ELEMENTAL"
        {
          if global.equipJerry[i]=14 {tEqpAdj+=1} //Equipment: Mithril Shield
        }
        else if tObjHit.damageType="EXPLOSION"
        {
          if global.equipJerry[i]=15 {tEqpAdj+=1} //Equipment: Kevlar Vest
        }
        
        if tObjHit.parent="enemy"
        {
          if global.equipJerry[i]=16 {tEqpAdj+=1} //Equipment: Tactful Helm
        }
        else if tObjHit.parent="trap"
        {
          if global.equipJerry[i]=26 {tEqpAdj+=1} //Equipment: Durable Pants
        }
        
        if global.challengeRoom>0 //Cursed Equipment
        {
          if global.equipJerry[i]=10 {tCurseCheck+=1}
          else if global.equipJerry[i]=11 {tCurseCheck+=1}
          else if global.equipJerry[i]=12 {tCurseCheck+=1}
        }
      }
    }
    else if global.activeCharacter=1
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=18 {tEqpAdj+=1} //Equipment: Plot Armor
        else if global.equipClaire[i]=3 {tEqpAdj-=2} //Equipment: Power Glove (+2 damage)
        
        if tObjHit.damageType="NORMAL"
        {
          if global.equipClaire[i]=17 {tEqpAdj+=1} //Equipment: Force Armor
        }
        else if tObjHit.damageType="ELEMENTAL"
        {
          if global.equipClaire[i]=14 {tEqpAdj+=1} //Equipment: Mithril Shield
        }
        else if tObjHit.damageType="EXPLOSION"
        {
          if global.equipClaire[i]=15 {tEqpAdj+=1} //Equipment: Kevlar Vest
        }
        
        if tObjHit.parent="enemy"
        {
          if global.equipClaire[i]=16 {tEqpAdj+=1} //Equipment: Tactful Helm
        }
        else if tObjHit.parent="trap"
        {
          if global.equipClaire[i]=26 {tEqpAdj+=1} //Equipment: Durable Pants
        }
        
        if global.challengeRoom>0 //Cursed Equipment
        {
          if global.equipClaire[i]=10 {tCurseCheck+=1}
          else if global.equipClaire[i]=11 {tCurseCheck+=1}
          else if global.equipClaire[i]=12 {tCurseCheck+=1}
        }
      }
    }
    else if global.activeCharacter=2 //Jeremy takes 1/3 damage
    {
      totalDamage=round(totalDamage*0.66)
    }
    
    var tDarkOmen;
    tDarkOmen=0
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tDarkOmen=1}
      if global.equipClaire[i]=27 {tDarkOmen=1}
    }
    if tCurseCheck=3 {totalDamage*=3} //triple damage from cursed equipment
    if tDarkOmen=1 {totalDamage*=2} //double damage from Dark Omen
    totalDamage-=tEqpAdj
    
    //Damage resists from skills
    if global.activeCharacter=0 or global.activeCharacter=1
    {
      if tObjHit.damageType="NORMAL" {totalDamage-=global.skillTree[17]}
      else if tObjHit.damageType="ELEMENTAL" {totalDamage-=global.skillTree[14]}
      else if tObjHit.damageType="EXPLOSION" {totalDamage-=global.skillTree[15]}
      if tObjHit.parent="enemy" {totalDamage-=global.skillTree[16]}
      else if tObjHit.parent="trap" {totalDamage-=global.skillTree[27]}
    }
    
    //Set damage state
    if global.bRecordHits=1 and tObjHit.bDealZeroDamage=false
    {
      global.recDmgTaken+=round(totalDamage)
      global.recTimesHit+=1
      global.hitsTaken+=1
      global.killStreak=0
      tookHitAmount+=1
    }
    
    idleTime=0
    //setCollisionBounds(-8,-44,8,-1)
    groundDashRecovery=0
    backDashRecovery=0
    airDashRecovery=0
    doubleJumpAnim=0
    
    //Chao gets upset
    if oIdentifier.bChaoActive=1
    {
      var emRan;
      emRan=random(10)
      if emRan>7 {showEmote(oIdentifier,0,-6,sEmMad)}
    }
    
    //Player hit indicator
    if instance_exists(oHitWarn)
    {
      with oHitWarn {instance_destroy()}
    }
    var tHitWarn;
    tHitWarn=instance_create(0,0,oHitWarn)
    if tObjHit.damageType="NORMAL" {tHitWarn.image_blend=c_red}
    else if tObjHit.damageType="ELEMENTAL" {tHitWarn.image_blend=c_green}
    else if tObjHit.damageType="EXPLOSION" {tHitWarn.image_blend=c_yellow}
    
    oPlayer1.atkAnimSpd=-1
    with oMMXstrikeChain {instance_destroy()}
    grappleID.reuseTime=20
    oPlayer1.grappleState=0
    lastGuardTime=0
    
    if tObjHit.bCauseKnockback=true //Knockback
    {
      //Set character's attack state to none
      if attackState!=ACT_MORPHBALL and attackState!=ACT_IN_BIKE {attackState=0}
      bTakingDamage=1
      damageTime=flashTime
      bCanTakeHit=0
      //stopPlayer()
      oPlayer1.xVel=0; oPlayer1.yVel=0; oPlayer1.xAcc=0; oPlayer1.yAcc=-1
      oPlayer1.kLeft=0; oPlayer1.kRight=0; oPlayer1.kUp=0; oPlayer1.kDown=0
      if image_xscale=1 {xVel=-2}
      else {xVel=2}
      y-=2; yVel=-4
    }
    else
    {
      bCanTakeHit=0
      damageTime=2
    }
    
    //Damage sound
    playSound(global.snd_PlayerDamaged[0],0,1,1)
    if global.activeCharacter=3 {playSound(global.snd_Chao_Hey,0,1,20050+random(4000))}
  }
  
  //Set totalDamage to minimum if it goes below it ====================
  if bPlayable=false //-------------------- Damage enemy --------------------
  {
    if global.location=58 or global.location=76 or global.location=107 //double/triple damage to enemy if parried
    {
      if global.stJGame_C[0]>=4000
      {
        if global.activeCharacter=0 {totalDamage*=2}
        else {totalDamage*=3}
      }
    }
    if tObjHit.weaponTag!=105 {totalDamage=round(totalDamage*(1-(atkDefense/100)))} //attack defense (used mainly for the tower defense segment)
    
    if totalDamage<0 {totalDamage=0} //Ensures damage doesn't go below 0
    
    if global.optShowDamage=true and global.charScan[1]=1 and bShowDamagePopout=1 //Show damage dealt on screen
    {
      var tNewDamage,tDmgX,tDmgY;
      if bCenterDamageNotice=1
      {
        tDmgX=x
        tDmgY=y
      }
      else
      {
        tDmgX=round(bbox_left+(abs(sprite_width/2)))
        tDmgY=round(bbox_top+(abs(sprite_height/2)))
      }
      tNewDamage=instance_create(tDmgX,tDmgY,oDamageNotice)
      tNewDamage.damageValue=round(totalDamage)
      tNewDamage.damageColor=tDmgColor
    }
    
    if totalDamage>0
    {
      if tObjHit.weaponTag<100
      {
        //Hit combo
        if object_index!=oLatchCrystal
        {
          oPlayer1.comboDamage+=round(totalDamage)
          oPlayer1.hitCombo+=1
          if oPlayer1.hitCombo=100 //Achievement
          {
            var tCheckAchieve;
            tCheckAchieve=string_char_at(global.tokenRecognitions,29)
            if tCheckAchieve="0"
            {
              var tAchievement;
              tAchievement=instance_create(0,0,oAchievementNotice)
              tAchievement.myAchievement="Ultra Combo"; tAchievement.checkNum=29
            }
          }
          else if oPlayer1.hitCombo=1000 //Achievement
          {
            var tCheckAchieve;
            tCheckAchieve=string_char_at(global.tokenRecognitions,30)
            if tCheckAchieve="0"
            {
              var tAchievement;
              tAchievement=instance_create(0,0,oAchievementNotice)
              tAchievement.myAchievement="This Combo isn't Possible"; tAchievement.checkNum=30
            }
          }
          if oPlayer1.hitCombo>=global.recBestCombo {global.recBestCombo=oPlayer1.hitCombo}
        }
      }
      else
      {
        if tObjHit.weaponTag=100 {global.recDamageFromBirds+=round(totalDamage)}
        else if tObjHit.weaponTag>=150 and tObjHit.weaponTag<=160 //Jeremy Mech
        {
          oPlayer1.mechComboDamage+=round(totalDamage)
          oPlayer1.hitCombo+=1
          if oPlayer1.hitCombo>=global.recBestCombo {global.recBestCombo=oPlayer1.hitCombo}
        }
      }
      
      //Combo time
      oHUD.hitComboFadeTime=60+(global.skillTree[25]*6)
      oHUD.hitComboAlpha=1
      //Chain time
      if oHUD.killChainFadeTime>0
      {
        oHUD.killChainFadeTime+=15+global.skillTree[25]
        oHUD.killChainAlpha=1
        if oHUD.killChainFadeTime>95+(global.skillTree[25]*6) {oHUD.killChainFadeTime=95+(global.skillTree[25]*6)}
      }
      
      //Set damage state and stun time
      bTakingDamage=true
      damageTime=flashTime
      var tAddStun; tAddStun=tObjHit.stunTime-stunResist
      if tAddStun<0 {tAddStun=0}
      stunnedTime+=tAddStun
      if bDamageFlash=1 //Don't flash on road rage level
      {
        if stunnedTime>=30 {image_blend=c_purple}
        else {image_blend=c_red}
      }
      if stunnedTime<0 {stunnedTime=0}
      
      if global.location=94 {playSound(hitSound,0,0.95,1)}
      else {playSound(hitSound,0,1,1)}
      
      if tObjHit.weaponTag<100
      {
        if parent="enemy"
        {
          if tObjHit.damageType="NORMAL" //Aerial bounce
          {
            if tObjHit.object_index=oLinkSword or tObjHit.object_index=oBelmontWhip or tObjHit.object_index=oJCGameBladeStrike
            {
              if (global.optNoBounce=0) or (global.optNoBounce=1 and oPlayer1.kDown=0)
              {
                with oPlayer1
                {
                  if platformCharacterIs(IN_AIR)
                  {
                    var tEffect;
                    tEffect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
                    tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
                    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                    
                    oPlayer1.yVel=-2
                    if global.activeCharacter=0 {scrSlowFall(3,0.5,0)}
                    else {scrSlowFall(5,0.5,0)}
                    oPlayer1.yAcc=-3
                  }
                }
              }
            }
          }
          if global.location=58 or global.location=76 or global.location=107
          {
            if totalDamage>global.recG6MostPowerfulHit {global.recG6MostPowerfulHit=round(totalDamage)}
          }
          else
          {
            if totalDamage>global.recMostPowerfulHit {global.recMostPowerfulHit=round(totalDamage)}
          }
          //Re-enable air dash
          if oPlayer1.canAirDash=0 {oHUD.airDashScl=3}
          oPlayer1.canAirDash=1
          //Air dash power
          if oPlayer1.dashEnergy<oPlayer1.dashMeterMax-100 {oPlayer1.dashEnergy+=100}
          //Re-enable double jump
          if oPlayer1.doubleJumpCheck=0 {oHUD.doubleJumpScl=2}
          oPlayer1.doubleJumpCheck=1
          
          if round(totalDamage)>0 {checkWeaponHit(tObjHit)} //Check weapon that hits (For weapon accuracy)
          
          if tObjHit.damageType="NORMAL" {global.recTypeNormal+=round(totalDamage)}
          else if tObjHit.damageType="PIERCE" {global.recTypePierce+=round(totalDamage)}
          else if tObjHit.damageType="ELEMENTAL" {global.recTypeElemental+=round(totalDamage)}
          else if tObjHit.damageType="SHOT" {global.recTypeShot+=round(totalDamage)}
          else if tObjHit.damageType="EXPLOSION" {global.recTypeExplosion+=round(totalDamage)}
          else if tObjHit.damageType="SPECIAL" {global.recTypeSpecial+=round(totalDamage)}
          
          if tObjHit.weaponTag>=0 and tObjHit.weaponTag<=29 {global.recJerryDamage+=round(totalDamage)}
          else if tObjHit.weaponTag>=30 and tObjHit.weaponTag<=59 {global.recClaireDamage+=round(totalDamage)}
          
          global.recDmgDealt+=round(totalDamage)
        }
      }
      
      if tObjHit.weaponTag>=150 and tObjHit.weaponTag<=159 {global.recJeremyDamage+=round(totalDamage)}
      
      if global.activeCharacter=4 //Jeremy (Out of Mech) Energy restore
      {
        if oPlayer1.jeremySuperEnergy<oPlayer1.jeremySuperMax
        {
          oPlayer1.jeremySuperEnergy+=100
          if oPlayer1.jeremySuperEnergy>=oPlayer1.jeremySuperMax {oPlayer1.jeremySuperEnergy=oPlayer1.jeremySuperMax}
        }
      }
    }
    else //No damage
    {
      bTakingDamage=true
      damageTime=flashTime
      playSound(hitSound,0,1,44100)
    }
    with tObjHit //if attack pierces enemy
    {
      if bCanPierce=0 {instance_destroy()}
    }
  }
  else //-------------------- Player takes damage --------------------
  {
    if global.location=58 or global.location=76 or global.location=107 //double damage to player if guard broken
    {
      if global.stJGame_C[0]<=-1000 {totalDamage*=2}
    }
    if (global.difficulty=1 and global.bNightmareMode=0) or global.permaEasyMode=1 {totalDamage=ceil(totalDamage/2)} //half damage if playing on Assist mode
    if totalDamage<1 {totalDamage=1} //ensures character takes minimum damage
    if global.bRecordHits=1
    {
      if global.bOneHitKillMode=1 {totalDamage=irandom_range(10000,99999)} //one hit kill if playing on one hit kill mode
    }
    if tObjHit.bDealZeroDamage=1 {totalDamage=0}
    else
    {
      if global.bBossGallery=1 {global.levelTimeSecond+=5} //add 5 seconds if player is in the boss gallery
    }
    
    with oJerryParryWindow {instance_destroy()}
    with oClaireParryWindow {instance_destroy()}
    
    if global.activeCharacter=3 //Reduce Chao's graze bonus
    {
      oIdentifier.chaoGraze-=250
      if oIdentifier.chaoGraze<0 {oIdentifier.chaoGraze=0}
    }
    else if global.activeCharacter=4 //Remove Jeremy's Corkscrew Kick and Uppercut
    {
      with oJF_Atk_Uppercut {instance_destroy()}
      with oJF_Atk_CorkscrewKick {instance_destroy()}
    }
    
    if global.optShowDamage=true //Show damage dealt to player
    {
      var tNewDamage;
      if global.activeCharacter=3 {tNewDamage=instance_create(oIdentifier.x,oIdentifier.y,oDmgToPlayer)}
      else {tNewDamage=instance_create(oPlayer1.x,oPlayer1.y-26,oDmgToPlayer)}
      tNewDamage.damageValue=round(totalDamage)
      if tObjHit.damageType="NORMAL" {tNewDamage.drawColor=make_color_rgb(245,16,2)}
      else if tObjHit.damageType="ELEMENTAL" {tNewDamage.drawColor=make_color_rgb(113,239,14)}
      else if tObjHit.damageType="EXPLOSION" {tNewDamage.drawColor=make_color_rgb(255,247,152)}
      if tObjHit.parent="enemy" {tNewDamage.extraType=1}
      else if tObjHit.parent="trap" {tNewDamage.extraType=2}
      else {tNewDamage.extraType=0}
    }
  }
  life-=round(totalDamage) //Deal damage
  
  //if the character has 0 health ====================
  if life<=0 and bPlayable=false
  {
    enemyDefeat(0,tObjHit.weaponTag)
  }
}
