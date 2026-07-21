/* !scriptId=89 */
/*
This script is called inside the character step event.
It is just to clean up the code.
*/

if global.activeCharacter=0 //---------------------------------------- Jerry ----------------------------------------
{
  if global.activeAbility[0]=1 //-------------------- Link --------------------
  {
    //--------------- Sword ---------------
    if kActA and kActAPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      playerTechUse(0)
    }
    //--------------- Arrow ---------------
    if global.hudLink_Arrows[0]>0 and global.hasAbilToken[1]>=3
    {
      if kActB and bTakingDamage=false and busterLastShotTime>=5 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        var tCrossbow;
        tCrossbow=3
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=36 //Equipment: Crossbow
          {
            tCrossbow=1
            break;
          }
        }
        
        if kActBPressed=1
        {
          if instance_number(oLinkArrow)<tCrossbow {playerTechUse(1)}
          specAttackChargeA=0
        }
        
        if specAttackChargeA<60
        {
          specAttackChargeA+=1
          if specAttackChargeA=30
          {
            var tEffect;
            tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
            tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
            tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
      }
      else if kActBPressed=0 //release arrow
      {
        if specAttackChargeA>15
        {
          if instance_number(oLinkArrow)<3 {playerTechUse(1)}
        }
        specAttackChargeA=0
      }
    }
    //--------------- Bomb ---------------
    if global.hudLink_BombEn[0]>=120-round(global.skillTree[1]*7.5)-equipValA and global.hasAbilToken[1]>=4
    {
      if kActC and kActCPressed=1 and !instance_exists(oLinkBomb) and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        playerTechUse(2)
      }
    }
  }
  if global.activeAbility[0]=2 //-------------------- Mega Man --------------------
  {
    if grappleState=0 or grappleState=3
    {
      if global.hudMega_BusterEn[0]>0 and !kUp //--------------- X Buster ---------------
      {
        if kActA and bTakingDamage=false and busterLastShotTime>=4 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if kActAPressed=1
          {
            busterPCheck=1
            if instance_number(oMMXbuster)<3
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              if chargeShotsStored>0 //Nightmare only
              {
                attackCharge=40
              }
              playerTechUse(10)
            }
          }
          
          var tEnergyGem;
          tEnergyGem=0
          for(i=0;i<3;i+=1)
          {
            if global.equipJerry[i]=29 //Equipment: Energy Gem
            {
              tEnergyGem=1
              break;
            }
          }
          
          if tEnergyGem=0
          {
            if global.bNightmareMode=0
            {
              chargeMax=40-(global.skillTree[5]*2)
              for(i=0;i<3;i+=1)
              {
                if global.equipJerry[i]=9 //Equipment: Energy Orb
                {
                  chargeMax-=7
                  break;
                }
              }
              
              if attackCharge<60
              {
                attackCharge+=1
                if attackCharge=5 and chargeSoundCheck=0 //Charging sound
                {
                  playSound(global.snd_WepCharge,0,1,1)
                  chargeSoundCheck=1
                }
                if attackCharge=chargeMax
                {
                  SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
                  playSound(global.snd_WepChargeComplete,0,1,1)
                  var tEffect;
                  tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
                  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
                  tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                }
              }
            }
            else //Nightmare Mode
            {
              if attackCharge<85
              {
                nightmareOrb=0
                for(i=0;i<3;i+=1)
                {
                  if global.equipJerry[i]=9 //Equipment: Energy Orb
                  {
                    nightmareOrb=7
                    break;
                  }
                }
                
                attackCharge+=1
                if attackCharge=5 and chargeSoundCheck=0 //Charging sound
                {
                  playSound(global.snd_WepCharge,0,1,33075)
                  chargeSoundCheck=1
                }
                if attackCharge=40-nightmareOrb
                {
                  playSound(global.snd_WepChargeComplete,0,1,1)
                  var tEffect;
                  tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
                  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
                  tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                  
                  if chargeShotsStored<3 {chargeShotsStored+=1}
                }
                if attackCharge=80-(nightmareOrb*2) //Store more shots
                {
                  if chargeShotsStored<3
                  {
                    playSound(global.snd_WepChargeComplete,0,1,1)
                    var tEffect;
                    tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
                    tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
                    tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                    chargeShotsStored+=1
                    attackCharge=41-nightmareOrb
                  }
                }
                
                /*if attackCharge=65
                {
                  SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
                  playSound(global.snd_WepChargeComplete,0,1,1)
                  var tEffect;
                  tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
                  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
                  tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                }*/
              }
            }
          }
        }
        else if kActAPressed=0 //release shot
        {
          if attackCharge>10
          {
            busterPCheck=0
            if instance_number(oMMXbuster)<3
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              playerTechUse(10)
            }
          }
          attackCharge=0
        }
      }
      
      //--------------- Shotgun Ice ---------------
      if kActB and global.hasAbilToken[3]>=3 and busterLastShotTime>=4 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        if kActBPressed=1
        {
          if global.hudMega_ShotIceEn[0]>1
          {
            if instance_number(oMMXshotgunIceA)<2 and global.hasAbilToken[3]>=3
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              playerTechUse(11)
            }
          }
        }
        
        equipValA=0
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=9 //Equipment: Energy Orb
          {
            equipValA=7
            break;
          }
        }
        if global.hasBoostedXCharge=1
        {
          if specAttackChargeA<60
          {
            specAttackChargeA+=1
            if specAttackChargeA=5 and chargeSoundCheck=0 //Charging sound
            {
              playSound(global.snd_WepCharge,0,1,1)
              chargeSoundCheck=1
            }
            if specAttackChargeA=55-(global.skillTree[6]*5)-equipValA
            {
              SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
              playSound(global.snd_WepChargeComplete,0,1,1)
              var tEffect;
              tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
              tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
              tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
              tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
          }
        }
        else {specAttackChargeA=1}
      }
      else if kActBPressed=0 //release shot
      {
        if specAttackChargeA>10 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if global.hudMega_ShotIceEn[0]>1
          {
            if instance_number(oMMXshotgunIceA)<2 and global.hasAbilToken[3]>=3
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              playerTechUse(11)
            }
          }
        }
        specAttackChargeA=0
      }
      
      //--------------- Gravity Well ---------------
      if kActC and global.hasAbilToken[3]>=3 and busterLastShotTime>=4 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        if kActCPressed=1
        {
          if global.hudMega_GravityEn[0]>1
          {
            if instance_number(oMMXgravityWell)<2 and global.hasAbilToken[3]>=4
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              playerTechUse(12)
            }
          }
        }
        
        equipValA=0
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=9 //Equipment: Energy Orb
          {
            equipValA=7
            break;
          }
        }
        if global.hasBoostedXCharge=1
        {
          if specAttackChargeB<60
          {
            specAttackChargeB+=1
            if specAttackChargeB=5 and chargeSoundCheck=0 //Charging sound
            {
              playSound(global.snd_WepCharge,0,1,1)
              chargeSoundCheck=1
            }
            if specAttackChargeB=55-(global.skillTree[6]*5)-equipValA
            {
              SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
              playSound(global.snd_WepChargeComplete,0,1,1)
              var tEffect;
              tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
              tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
              tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
              tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
          }
        }
        else {specAttackChargeB=1}
      }
      else if kActCPressed=0 //release shot
      {
        if specAttackChargeB>10 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if global.hudMega_GravityEn[0]>1
          {
            if instance_number(oMMXgravityWell)<2 and global.hasAbilToken[3]>=4
            {
              if bWallGrab=0
              {
                if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
                else if state=DUCKING {mmState=BUSTER_DUCK}
                else if state=RUNNING {mmState=BUSTER_RUN}
                else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
              }
              playerTechUse(12)
            }
          }
        }
        specAttackChargeB=0
      }
    }
    
    //--------------- Strike Chain ---------------
    if kActA and kActAPressed=1 and kUp and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      if grappleState=0 and global.hasAbilToken[3]>=5
      {
        if bWallGrab=0
        {
          if state=STANDING or state=LOOKING_UP {mmState=BUSTER_STAND}
          else if state=DUCKING {mmState=BUSTER_DUCK}
          else if state=RUNNING {mmState=BUSTER_RUN}
          else if state=JUMPING or state=FALLING {mmState=BUSTER_JUMP}
        }
        playerTechUse(13)
      }
    }
    if kUp and kActA=0 and kActAPressed=0 {attackCharge=0} //Remove charge when letting go of ActionA when up is held
  }
  if global.activeAbility[0]=3 //-------------------- Game --------------------
  {
    //--------------- Spam Gun ---------------
    if global.hudGame_WeaponEn[0]>=7-global.skillTree[8]
    {
      if kActA and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        playerTechUse(20)
      }
    }
    //--------------- Bird Swarm ---------------
    if kActC and kActCPressed=1
    {
      equipValA=0
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=22 //Equipment: Zephyr Amulet
        {
          equipValA=32
          break;
        }
      }
      if global.hudGame_WeaponEn[0]>=96-round(96*(global.skillTree[10]*0.03))-equipValA and global.hasAbilToken[5]>=3
      {
        if bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if !instance_exists(oJCGameBirdSwarm) {playerTechUse(21)}
        }
      }
    }
    //--------------- Block ---------------
    if global.stJGame_C[0]>0
    {
      if blockForceTime=0
      {
        if kActB and bTakingDamage=false and (attackState=0 or attackState=ACT_BLOCK) and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if attackState!=ACT_BLOCK
          {
            //-----
            dashInvulnerabilityTime=0; bCanTakeHit=true; bCanTakeDamage=true
            image_alpha=1; bTakingDamage=false; damageTime=0
            var tParryTiming;
            tParryTiming=3
            for(i=0;i<3;i+=1) //Equipment: Golden Shield
            {
              if global.equipJerry[i]=31
              {
                tParryTiming=4
                break;
              }
            }
            var tParryWindow;
            tParryWindow=instance_create(x,y,oJerryParryWindow); tParryWindow.decayTime=tParryTiming+1
            blockForceTime=tParryTiming
            //-----
            if lastGuardTime<20 {global.stJGame_C[0]-=350}
            else {global.stJGame_C[0]-=120}
            lastGuardTime=0
          }
          global.stJGame_C[0]-=5
          attackState=ACT_BLOCK
        }
        else if kActBPressed=0 and attackState=ACT_BLOCK {attackState=0}
      }
      else
      {
        blockForceTime-=1
        global.stJGame_C[0]-=5
        attackState=ACT_BLOCK
      }
    }
    else
    {
      if attackState=ACT_BLOCK {attackState=0}
    }
  }
}
else if global.activeCharacter=1 //---------------------------------------- Claire ----------------------------------------
{
  if global.activeAbility[1]=1 //-------------------- Belmont --------------------
  {
    if global.bNightmareMode=1 //Nightmare Mode Only - Dagger Spam (Down - Down - Forward - Forward)
    {
      if daggerSpamCheck=0 and oKeyCodes.kCodePressed[4]=1 {daggerSpamCheck=10}
      else if daggerSpamCheck>=1 and daggerSpamCheck<=9 and oKeyCodes.kCodePressed[4]=1 {daggerSpamCheck=20}
      if daggerSpamCheck=11 or daggerSpamCheck=21 or daggerSpamCheck=31 {daggerSpamCheck=0}
    }
    
    //--------------- Hair Whip ---------------
    if kActA and kActAPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      playerTechUse(30)
    }
    //--------------- Dagger ---------------
    if kActB and kActBPressed=1 and bTakingDamage=false and busterLastShotTime>=4 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      var tMysticDagger;
      tMysticDagger=1
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=38 //Equipment: Mystic Dagger
        {
          tMysticDagger=1.2
          break;
        }
      }
      if global.hudBelmont_WeaponEn[0]>=round((8-global.skillTree[3])*tMysticDagger) and global.hasAbilToken[2]>=3
      {
        if instance_number(oBelmontDagger)<3 {playerTechUse(31)}
      }
    }
    //--------------- Holy Water ---------------
    if kActC and kActCPressed=1 and bTakingDamage=false and busterLastShotTime>=5 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      var tBlessedVessel;
      tBlessedVessel=1
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=39 //Equipment: Blessed Vessel
        {
          tBlessedVessel=1.2
          break;
        }
      }
      if global.hudBelmont_WeaponEn[0]>=round((12-global.skillTree[4])*tBlessedVessel) and global.hasAbilToken[2]>=4
      {
        if instance_number(oBelmontHolyWater)<2 {playerTechUse(32)}
      }
    }
  }
  else if global.activeAbility[1]=2 //-------------------- Samus --------------------
  {
    if kActA and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      if attackState=ACT_MORPHBALL //--------------- Bomb ---------------
      {
        if global.hasAbilToken[4]>=7
        {
          if kActAPressed=1
          {
            if global.hudSamus_Bombs[0]<3 {playerTechUse(42)}
          }
          
          if global.bNightmareMode=1 //Nightmare Mode Only - Power Bomb (Charge)
          {
            if specAttackChargeB<55 and powerBombCheck=0
            {
              specAttackChargeB+=1
              if specAttackChargeB=5 //Charging sound
              {
                playSound(global.snd_WepCharge,0,1,1)
                chargeSoundCheck=1
              }
              
              if specAttackChargeB=55
              {
                SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
                playSound(global.snd_WepChargeComplete,0,1,1)
                var tEffect;
                tEffect=instance_create(oPlayer1.x,oPlayer1.y-8,oEffect)
                tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
                tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
              }
            }
          }
        }
      }
      else //--------------- Cannon ---------------
      {
        if busterLastShotTime>=5
        {
          if kActAPressed=1
          {
            var tCannonEn;
            tCannonEn=(global.hudSamus_CannonEn[0]/global.hudSamus_CannonEn[1])*33
            if tCannonEn<32
            {
              if instance_number(oSamusCannon)<3
              {
                if state=STANDING or state=LOOKING_UP or state=DUCKING
                {
                  if kUp {mmState=BUSTER_STAND_UP}
                  else if kDown {mmState=BUSTER_DUCK}
                  else {mmState=BUSTER_STAND}
                }
                else if state=RUNNING
                {
                  if kUp {mmState=BUSTER_RUN_UP}
                  else {mmState=BUSTER_RUN}
                }
                else if state=JUMPING or state=FALLING
                {
                  if kUp {mmState=BUSTER_JUMP_UP}
                  else if kDown {mmState=BUSTER_JUMP_DOWN}
                  else {mmState=BUSTER_JUMP}
                }
                busterPCheck=0
                playerTechUse(40)
              }
            }
          }
          
          if attackCharge<55 and global.hasAbilToken[4]>=4
          {
            attackCharge+=1
            if attackCharge=5 and chargeSoundCheck=0 //Charging sound
            {
              playSound(global.snd_WepCharge,0,1,1)
              chargeSoundCheck=1
            }
            if attackCharge=25
            {
              SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
              playSound(global.snd_WepChargeComplete,0,1,1)
              var tEffect;
              tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
              tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
              tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
              tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            }
          }
        }
      }
    }
    else if kActAPressed=0 //Release shot
    {
      if attackState=ACT_MORPHBALL
      {
        if specAttackChargeB=55
        {
          playSound(global.snd_MorphBomb,0,1,15000)
          playerAttack=instance_create(x,y-8,oSamusPowerBombA)
          specAttackChargeB=0
          powerBombCheck=90
        }
      }
      else
      {
        if attackCharge>0
        {
          if instance_number(oSamusCannon)<3
          {
            if state=STANDING or state=LOOKING_UP or state=DUCKING
            {
              if kUp {mmState=BUSTER_STAND_UP}
              else if kDown {mmState=BUSTER_DUCK}
              else {mmState=BUSTER_STAND}
            }
            else if state=RUNNING
            {
              if kUp {mmState=BUSTER_RUN_UP}
              else {mmState=BUSTER_RUN}
            }
            else if state=JUMPING or state=FALLING
            {
              if kUp {mmState=BUSTER_JUMP_UP}
              else if kDown {mmState=BUSTER_JUMP_DOWN}
              else {mmState=BUSTER_JUMP}
            }
            busterPCheck=1
            playerTechUse(40)
          }
          attackCharge=0
        }
      }
    }
    //--------------- Missile ---------------
    if global.hudSamus_Missiles[0]>0 and attackState!=ACT_MORPHBALL and global.hasAbilToken[4]>=5
    {
      if kActB and bTakingDamage=false and busterLastShotTime>=5 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        var tRailGun,tMissileMax;
        tRailGun=0; tMissileMax=2
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=34 //Equipment: Rail Gun
          {
            tRailGun=1; tMissileMax=1
            break;
          }
        }
        
        if kActBPressed=1
        {
          if instance_number(oSamusMissile)<tMissileMax
          {
            if state=STANDING or state=LOOKING_UP or state=DUCKING
            {
              if kUp {mmState=BUSTER_STAND_UP}
              else if kDown {mmState=BUSTER_DUCK}
              else {mmState=BUSTER_STAND}
            }
            else if state=RUNNING
            {
              if kUp {mmState=BUSTER_RUN_UP}
              else {mmState=BUSTER_RUN}
            }
            else if state=JUMPING or state=FALLING
            {
              if kUp {mmState=BUSTER_JUMP_UP}
              else if kDown {mmState=BUSTER_JUMP_DOWN}
              else {mmState=BUSTER_JUMP}
            }
            playerTechUse(41)
          }
        }
        
        if tRailGun=0
        {
          equipValA=0
          for(i=0;i<3;i+=1)
          {
            if global.equipClaire[i]=19 //Equipment: Blast Cannon
            {
              equipValA=14
              break;
            }
          }
          
          if global.hasAbilToken[4]>=8 //Diffusion Missile
          {
            if specAttackChargeA<60
            {
              specAttackChargeA+=1
              if specAttackChargeA=5 and chargeSoundCheck=0 //Charging sound
              {
                playSound(global.snd_WepCharge,0,1,1)
                chargeSoundCheck=1
              }
              if specAttackChargeA=55-(global.skillTree[7]*6)-equipValA
              {
                SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
                playSound(global.snd_WepChargeComplete,0,1,1)
                var tEffect;
                tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
                tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
                tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
              }
            }
          }
          else {specAttackChargeA=1}
        }
      }
      else if kActBPressed=0 //Release missile
      {
        if specAttackChargeA>10
        {
          if instance_number(oSamusMissile)<2
          {
            if state=STANDING or state=LOOKING_UP or state=DUCKING
            {
              if kUp {mmState=BUSTER_STAND_UP}
              else if kDown {mmState=BUSTER_DUCK}
              else {mmState=BUSTER_STAND}
            }
            else if state=RUNNING
            {
              if kUp {mmState=BUSTER_RUN_UP}
              else {mmState=BUSTER_RUN}
            }
            else if state=JUMPING or state=FALLING
            {
              if kUp {mmState=BUSTER_JUMP_UP}
              else if kDown {mmState=BUSTER_JUMP_DOWN}
              else {mmState=BUSTER_JUMP}
            }
            playerTechUse(41)
          }
        }
        specAttackChargeA=0
      }
    }
    //Check for double tap to morph
    if doubleTapTime>0 {doubleTapTime-=1}
    if kDownPressed and attackState=0
    {
      if doubleTapTime=0
      {
        doubleTapTime=6
      }
      else
      {
        doubleTapTime=10
      }
    }
    //--------------- Change into and out of Morph Ball mode ---------------
    if ((kActC and kActCPressed=1) or (global.optMorphControls=2 and doubleTapTime=10)) and (attackState=0 and global.hasAbilToken[4]>=3) //To Morph Ball
    {
      doubleTapTime=0
      kDownPressed=0
      setCollisionBounds(-7,-13,7,-1)
      if global.location=106 {runAcc=0.81} //Gate F
      else {runAcc=7.6} //Normal
      attackState=ACT_MORPHBALL
      SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
      equipValC=45
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=32 //Equipment: Morph Mortar
        {
          equipValC=25
          break;
        }
      }
      
      if (attackCharge>=equipValC or specAttackChargeA>=equipValC) and global.hasAbilToken[4]>=7 //Multiple bombs
      {
        playSound(global.snd_MorphBomb,0,1,1)
        var playerAttack;
        playerAttack=instance_create(x,y-8,oSamusBomb)
        playerAttack.bombType=1; playerAttack.bounces=1
        
        playerAttack=instance_create(x,y-8,oSamusBomb)
        playerAttack.bombType=1; playerAttack.bounces=2
        playerAttack.xVel=1; playerAttack.yVel=4
        
        playerAttack=instance_create(x,y-8,oSamusBomb)
        playerAttack.bombType=1; playerAttack.bounces=2
        playerAttack.xVel=-1; playerAttack.yVel=4
        
        playerAttack=instance_create(x,y-8,oSamusBomb)
        playerAttack.bombType=1; playerAttack.bounces=3
        playerAttack.xVel=2.25; playerAttack.yVel=2
        
        playerAttack=instance_create(x,y-8,oSamusBomb)
        playerAttack.bombType=1; playerAttack.bounces=3
        playerAttack.xVel=-2.25; playerAttack.yVel=2
      }
      attackCharge=0
      specAttackChargeA=0
    }
    else if ((kActC and kActCPressed=1) or (scrController(3) and kUpPushedSteps<2 and global.optMorphControls>=1)) and attackState=ACT_MORPHBALL //Out of Morph Ball
    {
      setCollisionBounds(-7,-39,7,-1)
      if isCollisionSolid() {setCollisionBounds(-7,-13,7,-1)}
      else
      {
        //setCollisionBounds(-8,-39,8,-1)
        //if isCollisionLeft(0)=1 {x+=1}
        //if isCollisionRight(0)=1 {x-=1}
        if global.location=106 {runAcc=0.8}
        else {runAcc=7.3}
        SS_StopSound(global.snd_WepCharge); chargeSoundCheck=0
        attackState=0
      }
    }
    
    if attackState=ACT_MORPHBALL //Precision movement with Morph Ball
    {
      if global.location=106 //Gate F
      {
        if kActB
        {
          if platformCharacterIs(ON_GROUND) {runAcc=0.405}
          else {runAcc=0.3}
        }
        else
        {
          if platformCharacterIs(ON_GROUND) {runAcc=0.81}
          else {runAcc=0.6}
        }
      }
      else //Normal
      {
        if kActB
        {
          if platformCharacterIs(ON_GROUND) {runAcc=3.8}
          else {runAcc=2.65}
        }
        else
        {
          if platformCharacterIs(ON_GROUND) {runAcc=7.6}
          else {runAcc=5.3}
        }
      }
    }
  }
  else if global.activeAbility[1]=3 //-------------------- Game --------------------
  {
    //--------------- Blade Strike ---------------
    if global.hudGame_WeaponEn[0]>=12-global.skillTree[11]
    {
      if kActA and kActAPressed=1 and blockForceTime=0 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        playerTechUse(50)
      }
    }
    //--------------- Chainblade Storm ---------------
    if kActC and kActCPressed=1
    {
      equipValA=0
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=24 //Equipment: Magic Urn
        {
          equipValA=32
          break;
        }
      }
      if global.hudGame_WeaponEn[0]>=96-round(96*(global.skillTree[13]*0.03))-equipValA and global.hasAbilToken[6]>=3
      {
        if bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if !instance_exists(oJCGameChainSpawn)
          {
            playerTechUse(51)
          }
        }
      }
    }
    /*
    //--------------- Flame Shield ---------------
    if !instance_exists(oJCGameFlameShield) //Summon Flame
    {
      if global.hudGame_WeaponEn[0]>=50-global.skillTree[12]
      {
        if kActC and kActCPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          {playerTechUse(52)}
        }
      }
    }
    else //Split Flame
    {
      if kActC and kActCPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
      {
        oJCGameFlameShield.bSplit=1
      }
    }*/
    //--------------- Block ---------------
    if global.stJGame_C[0]>0 and global.stJGame_C[0]<1001
    {
      if blockForceTime=0
      {
        if kActB and bTakingDamage=false and (attackState=0 or attackState=ACT_BLOCK) and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
        {
          if attackState!=ACT_BLOCK
          {
            //-----
            dashInvulnerabilityTime=0; bCanTakeHit=true; bCanTakeDamage=true
            image_alpha=1; bTakingDamage=false; damageTime=0
            var tParryTiming;
            tParryTiming=3
            for(i=0;i<3;i+=1) //Equipment: Golden Shield
            {
              if global.equipClaire[i]=31
              {
                tParryTiming=4
                break;
              }
            }
            var tParryWindow;
            tParryWindow=instance_create(x,y,oClaireParryWindow); tParryWindow.decayTime=tParryTiming+1
            blockForceTime=tParryTiming
            //-----
            if lastGuardTime<20 {global.stJGame_C[0]-=350}
            else {global.stJGame_C[0]-=120}
            lastGuardTime=0
          }
          global.stJGame_C[0]-=5
          attackState=ACT_BLOCK
        }
        else if kActBPressed=0 and attackState=ACT_BLOCK {attackState=0}
      }
      else
      {
        blockForceTime-=1
        global.stJGame_C[0]-=5
        attackState=ACT_BLOCK
      }
    }
    else
    {
      if attackState=ACT_BLOCK {attackState=0}
    }
  }
}
//-------------------- Defender --------------------
if (global.activeCharacter=0 and global.activeAbility[0]=4) or (global.activeCharacter=1 and global.activeAbility[1]=4)
{
  if instance_exists(oTD_HUD)
  {
    if kActA and kActAPressed=1
    {
      if bTakingDamage=false and oTD_HUD.bCanBaseUpgrade=0
      {
        if oTD_HUD.bCanConstruct=1 //Place down turret
        {
          if global.hudDefend=0 //GROUND
          {
            if platformCharacterIs(ON_GROUND)
            {
              if oTD_HUD.tdStat_Resources>=scrTD_TowerStat(1,2)
              {
                oTD_HUD.tdStat_Resources-=scrTD_TowerStat(1,2)
                var tNewTurret;
                tNewTurret=instance_create(x,y,oTD_Turret)
                tNewTurret.image_xscale=image_xscale
                with (tNewTurret)
                {
                  scrTD_TowerStat(1,0)
                }
                var tEffect;
                tEffect=instance_create(x,y,oEffect)
                tEffect.sprite_index=sGroundDust; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
              }
            }
          }
          else if global.hudDefend=1 //FLOAT
          {
            if oTD_HUD.tdStat_Resources>=scrTD_TowerStat(2,2)
            {
              oTD_HUD.tdStat_Resources-=scrTD_TowerStat(2,2)
              var tNewTurret;
              tNewTurret=instance_create(x,y-26,oTD_Turret)
              with (tNewTurret)
              {
                scrTD_TowerStat(2,0)
                var tEffect;
                tEffect=instance_create(x,y,oEffect)
                tEffect.sprite_index=sRobotExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
              }
            }
          }
          else if global.hudDefend=2 //AIR
          {
            if platformCharacterIs(ON_GROUND)
            {
              if oTD_HUD.tdStat_Resources>=scrTD_TowerStat(3,2)
              {
                oTD_HUD.tdStat_Resources-=scrTD_TowerStat(3,2)
                var tNewTurret;
                tNewTurret=instance_create(x,y-26,oTD_Turret)
                with (tNewTurret)
                {
                  scrTD_TowerStat(3,0)
                  image_angle=90
                  var tEffect;
                  tEffect=instance_create(x,y,oEffect)
                  tEffect.sprite_index=sGroundDust; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
                }
              }
            }
          }
          else if global.hudDefend=3 //SHOCK
          {
            if oTD_HUD.tdStat_Resources>=scrTD_TowerStat(4,2)
            {
              oTD_HUD.tdStat_Resources-=scrTD_TowerStat(4,2)
              var tNewTurret;
              tNewTurret=instance_create(x,y-26,oTD_Turret)
              with (tNewTurret)
              {
                scrTD_TowerStat(4,0)
                var tEffect;
                tEffect=instance_create(x,y,oEffect)
                tEffect.sprite_index=sRobotExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
              }
            }
          }
          else if global.hudDefend=4 //MEGA
          {
            if platformCharacterIs(ON_GROUND)
            {
              if oTD_HUD.tdStat_Resources>=scrTD_TowerStat(5,2)
              {
                oTD_HUD.tdStat_Resources-=scrTD_TowerStat(5,2)
                var tNewTurret;
                tNewTurret=instance_create(x,y,oTD_Turret)
                with (tNewTurret)
                {
                  scrTD_TowerStat(5,0)
                  var tEffect;
                  tEffect=instance_create(x,y,oEffect)
                  tEffect.sprite_index=sGroundDust; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=2; tEffect.image_yscale=2
                }
              }
            }
          }
        }
        else if oTD_HUD.bCanConstruct=0
        {
          if oTD_HUD.bCanUpgrade=1 //Upgrade turret
          {
            with (oTD_HUD.turretID)
            {
              var tTypeChk,tCost;
              if type="GROUND" {tTypeChk=1}
              else if type="FLOAT" {tTypeChk=2}
              else if type="AIR" {tTypeChk=3}
              else if type="SHOCK" {tTypeChk=4}
              else if type="MEGA" {tTypeChk=5}
              tCost=scrTD_TowerStat(tTypeChk,3)
              if oTD_HUD.tdStat_Resources>=tCost
              {
                oTD_HUD.tdStat_Resources-=tCost
                scrTD_TowerStat(tTypeChk,1)
                var tEffect;
                tEffect=instance_create(x,bbox_top+(sprite_height/2),oEffect)
                tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=2; tEffect.image_yscale=2
              }
            }
          }
        }
      }
      else if oTD_HUD.bCanBaseUpgrade=1 //Recover 1 Stability
      {
        if oTD_HUD.tdStat_Stability<oTD_HUD.maxStability and oTD_HUD.tdStat_Resources>=oTD_HUD.recoverCost and oTD_HUD.repairCooldown=0
        {
          oTD_HUD.tdStat_Resources-=oTD_HUD.recoverCost
          oTD_HUD.tdStat_Stability+=1
          oTD_HUD.repairCooldown=150
          if oTD_HUD.recoverCost<1000 {oTD_HUD.recoverCost+=100}
          var tEffect;
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        }
      }
    }
    
    if kActB and kActBPressed=1 //Cycle forward through turrets
    {
      global.hudDefend+=1
      if global.hudDefend>=5 {global.hudDefend=0}
      with oAbilTurretNotice {instance_destroy()}
      instance_create(0,0,oAbilTurretNotice)
    }
    
    if kActC and kActCPressed=1
    {
      if oTD_HUD.bCanDeconstruct=1 and kUp //Deconstruct turret
      {
        with (oTD_HUD.turretID)
        {
          var tTypeChk,tReturn;
          if type="GROUND" {tTypeChk=1; tReturn=100}
          else if type="FLOAT" {tTypeChk=2; tReturn=120}
          else if type="AIR" {tTypeChk=3; tReturn=130}
          else if type="SHOCK" {tTypeChk=4; tReturn=140}
          else if type="MEGA" {tTypeChk=5; tReturn=250}
          while(turLevel>1)
          {
            turLevel-=1
            var tCost;
            tCost=scrTD_TowerStat(tTypeChk,3)
            tReturn+=tCost
          }
          tReturn=round(tReturn*0.75)
          oTD_HUD.tdStat_Resources+=tReturn
          var tEffect;
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sBombExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
          instance_destroy()
        }
      }
      else //Cycle back through turrets
      {
        global.hudDefend-=1
        if global.hudDefend<=-1 {global.hudDefend=4}
        with oAbilTurretNotice {instance_destroy()}
        instance_create(0,0,oAbilTurretNotice)
      }
    }
  }
}
else if global.activeCharacter=2 and global.jeremyCanAtk=1 //---------------------------------------- Jeremy ----------------------------------------
{
  if kActA and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
  {
    if kUp //Homing Missile
    {
      if kActAPressed=1 and mechMissileUses>0
      {
        if global.location=110 {playSound(global.snd_BombLaunch,0,0.79,28000)}
        else {playSound(global.snd_BombLaunch,0,0.85,39000)}
        mechMissileUses-=1
        var playerAttack;
        playerAttack=instance_create(x-(10*image_xscale),y-48,oJMechMissile)
        if image_xscale=1 {playerAttack.direction=45; playerAttack.image_angle=45}
        else if image_xscale=-1 {playerAttack.direction=135; playerAttack.image_angle=135}
      }
    }
    else
    {
      if mechFireRate<3 //Machine Gun
      {
        if global.location=110 {playSound(global.snd_SniperShot,0,0.88,12000)}
        else {playSound(global.snd_SniperShot,0,0.95,17000)}
        var playerAttack,tShotDirRan;
        tShotDirRan=random_range(-2,2)
        playerAttack=instance_create(x+(17*image_xscale),y-33,oJMechShotA)
        if image_xscale=1 {playerAttack.direction=tShotDirRan; playerAttack.image_angle=tShotDirRan}
        else if image_xscale=-1 {playerAttack.direction=180+tShotDirRan; playerAttack.image_angle=180+tShotDirRan}
        mechFireRate=6
      }
    }
  }
  else if kActB and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
  {
    if kUp //Laser
    {
      if kActBPressed=1 and mechLaserEnergy>=mechLaserMax/2
      {
        if global.location=110 {playSound(global.snd_LaserA,0,0.88,14000)}
        else {playSound(global.snd_LaserA,0,0.95,1)}
        mechLaserEnergy-=mechLaserMax/2
        var playerAttack;
        playerAttack=instance_create(x-(10*image_xscale),y-48,oJMechLaser)
        if image_xscale=-1 {playerAttack.direction=180; playerAttack.image_angle=180}
      }
    }
    else
    {
      if mechFireRate<5 //Flame Thrower
      {
        if oGame.time mod 2=0
        {
          if global.location=110 {playSound(global.snd_Flame1,0,0.83,42000)}
          else {playSound(global.snd_Flame1,0,0.9,56000)}
        }
        var playerAttack,tFlameDirRan;
        tFlameDirRan=random_range(-2,2)
        playerAttack=instance_create(x+(17*image_xscale),y-33,oJMechFlame)
        if image_xscale=1 {playerAttack.direction=tFlameDirRan; playerAttack.image_angle=tFlameDirRan}
        else if image_xscale=-1 {playerAttack.direction=180+tFlameDirRan; playerAttack.image_angle=180+tFlameDirRan}
        mechFireRate=6
      }
    }
  }
  
  if kActC and kActCPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
  {
    if mechShieldUses>0 //Shield
    {
      if global.location=110 {playSound(global.snd_NewAbilitySet,0,0.85,10000)}
      else {playSound(global.snd_NewAbilitySet,0,0.92,14000)}
      mechShieldUses-=1
      var playerAttack;
      playerAttack=instance_create(x+32,y-26,oJMechShield)
      playerAttack=instance_create(x-32,y-26,oJMechShield); playerAttack.image_xscale=-1
    }
  }
}
else if global.activeCharacter=4 and global.jeremyCanAtk=1 //---------------------------------------- Jeremy ----------------------------------------
{
  bCanUseAllAttacks=1
  if room=rDistFinal_Round3 {bCanUseAllAttacks=0}
  
  if lastDirPress>0 //Reset input string
  {
    lastDirPress-=1
    if lastDirPress=0
    {
      dirPressIter=0
      for(i=0;i<11;i+=1)
      {
        myDirPress[i]=0
      }
      jeremySpecMove=0
    }
  }
  
  if kLeftPressed=1 or kRightPressed=1 or kUpPressed=1 or kDownPressed=1 //Check when button is pressed
  {
    checkComboString(0)
  }
  
  //Energy
  if jeremySuperEnergy<jeremySuperMax
  {
    jeremySuperEnergy+=1
  }
  
  if kActA and kActAPressed=1 and bTakingDamage=false and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=LOOKING_UP)
  {
    if attackState=0
    {
      checkComboString(1)
      if jeremySpecMove=1 and jeremySuperEnergy<300 {jeremySpecMove=0}
      
      if jeremySpecMove=0
      {
        if platformCharacterIs(ON_GROUND) and kUp and bCanUseAllAttacks=1 //Uppercut
        {
          playSound(global.snd_PlayerStrAtk[0],0,1,18000+random(5000))
          var playerAttack;
          playerAttack=instance_create(x-(5*image_xscale),y-57,oJF_Atk_Uppercut); playerAttack.image_xscale=image_xscale
          endAbilUse(ACT_FIRE_UP,18,0,(2/atkSpdJeremy)-0.02)
        }
        else //Normal Punch
        {
          jeremyAct=1
          playSound(global.snd_PlayerStrAtk[0],0,1,18000+random(5000))
          var playerAttack;
          playerAttack=instance_create(x+(17*image_xscale),y-49,oJF_Atk_PunchA); playerAttack.image_xscale=image_xscale
          endAbilUse(ACT_ATK,atkSpdJeremy,0,(2/atkSpdJeremy)-0.02)
        }
      }
      else if jeremySpecMove=1 and bCanUseAllAttacks=1 //Fireball
      {
        playSound(global.snd_MMBuster[2],0,1,42000+random(6000))
        jeremySuperEnergy-=300
        var playerAttack;
        playerAttack=instance_create(x+(19*image_xscale),y-47,oJF_Atk_Fireball); playerAttack.myDir=image_xscale
        endAbilUse(ACT_FIRE,atkSpdJeremy,0,(2/atkSpdJeremy)-0.02)
      }
      jeremySpecMove=0
    }
  }
  else if kActB and kActBPressed=1 and bTakingDamage=false and bCanUseAllAttacks=1 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=LOOKING_UP)
  {
    if attackState=0
    {
      if platformCharacterIs(ON_GROUND) //Ground Kick
      {
        jeremyAct=2
        playSound(global.snd_PlayerStrAtk[1],0,1,18000+random(5000))
        var playerAttack;
        playerAttack=instance_create(x+(21*image_xscale),y-40,oJF_Atk_KickA); playerAttack.image_xscale=image_xscale
        endAbilUse(ACT_ATK,atkSpdJeremy,0,(2/atkSpdJeremy)-0.02)
      }
      else
      {
        if kDown //Corkscrew Kick
        {
          playSound(global.snd_PlayerStrAtk[1],0,1,18000+random(5000))
          var playerAttack;
          playerAttack=instance_create(x,y,oJF_Atk_CorkscrewKick); playerAttack.image_xscale=image_xscale
          endAbilUse(ACT_FIRE_DOWN,100,0,(2/atkSpdJeremy)-0.02)
        }
        else //Air Kick
        {
          jeremyAct=3
          playSound(global.snd_PlayerStrAtk[1],0,1,18000+random(5000))
          var playerAttack;
          playerAttack=instance_create(x+(20*image_xscale),y-46,oJF_Atk_KickB); playerAttack.image_xscale=image_xscale
          endAbilUse(ACT_ATK,atkSpdJeremy,0,(2/atkSpdJeremy)-0.02)
        }
      }
    }
  }
}

if !kActA
{
  attackCharge=0
  if attackState=ACT_MORPHBALL {specAttackChargeB=0}
}
if !kActB {specAttackChargeA=0}
if !kActC
{
  if attackState!=ACT_MORPHBALL {specAttackChargeB=0}
}
