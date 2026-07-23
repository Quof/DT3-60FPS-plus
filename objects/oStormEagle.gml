#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Storm Eagle"
eLevel=17
maxLife=3000
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
resType[2]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
atkTime=15
atkDelay=30
actionState=0 //0-On ground, 1-In air, 2-Flying up, 3-Dropping down
currentAtk=-1
lastAtk=-1
atkProg=0
wingAttackTime=130
windPower=8.5
missileFreq=67
eggAmt=1
currentDive=0
maxDive=3
bulletFreq=7

specialAttack=0
specProg=0

//Misc Data
xCenter=432
yGround=272
roomSpan=336

deathAnim=0
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
    global.recBirdsSeen+=1
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="He works almost exactly like he did before, however he doesn't seem to have the tornado equip. His dive attack has been enhanced somewhat and he can also fire homing missiles. I'm pretty sure all the Mavericks have a desperation attack like in X3. Bird man here doesn't seem to have one all that threatening."
    chaoText="Storm Eagle was a noble and popular Reploid leader of the Maverick Hunter's 7th Air Cavalry unit. When Sigma started the Maverick revolt, he was forced into submission after a failed attempt at stopping Sigma. Because of this loss, Storm Eagle loyally, yet reluctantly agreed to follow Sigma in his rebellion.#-Mega Man Wiki"
    devText="For the Mavericks, since Jerry and X have somewhat similar play styles, I didn't need to change them up all that much to keep them interesting. Though for some, I took quite a few liberties. For Storm Eagle though, he remained mostly the same. Jerry's dash makes him invulnerable, so certain attacks used that as a basis."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack!=2
    {
      if sprite_index!=sStormE_Dive and sprite_index!=sStormE_Spit
      {
        if x<oPlayer1.x
          image_xscale=1
        else
          image_xscale=-1
      }

      if currentAtk<1 {atkTime+=1}
      if atkTime>=atkDelay and currentAtk<1 and actionState<2 //Choose attack
      {
        atkProg=0; atkTime=0
        if currentAtk=-1 {currentAtk=1} //First action
        else
        {
          //Check last action
          if lastAtk=1 {currentAtk=2}
          else if lastAtk=2 {currentAtk=3}
          else if lastAtk=3 {currentAtk=1}

          if actionState=0 //If on ground
          {
            if currentAtk=2 {actionState=2}
            else if currentAtk=3 {actionState=2}
          }
          else if actionState=1 //If in air
          {
            if currentAtk=1 {actionState=3}
          }

          if specialAttack=1
          {
            currentAtk=1; actionState=3
            specialAttack=2
            exit;
          }
        }
      }

      if currentAtk>0 {atkProg+=1}
      if actionState<2
      {
        if currentAtk=1 //-------------------- ATTACK: WING FLAP (Ground) --------------------
        {
          if atkProg=1
          {
            sprite_index=sStormE_StandFlap
            var tWind;
            tWind=instance_create(0,0,oStormEWind)
            tWind.windPower=windPower
          }
          else if atkProg>=2 and atkProg<wingAttackTime
          {
            if atkProg mod 10=0 {playSound(global.snd_WindBlow,0,0.96,1)}
            if atkProg mod missileFreq=0
            {
              var tMissile;
              tMissile=instance_create(x,y-40,oEnmityMissile)
              tMissile.atkPower=atkPower; tMissile.targetTime=50
              tMissile.direction=90
            }
          }
          else if atkProg>=wingAttackTime
          {
            SS_StopSound(global.snd_WindBlow)
            sprite_index=sStormE_Idle
            with oStormEWind {instance_destroy()}
            lastAtk=currentAtk; currentAtk=0; atkProg=0
          }
        }
        else if currentAtk=2 //-------------------- ATTACK: EGG TOSS --------------------
        {
          if atkProg=1 {sprite_index=sStormE_Spit}
          else if atkProg=10
          {
            sprite_index=sStormE_Fly
            var newEgg;
            for(i=0;i<eggAmt;i+=1)
            {
              playSound(global.snd_LinkBomb,0,0.97,18000)
              newEgg=instance_create(x+(4*image_xscale),y-39,oStormEgg)
              newEgg.atkPower=atkPower
              newEgg.xVel=(2.75+i)*image_xscale
              newEgg.yVel=-4-i
            }
          }
          else if atkProg=13
          {
            lastAtk=currentAtk; currentAtk=0; atkProg=0
          }
        }
        else if currentAtk=3 //-------------------- ATTACK: AERIAL DIVE --------------------
        {
          if atkProg=1
          {
            sprite_index=sStormE_Fly
          }
          else if atkProg>=2 and atkProg<=199
          {
            y-=3
            if y<=-8 {currentDive=0; atkProg=200}
          }
          else if atkProg=215
          {
            playSound(global.snd_WindBlow,0,0.96,50000)
            sprite_index=sStormE_Dive
            image_xscale=choose(-1,1)
            x=oPlayer1.x+(312*-image_xscale)
            y=yGround-324
          }
          else if atkProg>=216 and atkProg<=499
          {
            if atkProg mod bulletFreq=0
            {
              var tNewAttack;
              for(i=0;i<2;i+=1)
              {
                tNewAttack=instance_create(x,y,oPassBullet)
                tNewAttack.sprite_index=sEnmityMissile
                tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9; tNewAttack.decayTime=-100
                if image_xscale=1
                {
                  if i=0 {tNewAttack.direction=45}
                  else {tNewAttack.direction=225}
                }
                else
                {
                  if i=0 {tNewAttack.direction=135}
                  else {tNewAttack.direction=315}
                }
              }
            }

            x+=13*image_xscale; y+=13
            if y>=room_height+80
            {
              currentDive+=1
              if currentDive>=maxDive
              {
                atkProg=500
                x=choose(304,576)
                sprite_index=sStormE_Fly
                y=-8
              }
              else
              {
                atkProg=200
              }
            }
          }
          else if atkProg>=500
          {
            y+=3
            if y>=144
            {
              y=144
              lastAtk=currentAtk; currentAtk=0; atkProg=0
            }
          }
        }
      }
      else if actionState=2 //Fly up
      {
        if atkProg=1 {sprite_index=sStormE_Fly}
        else if atkProg>=2
        {
          y-=3
          if y<=144
          {
            y=144
            actionState=1
            atkProg=0
          }
        }
      }
      else if actionState=3 //Drop down
      {
        if atkProg=1 {sprite_index=sStormE_Fly}
        else if atkProg>=2
        {
          y+=3
          if y>=yGround
          {
            sprite_index=sStormE_Idle
            y=yGround
            actionState=0
            atkProg=0
          }
        }
      }
    }
    else //Special attack
    {
      image_blend=make_color_rgb(random(255),random(255),random(255))
      specProg+=1
      if specProg=1 //Start
      {
        sprite_index=sStormE_Fly
        xSpecSpd=10
        ySpecSpd=10
        for(i=0;i<6;i+=1) {resType[i]=1}
      }
      else if specProg>=2 and specProg<=199 //Fly up
      {
        y-=5
        if y<=-8 {currentDive=0; specProg=200}
      }
      else if specProg=210
      {
        sprite_index=sStormE_Dive; image_xscale=-1
        x=room_width+32; y=-32
      }
      else if specProg>=211 and specProg<=399 //First zigzag pass
      {
        if specProg mod 3=0
        {
          var tNewAttack;
          for(i=0;i<2;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sEnmityMissile
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9; tNewAttack.decayTime=-100
            if image_yscale=1
            {
              if i=0 {tNewAttack.direction=135}
              else {tNewAttack.direction=315}
            }
            else
            {
              if i=0 {tNewAttack.direction=45}
              else {tNewAttack.direction=225}
            }
          }
        }

        x-=xSpecSpd; y+=ySpecSpd
        if ySpecSpd>0
        {
          if y>=144 {playSound(global.snd_WindBlow,0,0.92,50000); ySpecSpd*=-1; image_yscale=-1}
        }
        else
        {
          if y<=16 {playSound(global.snd_WindBlow,0,0.92,50000); ySpecSpd*=-1; image_yscale=1}
        }

        if x<=-48 {specProg=400}
      }
      else if specProg=410
      {
        sprite_index=sStormE_Dive; image_xscale=1; image_yscale=1
        x=-32; y=176
      }
      else if specProg>=421 and specProg<=699 //Second zigzag pass
      {
        if specProg mod 5=0
        {
          var tNewAttack;
          for(i=0;i<2;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sEnmityMissile
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9; tNewAttack.decayTime=-100
            if image_yscale=1
            {
              if i=0 {tNewAttack.direction=45}
              else {tNewAttack.direction=225}
            }
            else
            {
              if i=0 {tNewAttack.direction=135}
              else {tNewAttack.direction=315}
            }
          }
        }

        x+=xSpecSpd; y+=ySpecSpd
        if ySpecSpd>0
        {
          if y>=336 {playSound(global.snd_WindBlow,0,0.92,50000); ySpecSpd*=-1; image_yscale=-1}
        }
        else
        {
          if y<=176 {playSound(global.snd_WindBlow,0,0.92,50000); ySpecSpd*=-1; image_yscale=1}
        }

        if x>=room_width+32
        {
          x=choose(304,576); y=-8
          sprite_index=sStormE_Fly; image_yscale=1
          specProg=700
        }
      }
      else if specProg>=710
      {
        y+=5
        if y>=144
        {
          y=144
          image_blend=c_white
          for(i=0;i<6;i+=1) {resType[i]=3}
          resType[1]=2; resType[2]=2
          specialAttack=3
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.84 and lifePercent>=0.69 and bossProgress=0
    {
      atkDelay-=5
      wingAttackTime-=5
      windPower+=0.6
      missileFreq-=8
      bulletFreq-=1
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.53 and bossProgress=1
    {
      atkDelay-=5
      wingAttackTime-=5
      windPower+=0.6
      missileFreq-=8
      eggAmt+=1
      maxDive+=1
      bulletFreq-=1
      bossProgress+=1
    }
    else if lifePercent<=0.52 and lifePercent>=0.37 and bossProgress=2
    {
      atkDelay-=5
      wingAttackTime-=5
      windPower+=0.6
      missileFreq-=8
      eggAmt+=1
      bulletFreq-=1
      specialAttack=1
      bossProgress+=1
    }
    else if lifePercent<=0.36 and lifePercent>=0.21 and bossProgress=3
    {
      atkDelay-=5
      wingAttackTime-=5
      windPower+=0.6
      missileFreq-=8
      eggAmt+=1
      maxDive+=1
      bulletFreq-=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      atkDelay-=5
      wingAttackTime-=5
      windPower+=0.6
      missileFreq-=8
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sStormE_Spit
      with oStormEWind {instance_destroy()}
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
        bossRoomTally(18)
        global.newMapX=2104; global.newMapY=1024; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if specialAttack=2 {redDmgHit(0)}
else {event_inherited()}
