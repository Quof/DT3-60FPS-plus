#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Integrated Visualization System (IVS)
menuOpen=false

hitComboAlpha=0 //combo counter alpha
hitComboFadeTime=0 //combo fade/reset time
killChainAlpha=0 //kill chain alpha
killChainFadeTime=0 //kill chain fade/reset time
killChainText=0

background_index[7]=backStatic
background_alpha[7]=0.07
background_foreground[7]=true
background_hspeed[7]=31
background_vspeed[7]=21

busterWarnColor=make_color_rgb(224,64,0)
airdashFrm=0
dashMeterFrm=0
airDashScl=1
doubleJumpScl=1
awesomeColorA=make_color_rgb(255,248,155)
awesomeColorB=make_color_rgb(16,8,8)

dragoonBossCheck=0
enemyCheckID=0
shooterLevel="1-1"

curAwesome=global.awesomePoints
curHeart=global.pLife
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oKeyCodes.kCodePressed[12]=1 and global.gameOver=false
  {
    if global.canPause=1
    {
      io_clear()
      resetKeyCodes()
      playSound(global.snd_MenuOpen,0,1,1)
      global.gamePaused=true
      menuOpen=true
      oPlayer1.image_speed=0
      if global.gameProgress>=5350 and global.gameProgress<=5490 //Escape sequence at the end
      {
        instance_create(0,0,oEscapePause)
      }
      else //Normal
      {
        instance_create(0,0,oPauseMenu)
      }
    }
    else
    {
      if global.gameProgress<=5340 and global.gameProgress<=5490 //Do not show message during ending
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,60,"","The Pause Menu has been disabled.",7,1,oMessagePerson,0)
        newMessage.fadingTime=50
      }
    }
  }

  if oPlayer1.hitCombo>0 //Hit Combo fade
  {
    hitComboFadeTime-=1
    if hitComboFadeTime<=25
      hitComboAlpha-=0.04
    if hitComboFadeTime<=0
    {
      if oPlayer1.hitCombo>=3
      {
        if global.optShowCombatAward=1
        {
          var tTotalDamage;
          tTotalDamage=instance_create(0,0,oTotalComboDamage)
          if oPlayer1.mechComboDamage>oPlayer1.comboDamage {tTotalDamage.damageTotal=oPlayer1.mechComboDamage}
          else {tTotalDamage.damageTotal=oPlayer1.comboDamage}
        }
        if oPlayer1.comboDamage>global.recComboDamage {global.recComboDamage=oPlayer1.comboDamage}
        var tAweHitMult;
        if oPlayer1.hitCombo<=9 {tAweHitMult=10}
        else if oPlayer1.hitCombo>=10 and oPlayer1.hitCombo<=24 {tAweHitMult=20}
        else if oPlayer1.hitCombo>=25 and oPlayer1.hitCombo<=34 {tAweHitMult=30}
        else if oPlayer1.hitCombo>=35 and oPlayer1.hitCombo<=49 {tAweHitMult=40}
        else if oPlayer1.hitCombo>=50 and oPlayer1.hitCombo<=64 {tAweHitMult=50}
        else if oPlayer1.hitCombo>=65 and oPlayer1.hitCombo<=79 {tAweHitMult=60}
        else if oPlayer1.hitCombo>=80 and oPlayer1.hitCombo<=99 {tAweHitMult=70}
        else if oPlayer1.hitCombo>=100 and oPlayer1.hitCombo<=129 {tAweHitMult=80}
        else if oPlayer1.hitCombo>=130 and oPlayer1.hitCombo<=159 {tAweHitMult=90}
        else if oPlayer1.hitCombo>=160 and oPlayer1.hitCombo<=199 {tAweHitMult=100}
        else if oPlayer1.hitCombo>=200 and oPlayer1.hitCombo<=499 {tAweHitMult=120}
        else if oPlayer1.hitCombo>=500 {tAweHitMult=200}
        awardAwesome(oPlayer1.hitCombo*tAweHitMult)
      }
      oPlayer1.mechComboDamage=0
      oPlayer1.comboDamage=0
      oPlayer1.hitCombo=0
    }
  }
  if oPlayer1.killChain>0 //Kill Chain fade
  {
    killChainFadeTime-=1
    if killChainFadeTime<=25
      killChainAlpha-=0.04
    if killChainFadeTime<=0
      oPlayer1.killChain=0
  }

  if global.bShooter=1
  {
    oPlayer1.x=-128
    oPlayer1.y=-128
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  //Display low health warn --------------------------------------------------
  if oPlayer1.life<=4 and global.optLowHealthWarn=1 and global.gamePaused=false
    background_visible[7]=true
  else
  {
    if !instance_exists(oGameOver)
      background_visible[7]=false
  }

  if global.bShooter=1 //Show this during shooter segment even if HUD is off
  {
    draw_set_alpha(1)
    draw_set_color(make_color_rgb(182,182,182))
    draw_rectangle(0,0,479,44,0)
    draw_set_color(make_color_rgb(78,78,78))
    draw_rectangle(0,0,479,44,1)
  }

  if global.optShowHUD=1
  {
    //Display health track --------------------------------------------------
    curHeart=numRollValue(curHeart,oPlayer1.life,1)
    playerHeartDisplay()

    if global.bShooter=0
    {
      //Display air meter --------------------------------------------------
      if global.pCurrBreath<global.pBreathMax
      {
        var airTrack,cl_back,cl_b1,cl_b2,cl_fill,tSrnX,tSrnY;
        tSrnX=view_xview[0]+2
        tSrnY=view_yview[0]+88
        cl_back=make_color_rgb(40,56,32)
        cl_b1=make_color_rgb(40,48,128)
        cl_b2=make_color_rgb(16,22,88)
        cl_fill=make_color_rgb(24,161,249)

        draw_set_alpha(1)
        draw_set_color(cl_back)
        draw_rectangle(tSrnX,tSrnY,tSrnX+7,tSrnY+103,0)
        draw_set_color(cl_b1)
        draw_rectangle(tSrnX,tSrnY,tSrnX+7,tSrnY+103,1)
        draw_set_color(cl_b2)
        draw_rectangle(tSrnX+1,tSrnY+1,tSrnX+6,tSrnY+102,1)
        draw_set_color(cl_fill)
        airTrack=(global.pCurrBreath/global.pBreathMax)*100
        draw_rectangle(tSrnX+2,tSrnY+101,tSrnX+5,tSrnY+101-airTrack,0)

        if global.pCurrBreath<=180 //Countdown over player
        {
          var tNumImg;
          if global.pCurrBreath>=151 and global.pCurrBreath<=180
            tNumImg=5
          else if global.pCurrBreath>=121 and global.pCurrBreath<=150
            tNumImg=4
          else if global.pCurrBreath>=91 and global.pCurrBreath<=120
            tNumImg=3
          else if global.pCurrBreath>=61 and global.pCurrBreath<=90
            tNumImg=2
          else if global.pCurrBreath>=31 and global.pCurrBreath<=60
            tNumImg=1
          else if global.pCurrBreath>=0 and global.pCurrBreath<=30
            tNumImg=0
          draw_sprite(sDrownCountdown,tNumImg,oPlayer1.x,oPlayer1.y-72)
        }
      }

      //Display dash meter --------------------------------------------------
      if global.hasShoes[2]=2
      {
        draw_sprite(sHUD_DashMeterBack,0,view_xview[0]+12,view_yview[0]+48)

        var dashTrack;
        dashTrack=(oPlayer1.dashEnergy/oPlayer1.dashMeterMax)*100
        if dashTrack>=31 {dashMeterFrm=0} //Flash meter when low
        else
        {
          if oGame.time mod 4=0
          {
            if dashMeterFrm=0 {dashMeterFrm=1}
            else {dashMeterFrm=0}
          }
        }
        draw_sprite_ext(sHUD_DashTrack,dashMeterFrm,view_xview[0]+12,view_yview[0]+48,dashTrack,1,0,c_white,1)

        if dashMeterFrm=0 {draw_sprite(sHUD_DashMeterFront,0,view_xview[0]+4,view_yview[0]+44)}
        else {draw_sprite_ext(sHUD_DashMeterFront,0,view_xview[0]+4,view_yview[0]+44,1,1,0,c_maroon,1)}

        for(i=0;i<5;i+=1) //Draw dash meter bars
        {
          if oPlayer1.dashEnergy>=2000*(i+1)
            draw_sprite(sHUD_DashBar,dashMeterFrm,view_xview[0]+13+(i*20),view_yview[0]+48)
        }
      }

      //Display air dash icon --------------------------------------------------
      if global.optCentralizeHUD=0
      {
        if airDashScl>1 {airDashScl-=0.2}
        if oPlayer1.canAirDash=1 and global.hasShoes[3]=2
        {
          airdashFrm+=0.2
          draw_sprite_ext(sHUD_DashIcon,airdashFrm,view_xview[0]+130,view_yview[0]+52,airDashScl,airDashScl,0,c_white,1)
        }

        //Display double jump icon --------------------------------------------------
        if doubleJumpScl>1 {doubleJumpScl-=0.2}
        if global.canDoubleJump=2 and oPlayer1.doubleJumpCheck=1
        {
          draw_sprite_ext(sHUD_DoubleJumpIcon,0,view_xview[0]+152,view_yview[0]+52,doubleJumpScl,doubleJumpScl,0,c_white,1)
        }
      }
      else
      {
        if oPlayer1.canAirDash=1 and global.hasShoes[3]=2
        {
          airdashFrm+=0.2
          draw_sprite(sHUD_DashIcon,airdashFrm,oPlayer1.x-11,oPlayer1.y+14)
        }
        if global.canDoubleJump=2 and oPlayer1.doubleJumpCheck=1
        {
          draw_sprite(sHUD_DoubleJumpIcon,0,oPlayer1.x+11,oPlayer1.y+14)
        }
      }

      //Display status effects --------------------------------------------------
      draw_set_color(c_black)
      draw_set_font(fnt_EnemyName)
      draw_set_halign(fa_right)
      draw_set_alpha(1)
      if oPlayer1.charSwapRecover>0 //Character Swap
      {
        draw_sprite(sHUD_StatusEffect,0,view_xview[0]+12,view_yview[0]+79)
        draw_text(view_xview[0]+19,view_yview[0]+74,round(oPlayer1.charSwapRecover))
      }
      if oPlayer1.mobilityDisable>0 //Blast Off
      {
        draw_sprite(sHUD_StatusEffect,1,view_xview[0]+32,view_yview[0]+79)
        draw_text(view_xview[0]+39,view_yview[0]+74,round(oPlayer1.mobilityDisable))
      }

      //Show which character has which ability set active --------------------------------------------------
      if global.optSwapType>=0 and global.optSwapType<=2
      {
        if (global.activeAbility[0]=1 or global.activeAbility[0]=2) and (global.activeAbility[1]=1 or global.activeAbility[1]=2) and global.bTowerDefense=0 and global.canCharSwap=2 and global.gameProgress>=1990
        {
          draw_sprite(sHUD_JC_Ind,0,view_xview[0]+240,view_yview[0]+13)
          if global.activeAbility[0]=1 {draw_sprite(sHUD_Abil_Ind,0,view_xview[0]+228,view_yview[0]+32)}
          else if global.activeAbility[0]=2 {draw_sprite(sHUD_Abil_Ind,1,view_xview[0]+228,view_yview[0]+32)}

          if global.activeAbility[1]=1 {draw_sprite(sHUD_Abil_Ind,2,view_xview[0]+250,view_yview[0]+32)}
          else if global.activeAbility[1]=2 {draw_sprite(sHUD_Abil_Ind,3,view_xview[0]+250,view_yview[0]+32)}
        }
      }
      else //Hold+Direction
      {
        if global.hasAbilToken[1]>=2 or global.hasAbilToken[2]>=2 or global.hasAbilToken[3]>=2 or global.hasAbilToken[4]>=2
        {
          draw_sprite(sHUD_Swap_Hold,0,view_xview[0]+240,view_yview[0]+28)
          if global.hasAbilToken[1]>=2 {draw_sprite(sHUD_Abil_Ind,0,view_xview[0]+240,view_yview[0]+10)}
          if global.hasAbilToken[2]>=2 {draw_sprite(sHUD_Abil_Ind,2,view_xview[0]+240,view_yview[0]+48)}
          if global.hasAbilToken[3]>=2 {draw_sprite(sHUD_Abil_Ind,1,view_xview[0]+221,view_yview[0]+29)}
          if global.hasAbilToken[4]>=2 {draw_sprite(sHUD_Abil_Ind,3,view_xview[0]+259,view_yview[0]+29)}
        }
      }

      //Display ability set stats --------------------------------------------------
      if global.activeCharacter=0
      {
        if global.activeAbility[0]=1 //Link Set ----------
        {
          draw_sprite(sHUD_LinkSet1,0,view_xview[0]+165,view_yview[0]+5)
          draw_set_color(make_color_rgb(32,192,40))
          var tBombEn;
          tBombEn=(global.hudLink_BombEn[0]/(120-round(global.skillTree[1]*7.5)-oPlayer1.equipValA))*23
          draw_rectangle(view_xview[0]+169,view_yview[0]+44,view_xview[0]+174,view_yview[0]+44-tBombEn,0)
          draw_set_color(make_color_rgb(248,248,248))
          draw_rectangle(view_xview[0]+169,view_yview[0]+44-tBombEn,view_xview[0]+174,view_yview[0]+44-tBombEn,1)
          draw_set_font(fnt_HUDnum)
          draw_set_halign(fa_middle)
          textDropShadow(global.hudLink_Arrows[0],view_xview[0]+192,view_yview[0]+17,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
          textDropShadow(global.hudLink_Arrows[1],view_xview[0]+192,view_yview[0]+32,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)

          if global.bNightmareMode=1 //Nightmare Mode - Display Sword Wave meter
          {
            if oPlayer1.life=oPlayer1.maxLife
            {
              draw_sprite(sHUD_LinkSet2,0,view_xview[0]+203,view_yview[0]+13)
              if oPlayer1.swordWaveCheck>55
              {
                var tSwordWv;
                tSwordWv=((oPlayer1.swordWaveCheck-50)/50)*23
                draw_set_color(make_color_rgb(32,192,40))
                draw_rectangle(view_xview[0]+208,view_yview[0]+44,view_xview[0]+213,view_yview[0]+44-tSwordWv,0)
              }
            }
          }
        }
        else if global.activeAbility[0]=2 //Mega Man Set ----------
        {
          draw_sprite(sHUD_MMXSet1,0,view_xview[0]+165,view_yview[0]+5)

          if global.hudMega_BusterEn[0]>0
            draw_sprite_general(sHUD_MMXSet2,0,0,0,6,global.hudMega_BusterEn[0]-1,view_xview[0]+174,view_yview[0]+39,1,1,180,c_white,c_white,c_white,c_white,1)
          if global.hudMega_ShotIceEn[0]>0
            draw_sprite_general(sHUD_MMXSet2,1,0,0,6,global.hudMega_ShotIceEn[0]-1,view_xview[0]+190,view_yview[0]+39,1,1,180,c_white,c_white,c_white,c_white,1)
          if global.hudMega_GravityEn[0]>0
            draw_sprite_general(sHUD_MMXSet2,2,0,0,6,global.hudMega_GravityEn[0]-1,view_xview[0]+206,view_yview[0]+39,1,1,180,c_white,c_white,c_white,c_white,1)

          if global.bNightmareMode=1 //Nightmare Mode - Display stored charge shots meter
          {
            draw_sprite(sHUD_MMXSet3,0,view_xview[0]+156,view_yview[0]+5)
            if oPlayer1.chargeShotsStored>=1
            {
              for(i=0;i<oPlayer1.chargeShotsStored;i+=1)
              {
                draw_sprite(sHUD_MMXSet4,0,view_xview[0]+159,view_yview[0]+20-(i*6))
              }
            }
          }
        }
      }
      else if global.activeCharacter=1
      {
        if global.activeAbility[1]=1 //Belmont Set ----------
        {
          draw_sprite(sHUD_BelmontSet1,0,view_xview[0]+165,view_yview[0]+5)
          draw_set_font(fnt_HUDnum)
          draw_set_halign(fa_middle)
          draw_set_color(make_color_rgb(255,248,155))
          draw_text(view_xview[0]+179,view_yview[0]+5,global.hudBelmont_WeaponEn[0])

          if global.bNightmareMode=1 //Nightmare Mode - Display Dagger Spam meter
          {
            draw_sprite(sHUD_LinkSet2,0,view_xview[0]+198,view_yview[0]+11)
            if oPlayer1.daggerSpamCheck>60
            {
              var tSwordWv;
              tSwordWv=((oPlayer1.daggerSpamCheck-60)/40)*23
              draw_set_color(make_color_rgb(32,192,40))
              draw_rectangle(view_xview[0]+203,view_yview[0]+42,view_xview[0]+208,view_yview[0]+42-tSwordWv,0)
            }
          }
        }
        else if global.activeAbility[1]=2 //Samus Set ----------
        {
          draw_sprite(sHUD_SamusSet1,0,view_xview[0]+165,view_yview[0]+5)
          draw_set_font(fnt_HUDnum)
          draw_set_halign(fa_middle)
          draw_set_color(make_color_rgb(255,248,155))
          draw_text(view_xview[0]+177,view_yview[0]+20,global.hudSamus_Missiles[0])
          if global.hudSamus_Bombs[0]<3 {draw_sprite(sSamusBomb,3,view_xview[0]+169,view_yview[0]+40)}
          if global.hudSamus_Bombs[0]<2 {draw_sprite(sSamusBomb,3,view_xview[0]+178,view_yview[0]+40)}
          if global.hudSamus_Bombs[0]<1 {draw_sprite(sSamusBomb,3,view_xview[0]+187,view_yview[0]+40)}
          //light up bomb HUD when multiple bombs can be dropped when going into morph mode

          equipValC=45
          if oPlayer1.attackCharge>=25 or oPlayer1.specAttackChargeA>=25 or oPlayer1.specAttackChargeB>=25
          for(i=0;i<3;i+=1)
          {
            if global.equipClaire[i]=32 //Equipment: Morph Mortar
            {
              equipValC=25
              break;
            }
          }
          if oPlayer1.attackCharge>=equipValC or oPlayer1.specAttackChargeA>=equipValC or oPlayer1.specAttackChargeB>=equipValC
          {
            draw_sprite(sSamusBomb,oGame.time,view_xview[0]+169,view_yview[0]+40)
            draw_sprite(sSamusBomb,oGame.time+1,view_xview[0]+178,view_yview[0]+40)
            draw_sprite(sSamusBomb,oGame.time+2,view_xview[0]+187,view_yview[0]+40)
          }
          var tCannonEn;
          tCannonEn=(global.hudSamus_CannonEn[0]/global.hudSamus_CannonEn[1])*33
          if tCannonEn>33 {tCannonEn=33}
          if global.hudSamus_CannonEn[0]>0
          {
            draw_sprite_general(sHUD_SamusSet2,0,0,0,6,tCannonEn,view_xview[0]+200,view_yview[0]+40,1,1,180,c_white,c_white,c_white,c_white,1)
          }

          if global.bNightmareMode=1 //Nightmare Mode - Display Power Bomb meter
          {
            draw_sprite(sHUD_LinkSet2,0,view_xview[0]+203,view_yview[0]+4)
            if oPlayer1.powerBombCheck>0
            {
              var tSwordWv;
              tSwordWv=((oPlayer1.powerBombCheck)/100)*23
              draw_set_color(make_color_rgb(32,192,40))
              draw_rectangle(view_xview[0]+208,view_yview[0]+35,view_xview[0]+213,view_yview[0]+35-tSwordWv,0)
            }
          }
        }
      }
      else if global.activeCharacter=2 //----- JEREMY MECH HUD -----
      {
        var tMechFuelX,tMechFuelY,tFuelGauge,tLaserGauge;
        tMechFuelX=view_xview[0]+9; tMechFuelY=view_yview[0]+43
        draw_sprite(sJeremyMechFuelA,0,tMechFuelX,tMechFuelY)
        tFuelGauge=(oPlayer1.mechFuel/oPlayer1.mechMaxFuel)*50
        draw_sprite_ext(sJeremyMechFuelB,0,tMechFuelX+71,tMechFuelY+1,tFuelGauge,1,0,c_white,1)
        if oPlayer1.mechShieldUses>=1
        {
          for(i=0;i<oPlayer1.mechShieldUses;i+=1)
          {
            draw_sprite(sJeremyMechHudShield,0,tMechFuelX+125+(i*12),tMechFuelY+1)
          }
        }
        if oPlayer1.mechMissileUses>=1
        {
          for(i=0;i<oPlayer1.mechMissileUses;i+=1)
          {
            draw_sprite(sJeremyMechHudMissile,0,tMechFuelX+151+(i*7),tMechFuelY)
          }
        }
        tLaserGauge=(oPlayer1.mechLaserEnergy/oPlayer1.mechLaserMax)*100
        draw_sprite_ext(sJeremyMechHudLaser,0,tMechFuelX+21,tMechFuelY+13,tLaserGauge,1,0,c_white,1)
      }
      else if global.activeCharacter=3 //----- CHAO HUD -----
      {
        var tChaoGrazeX,tChaoGrazeY;
        tChaoGrazeX=view_xview[0]+324; tChaoGrazeY=view_yview[0]+17
        draw_sprite(sHUD_ChaoMeter,0,tChaoGrazeX,tChaoGrazeY)
        draw_sprite_ext(sHUD_ChaoBar,0,tChaoGrazeX+10,tChaoGrazeY,oIdentifier.grazePercent,1,0,c_white,1)
      }

      //---------- Game Set ----------
      if (global.activeCharacter=0 and global.activeAbility[0]=3) or (global.activeCharacter=1 and global.activeAbility[1]=3)
      {
        draw_sprite(sHUD_GameSet,0,view_xview[0]+186,view_yview[0]+2)
        draw_set_font(fnt_EnemyName)
        draw_set_halign(fa_middle)
        draw_set_alpha(1)
        //Weapon Energy
        textDropShadow(global.hudGame_WeaponEn[0],view_xview[0]+256,view_yview[0]+44,make_color_rgb(224,204,167),make_color_rgb(44,22,0),3)
        //Gate 6 Level
        textDropShadow(global.stJGame_C[1],view_xview[0]+225,view_yview[0]+44,make_color_rgb(224,204,167),make_color_rgb(44,22,0),3)
        if global.stJGame_C[1]<64
        {
          var tExpMeter;
          tExpMeter=abs(global.stJGame_C[2]/global.stCGame_C[0])*100
          draw_sprite_ext(sHUD_GameMeterA,0,view_xview[0]+190,view_yview[0]+26,tExpMeter,1,0,c_white,1)
        }

        if global.stJGame_C[0]<=999 or global.stJGame_C[0]>=4000
        {
          var tBlockNRGJ,tMeterColor;
          if global.stJGame_C[0]>0 and global.stJGame_C[0]<2000 //shield normal
          {
            tMeterColor=c_white
            tBlockNRGJ=abs(global.stJGame_C[0]/1000)*49
          }
          else if global.stJGame_C[0]>4000 //parry state
          {
            tMeterColor=make_color_rgb(random(255),random(255),random(255))
            tBlockNRGJ=(abs(global.stJGame_C[0]-4000)/1000)*49
          }
          else //shield broken
          {
            tMeterColor=make_color_rgb(208,64,32)
            tBlockNRGJ=(abs(global.stJGame_C[0]+1000)/1000)*49
          }
          draw_set_color(c_ltgray)
          draw_rectangle(oPlayer1.x-25,oPlayer1.y+4,oPlayer1.x+25,oPlayer1.y+9,0)
          draw_set_color(c_black)
          draw_rectangle(oPlayer1.x-25,oPlayer1.y+4,oPlayer1.x+25,oPlayer1.y+9,1)
          draw_sprite_ext(sHUD_GameMeterA,0,oPlayer1.x-24,oPlayer1.y+5,tBlockNRGJ,1,0,tMeterColor,1)
        }
      }

      //---------- Defender Set ----------
      if (global.activeCharacter=0 and global.activeAbility[0]=4) or (global.activeCharacter=1 and global.activeAbility[1]=4)
      {
        if instance_exists(oTD_HUD)
        {
          var tHUD_DefendX,tHUD_DefendY;
          tHUD_DefendX=view_xview[0]+242
          tHUD_DefendY=view_yview[0]+24
          draw_sprite(sHUD_DefenderSet,0,tHUD_DefendX,tHUD_DefendY)
          if global.hudDefend=0 {draw_sprite_ext(sHUD_DefenderA,4,tHUD_DefendX-52,tHUD_DefendY,1,1,0,c_gray,1)} //Previous turret
          else {draw_sprite_ext(sHUD_DefenderA,global.hudDefend-1,tHUD_DefendX-52,tHUD_DefendY,1,1,0,c_gray,1)}

          if global.hudDefend=0 or global.hudDefend=2 or global.hudDefend=4
          {
            with oPlayer1
            {
              if !platformCharacterIs(ON_GROUND)
              {
                oTD_HUD.bCanConstruct=0
              }
            }
          }

          if oTD_HUD.bCanConstruct=1 {draw_sprite(sHUD_DefenderA,global.hudDefend,tHUD_DefendX,tHUD_DefendY)} //Current turret
          else {draw_sprite_ext(sHUD_DefenderA,global.hudDefend,tHUD_DefendX,tHUD_DefendY,1,1,0,c_gray,1)}

          if global.hudDefend=4 {draw_sprite_ext(sHUD_DefenderA,0,tHUD_DefendX+52,tHUD_DefendY,1,1,0,c_gray,1)} //Next turret
          else {draw_sprite_ext(sHUD_DefenderA,global.hudDefend+1,tHUD_DefendX+52,tHUD_DefendY,1,1,0,c_gray,1)}
          var deployCost;
          if global.hudDefend=0 {deployCost=scrTD_TowerStat(1,2)}
          else if global.hudDefend=1 {deployCost=scrTD_TowerStat(2,2)}
          else if global.hudDefend=2 {deployCost=scrTD_TowerStat(3,2)}
          else if global.hudDefend=3 {deployCost=scrTD_TowerStat(4,2)}
          else if global.hudDefend=4 {deployCost=scrTD_TowerStat(5,2)}
          draw_set_alpha(1)
          draw_set_color(make_color_rgb(64,40,24))
          draw_set_font(fnt_PauseMenuText)
          draw_set_halign(fa_center)
          draw_text(tHUD_DefendX,tHUD_DefendY+11,deployCost)
        }
      }
    }
    else //---------- Dragoon segment ----------
    {
      if instance_exists(oDragoonShip)
      {
        draw_set_color(awesomeColorA)
        draw_set_alpha(0.3)
        if global.activeCharacter=0 {weaponSelX=194}
        else {weaponSelX=142}
        draw_rectangle(weaponSelX,3,weaponSelX+51,32,0)
        draw_set_alpha(1)
        draw_rectangle(weaponSelX,3,weaponSelX+51,32,1)
        draw_sprite(sDragHUD_Char,0,view_xview[0]+194,view_yview[0]+16) //Character HUD
        for(i=0;i<4;i+=1) //Assist Slots
        {
          draw_sprite(sDragHUD_Assist,0,view_xview[0]+264+(i*22),view_yview[0]+2)
        }
        if oDragoonShip.multiple>0
        {
          for(i=0;i<oDragoonShip.multiple;i+=1)
          {
            draw_sprite(sDrag_AssistIcons,oDragoonShip.shipAssist[i].type-1,view_xview[0]+274+(i*22),view_yview[0]+12)
          }
        }
        draw_sprite(sDragSuckMeter,0,view_xview[0]+141,view_yview[0]+34) //Suck meter
        var tSuckMet;
        tSuckMet=(oDragoonShip.suckTime/oDragoonShip.suckMax)*45
        draw_sprite_ext(sDragSuckTrack,0,view_xview[0]+206,view_yview[0]+35,tSuckMet,1,0,c_white,1)
        draw_sprite(sDrag_WepIcons,oDragoonShip.charJerryShot,view_xview[0]+206,view_yview[0]+16) //Jerry Weapon
        if oDragoonShip.shotHP_Jerry>=1 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+214,view_yview[0]+26)}
        if oDragoonShip.shotHP_Jerry>=2 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+210,view_yview[0]+29)}
        if oDragoonShip.shotHP_Jerry>=3 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+205,view_yview[0]+29)}
        draw_sprite(sDrag_WepIcons,oDragoonShip.charClaireShot,view_xview[0]+182,view_yview[0]+16) //Claire Weapon
        if oDragoonShip.shotHP_Claire>=1 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+174,view_yview[0]+26)}
        if oDragoonShip.shotHP_Claire>=2 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+178,view_yview[0]+29)}
        if oDragoonShip.shotHP_Claire>=3 {draw_sprite(sDragHUD_ShotHP,0,view_xview[0]+183,view_yview[0]+29)}
        if dragoonBossCheck=1
        {
          if instance_exists(enemyCheckID)
          {
            draw_sprite(sDragBossMeter,0,view_xview[0]+264,view_yview[0]+34) //Boss meter
            var tBossMet;
            tBossMet=(enemyCheckID.life/enemyCheckID.maxLife)*120
            draw_sprite_ext(sDragBossTrack,0,view_xview[0]+329,view_yview[0]+35,tBossMet,1,0,c_white,1)
          }
        }
        draw_sprite(sDragHUD_EnemyLvl,0,view_xview[0]+353,view_yview[0]+2) //Enemy Level
        draw_sprite(sDragHUD_Section,0,view_xview[0]+353,view_yview[0]+11) //Section
        draw_set_alpha(1)
        draw_set_font(fnt_NES)
        draw_set_halign(fa_left)
        textDropShadow(global.shooterDifficulty,view_xview[0]+410,view_yview[0]+3,awesomeColorA,awesomeColorB,1)
        textDropShadow(shooterLevel,view_xview[0]+410,view_yview[0]+12,awesomeColorA,awesomeColorB,1)
      }
    }

    if global.optShowScore=1 //Display awesome score
    {
      draw_set_alpha(1)
      draw_set_font(fnt_NES)
      draw_set_halign(fa_left)
      curAwesome=numRollValue(curAwesome,global.awesomePoints,0)
      if global.bShooter=0
        textDropShadow(string("AWESOME:") +string(curAwesome),view_xview[0]+4,view_yview[0]+62,awesomeColorA,awesomeColorB,1)
      else
        textDropShadow(string("AWESOME:") +string(curAwesome),view_xview[0]+264,view_yview[0]+24,awesomeColorA,awesomeColorB,1)
    }

    if global.optDeathCounter=1 //Display death counter on screen
    {
      draw_set_alpha(1)
      draw_set_font(fnt_NES)
      draw_set_halign(fa_left)
      draw_sprite(sHUD_DeathCounter,0,view_xview[0]+8,view_yview[0]+344)
      textDropShadow(global.recDeathCount,view_xview[0]+16,view_yview[0]+341,awesomeColorA,awesomeColorB,1)
    }

    if global.bBossGallery=1 and room!=rBossGallery //Display timer in boss gallery
    {
      draw_set_alpha(1)
      draw_set_font(fnt_NES)
      draw_set_halign(fa_left)
      draw_sprite(sHUD_BossGalleryClock,0,view_xview[0]+382,view_yview[0]+8)
      textDropShadow(global.levelTimeSecond,view_xview[0]+392,view_yview[0]+8,awesomeColorA,awesomeColorB,3)
    }
  }

  if oPlayer1.attackState=oPlayer1.ACT_IN_BIKE
  {
    draw_sprite(sBikeBoostBar,0,view_xview[0]+8,view_yview[0]+317)
    var tBikeBoost;
    tBikeBoost=(oPlayer1.bikeBoost/300)*69
    draw_sprite_part(sBikeBoostMeter,0,0,0,tBikeBoost,22,view_xview[0]+14,view_yview[0]+319)
  }

  if oPlayer1.hitCombo>=3 and global.optShowCombatAward=1 //hit combo counter ---------------------------------------------
  {
    var hitComboIndX,hitComboIndY;
    hitComboIndX=view_xview[0]+17
    hitComboIndY=view_yview[0]+88
    draw_set_halign(fa_left)
    draw_set_font(fnt_HUDnum)
    draw_set_alpha(hitComboAlpha)
    //text
    textDropShadow("Hit:",hitComboIndX,hitComboIndY,c_white,c_black,1)
    textDropShadow(oPlayer1.hitCombo,hitComboIndX+48,hitComboIndY,c_white,c_black,1)
  }

  if oPlayer1.killChain>=2 and global.optShowCombatAward=1 //kill chain counter -----------------------------------
  {
    var hitComboIndX,hitComboIndY;
    hitComboIndX=view_xview[0]+17
    hitComboIndY=view_yview[0]+88
    draw_set_halign(fa_left)
    draw_set_font(fnt_HUDnum)
    draw_set_alpha(killChainAlpha)
    //text
    textDropShadow("Chain:",hitComboIndX,hitComboIndY+14,c_white,c_black,1)
    textDropShadow(oPlayer1.killChain,hitComboIndX+48,hitComboIndY+14,c_white,c_black,1)
  }

  if global.killStreak>=2 and global.optShowCombatAward=1 //kill streak counter -----------------------------------
  {
    var hitComboIndX,hitComboIndY;
    hitComboIndX=view_xview[0]+17
    hitComboIndY=view_yview[0]+88
    draw_set_halign(fa_left)
    draw_set_font(fnt_HUDnum)
    draw_set_alpha(killChainAlpha)
    //text
    textDropShadow("Streak:",hitComboIndX,hitComboIndY+28,c_white,c_black,1)
    textDropShadow(global.killStreak,hitComboIndX+48,hitComboIndY+28,c_white,c_black,1)
  }

  if killChainFadeTime>0 and global.optShowChainMeter=1 //kill chain meter
  {
    var kcMeterX,kcMeterY;
    kcMeterX=view_xview[0]+10
    kcMeterY=view_yview[0]+88
    draw_set_alpha(1)
    draw_set_color(c_ltgray)
    draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+97+(global.skillTree[25]*6),0)
    draw_set_color(c_black)
    draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+97+(global.skillTree[25]*6),1)
    draw_set_color(c_fuchsia)
    draw_rectangle(kcMeterX+1,kcMeterY+1,kcMeterX+4,kcMeterY+killChainFadeTime+1,0)
  }
}
