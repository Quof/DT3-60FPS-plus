#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-30,-80,30,-1)
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Blade Bot"
eLevel=33
maxLife=7700
life=maxLife
atkPower=9
resType[2]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
atkCycle=0
waitTime=45
waitDelay=75 //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action
bLeaveFire=0
bCanFire=0
bAlwaysFire=0
bSpark=0
//-- Desperation Attack Date --
syncAtk=0
syncTime=0
syncBall=36
syncFire=80

runAcc=10
//--------------------

//Misc Data
xCenter=704
roomSpan=320
yGround=352

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
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    if myBotNum=2
    {
      showBossHP.newOffsetX=424
      baseColor=make_color_rgb(170,255,170)
      image_blend=baseColor
    }
    jeremyText="Some important things to note. This thing breaks through your dash invulnerability. It has two dash attacks, a jump attack, an electric ball, and can light the floor on fire. That said, it's uh... not that harsh. This thing is super easy to dodge. There's some code that is unreadable, but given what I've seen, it's probably just as underwhelming."
    chaoText="This comes from the game, 'Astro Boy: Omega Factor'. I think this bot was trying to intimidate you with its swords. Did it work?"
    devText="One of the goals of this level was to introduce some of the advanced enemy types. In the bit after this boss encounter, there was going to be something else added onto them, but with how this level was playing out, I decided against that and pushed them back to the next chapter."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //Movement
    if waitTime<waitDelay
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      xVel=0
    }

    waitTime+=1
    if waitTime>=waitDelay
    {
      if actCheck=0 //---------- Choose an action ----------
      {
        if syncAtk=0
        {
          if atkCycle=3
          {
            actCheck=9
          }
          else //Standard sequence
          {
            if atkNum=0 //----- First attack -----
            {
              if point_distance(x,0,oPlayer1.x,0)<160 //-- Player is close --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=3
                }
                else //Player is low
                {
                  actCheck=1
                }
              }
              else //-- Player is far --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=2
                }
                else //Player is low
                {
                  actCheck=1
                }
              }
            }
            else if atkNum=1 //----- Second attack -----
            {
              if point_distance(x,0,oPlayer1.x,0)<160 //-- Player is close --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=1
                }
                else //Player is low
                {
                  actCheck=2
                }
              }
              else //-- Player is far --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=3
                }
                else //Player is low
                {
                  actCheck=1
                }
              }
            }
            else if atkNum=2 //----- Third attack -----
            {
              if point_distance(x,0,oPlayer1.x,0)<160 //-- Player is close --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=4
                }
                else //Player is low
                {
                  actCheck=3
                }
              }
              else //-- Player is far --
              {
                if oPlayer1.y-32<=288 //Player is too high
                {
                  actCheck=3
                }
                else //Player is low
                {
                  actCheck=4
                }
              }
            }
          }
        }
        else if syncAtk=1
        {
          sprite_index=sBBot_SwingA
          xVel=0
          bCanTakeDamage=0
          syncAtk=2
        }
      }
      if actCheck=1 //---------- ATTACK: CHARGE ATTACK A ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sBBot_SwingA; image_index=0}
        else if actTime=5 {image_index=1}
        else if actTime=9 {image_index=2}
        else if actTime=13 {image_index=3}
        else if actTime=24 and bLeaveFire=1
        {
          if bCanFire=1
          {
            var tFirePillar;
            tFirePillar=instance_create(x,yGround,oDracFireWave)
            tFirePillar.atkPower=atkPower
            bCanFire=0
          }
          else {bCanFire=1}
        }
        else if actTime>=25 and actTime<=35
        {
          if actTime=25 {playSound(global.snd_ChargeStrike,0,0.97,15000)}
          if image_index<6 {image_index+=0.5}
          xVel=(runAcc)*image_xscale
          if image_xscale=1 and x>=xCenter+roomSpan-56 {actTime=35}
          else if image_xscale=-1 and x<=xCenter-roomSpan+56 {actTime=35}
        }
        else if actTime=36
        {
          xVel=0
          image_index=7
        }
        else if actTime>=40
        {
          event_user(0)
        }
      }
      else if actCheck=2 //---------- ATTACK: CHARGE ATTACK B ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sBBot_SwingB; image_index=0}
        else if actTime=4 {image_index=1}
        else if actTime=7 {image_index=2}
        else if actTime=10 {image_index=3}
        else if actTime=14 and bLeaveFire=1
        {
          if bCanFire=1
          {
            var tFirePillar;
            tFirePillar=instance_create(x,yGround,oDracFireWave)
            tFirePillar.atkPower=atkPower
            if bAlwaysFire=0 {bCanFire=0}
          }
          else {bCanFire=1}
        }
        else if actTime>=15 and actTime<=35
        {
          if actTime=15 {playSound(global.snd_ChargeStrike,0,0.97,15000)}
          if image_index<8 {image_index+=0.5}
          xVel=(runAcc*0.75)*image_xscale
          if image_xscale=1 and x>=xCenter+roomSpan-56 {actTime=35}
          else if image_xscale=-1 and x<=xCenter-roomSpan+56 {actTime=35}
        }
        else if actTime=36
        {
          xVel=0
          image_index=9
        }
        else if actTime>=40
        {
          event_user(0)
        }
      }
      else if actCheck=3 //---------- ATTACK: JUMP ATTACK A ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sBBot_SwingB; image_index=0}
        else if actTime=3 {image_index=1}
        else if actTime=9 {image_index=2}
        else if actTime=11 {image_index=3}
        else if actTime=13 {image_index=4}
        else if actTime=15 {image_index=5}
        else if actTime=17
        {
          sprite_index=sBBot_SwingA; image_index=0
          y-=2; yVel=-10
          xVel=(runAcc*0.2)*image_xscale
        }
        else if actTime=19 {image_index=1}
        else if actTime>=20
        {
          if yVel>1 {image_index=2}
        }
      }
      else if actCheck=4 //---------- ATTACK: ELECTRIC BALL ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sBBot_SparkSword}
        else if actTime=7 {bSpark=1}
        else if actTime=25
        {
          bSpark=0
          playSound(global.snd_CShotB,0,0.95,37000)
          var tNewAttack;
          tNewAttack=instance_create(x+(104*image_xscale),y-63,oPassBullet)
          tNewAttack.sprite_index=sSigmaB_ElectricBall; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=2
          tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100
          tNewAttack.direction=point_direction(x+(104*image_xscale),y-63,oPlayer1.x,returnPlayerYCenter())
        }
        else if actTime>=30
        {
          event_user(0)
        }
      }
      else if actCheck=9 //---------- ATTACK: FLOOR FLAME ----------
      {
        actTime+=1
        if actTime=1 {sprite_index=sBBot_LoadFlame}
        else if actTime=16
        {
          playSound(global.snd_Flame1,0,1,12000)
          var tFloorFlame;
          tFloorFlame=instance_create(x,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=0
          tFloorFlame=instance_create(x+18,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=1
          tFloorFlame=instance_create(x-18,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=2
        }
        else if actTime>=20
        {
          event_user(0)
          atkCycle=0
        }
      }
    }

    //---------- Super Team Attack ----------
    if syncAtk=2 //Get into position
    {
      syncTime+=1
      if myBotNum=1
      {
        if syncTime=1 {image_xscale=1}
        else if syncTime>=30 {x+=2}

        if x>=xCenter+roomSpan-40
        {
          image_xscale=-1
          syncTime=0
          syncAtk=3
        }
      }
      else if myBotNum=2
      {
        if syncTime=1 {image_xscale=-1}
        else if syncTime>=30 {x-=2}

        if x<=xCenter-roomSpan+40
        {
          image_xscale=1
          syncTime=0
          syncAtk=3
        }
      }
    }
    else if syncAtk=4 //Begin attack
    {
      syncTime+=1
      if syncTime=1 or syncTime mod 100=0
      {
        if myBotNum=1
        {
          var tFloorFlame;
          tFloorFlame=instance_create(x,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=2
        }
        else if myBotNum=2
        {
          var tFloorFlame;
          tFloorFlame=instance_create(x,yGround,oBBot_FloorFlame)
          tFloorFlame.atkPower=atkPower; tFloorFlame.type=1
        }
      }

      if syncTime mod syncBall=0 //Energy Ball
      {
        if myBotNum=1 {playSound(global.snd_CShotB,0,0.9,44100)}
        var tNewAttack;
        tNewAttack=instance_create(x+(104*image_xscale),y-63,oPassBullet)
        tNewAttack.sprite_index=sSigmaB_ElectricBall; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=3.25
        tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100
        tNewAttack.direction=point_direction(x+(104*image_xscale),y-63,oPlayer1.x,returnPlayerYCenter())
      }
      if syncTime mod syncFire=0 //Fire Pillar
      {
        var tFirePillar;
        tFirePillar=instance_create(oPlayer1.x,yGround,oDracFireWave)
        tFirePillar.atkPower=atkPower
      }

      if syncTime>=430 //End
      {
        bSpark=0
        syncTime=0
        syncAtk=5
      }
    }
    else if syncAtk=5//End attack
    {
      syncTime+=1
      if syncTime>=30
      {
        sprite_index=sBBot_Stand
        bCanTakeDamage=1
        syncAtk=0
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if actCheck=3 and yVel>1
      {
        playSound(global.snd_HardHit2,0,0.95,9000)
        if bLeaveFire=1
        {
          if bCanFire=1
          {
            var tFirePillar;
            tFirePillar=instance_create(x,yGround,oDracFireWave)
            tFirePillar.atkPower=atkPower
            bCanFire=0
          }
          else {bCanFire=1}
        }
        xVel=0
        sprite_index=sBBot_Stand
        event_user(0)
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      xVel=runAcc
      image_xscale=1
    }
    if isCollisionRight(1)
    {
      xVel=-runAcc
      image_xscale=-1
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
  }

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.83 and lifePercent>=0.69 and bossProgress=0
  {
    waitDelay-=4
    bossProgress+=1
  }
  else if lifePercent<=0.68 and lifePercent>=0.57 and bossProgress=1
  {
    waitDelay-=4
    atkMax=3
    bossProgress+=1
  }
  else if lifePercent<=0.56 and lifePercent>=0.45 and bossProgress=2
  {
    waitDelay-=3
    bLeaveFire=1
    bossProgress+=1
  }
  else if lifePercent<=0.44 and lifePercent>=0.32 and bossProgress=3
  {
    waitDelay-=3
    bossProgress+=1
  }
  else if lifePercent<=0.31 and lifePercent>=0.2 and bossProgress=4
  {
    bAlwaysFire=1
    waitDelay-=1
    bossProgress+=1
  }
  else if lifePercent<=0.19 and lifePercent>=0 and bossProgress=5
  {
    waitDelay-=1
    bossProgress+=1
  }

  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim>=1 and deathAnim<=60
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-36,36),y-random(80),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=61
  {
    if global.bBossGallery=1
    {
      oBossGalleryCheck.bossKillCheck+=1
    }
    else
    {
      oEvCh18MainA.sceneProgress+=1
    }
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sBBot_Stand
jumpNum=0
actTime=0
actCheck=0

atkNum+=1
if atkNum=1 {waitTime=round(waitDelay/2)+10}
else if atkNum=2 {waitTime=round(waitDelay/2)+25}

if atkNum>=atkMax {atkCycle+=1; waitTime=0; atkNum=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if bSpark=1
{
  draw_sprite(sSigmaB_ElectricBall,oGame.time/3,x+(104*image_xscale),y-63)
}
