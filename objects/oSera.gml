#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Sera"
eLevel=32
maxLife=8500
life=maxLife
atkPower=8
resType[2]=1
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
roundNum=0 //number of attack cycles
waitTime=55
waitDelay=85 //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action
bigBlockChk=0

moveType=-1
xVel=0; yVel=0
imageEffect=0

specialAttack=0
specProg=0
specTime=0
//--------------------

//Misc Data
xCenter=368
roomSpan=272
yGround=288

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
    showBossHP=instance_create(0,0,oBossLifeDisplay)
    showBossHP.bossID=id
    showBossHP.type=0
    jeremyText="When she's stopped, it's best if you keep an eye on her. Watch where she points her spear and you'll know where she's about to fire. Two of them to note, when it's pointed forward, she's summoning undashable ice rocks. When it's pointed down, she's going to fire an ice shot toward your feet and will shatter once it hits the ground."
    chaoText="This isn't right, having to fight this bot. I hope this is the last time we have to do this. The next room, it's right there and we'll never have to do this again."
    devText="Ever since I decided on Harpuia for DT2, I knew that I had to have a place for Leviathan in DT3. In the planning stages, having the sprite used for this scenario felt like the best fit since Gate 4 wasn't going to be using anything beyond the X series, and Gate D already had two other candidates."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack=0 or specialAttack=2
    {
      //---------- Movement ----------
      if waitTime<waitDelay
      {
        if atkNum=0
        {
          if moveType=0 //Dash toward player
          {
            if waitTime=5
            {
              xVel=8*image_xscale
              if y-18<oPlayer1.y-26 {yVel=4}
              else if y-18>oPlayer1.y-26 {yVel=-4}
            }
          }
          else if moveType=1 //Dash away from player
          {
            if waitTime=5
            {
              xVel=6*-image_xscale
              if y-18>oPlayer1.y-26 {yVel=3}
              else if y-18<oPlayer1.y-26 {yVel=-3}
            }
          }
          else if moveType=2 //Dash across map
          {
            if waitTime=5
            {
              if x<xCenter
              {
                image_xscale=1
                xVel=10.5
                if x<xCenter-64 {xVel=12}
              }
              else
              {
                image_xscale=-1
                xVel=-10.5
                if x>xCenter+64 {xVel=-12}
              }
              if y-18>yGround-40 {yVel=-5}
              else if y-18<yGround-128 {yVel=5}
            }
          }
          else if moveType=3 //Teleport (Resets position)
          {
            if waitTime=5
            {
              var tDir;
              tDir=0
              for(i=0;i<16;i+=1)
              {
                tEffect=instance_create(x,y-18,oEffect)
                tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.33; tEffect.image_angle=random(360)
                tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                tEffect.direction=tDir; tEffect.image_alpha=0.75
                if i mod 2=0 {tEffect.speed=7}
                else {tEffect.speed=4}
                tDir+=22.5
              }
              visible=0
              bCanDealDamage=false; bCanTakeDamage=false
              x=oPlayer1.x; y=224
              var tFFScl,tEffect;
              for(i=0;i<10;i+=1)
              {
                tFFScl=random(0.1)
                tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffectB)
                tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
                tEffect.image_alpha=0.9; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
                tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.friction=random(0.01)+0.01
                tEffect.fadeSpd=0.033; tEffect.image_blend=make_color_rgb(random(50),random(50),255)
                tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
              }
            }
            else if waitTime=35
            {
              var tDir;
              tDir=0
              for(i=0;i<16;i+=1)
              {
                tEffect=instance_create(x,y-18,oEffect)
                tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.33; tEffect.image_angle=random(360)
                tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                tEffect.direction=tDir; tEffect.image_alpha=0.75
                if i mod 2=0 {tEffect.speed=5}
                else {tEffect.speed=3}
                tDir+=22.5
              }
              visible=1
              bCanDealDamage=true; bCanTakeDamage=true
            }
          }
        }
      }
      //---------- Dash frame ----------
      if sprite_index=sSeraIdle or sprite_index=sSeraDashForward or sprite_index=sSeraDashBack
      {
        if x<oPlayer1.x
        {
          image_xscale=1
          if xVel>1.2 {sprite_index=sSeraDashForward}
          if xVel<-1.2 {sprite_index=sSeraDashBack}
        }
        else
        {
          image_xscale=-1
          if xVel>1.2 {sprite_index=sSeraDashBack}
          if xVel<-1.2 {sprite_index=sSeraDashForward}
        }
      }
      //---------- Dampen speed ----------
      if xVel>=0.4
      {
        xVel-=0.2
        if xVel<=1.2 {if sprite_index=sSeraDashForward or sprite_index=sSeraDashBack {sprite_index=sSeraIdle}}
        if xVel<=0.5 {xVel=0}
      }
      else if xVel<=-0.4
      {
        xVel+=0.2
        if xVel>=-1.2 {if sprite_index=sSeraDashForward or sprite_index=sSeraDashBack {sprite_index=sSeraIdle}}
        if xVel>=-0.5 {xVel=0}
      }

      if yVel>=0.3
      {
        yVel-=0.15
        if yVel<=0.3 {yVel=0}
      }
      else if yVel<=-0.3
      {
        yVel+=0.15
        if yVel<=-0.3 {yVel=0}
      }

      x+=xVel; y+=yVel

      if sprite_index=sSeraDashForward or sprite_index=sSeraDashBack //---------- After-image ----------
      {
        imageEffect+=1
        if imageEffect mod 2=0
        {
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.depth=26; tAfterI.image_blend=c_teal
          tAfterI.image_alpha=0.5; tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.imageFade=0.02; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
        }
      }

      waitTime+=1
      if waitTime>=waitDelay
      {
        if actCheck=0 //---------- Choose an action ----------
        {
          if atkNum=0 //----- First attack -----
          {
            var tChkDist;
            tChkDist=point_distance(x,0,oPlayer1.x,0)
            if round(tChkDist) mod 2=0
            {
              actCheck=2
            }
            else
            {
              actCheck=3
            }
            if tChkDist>=192 {actCheck=1}
            if roundNum>=5
            {
              actCheck=4
              roundNum=0
            }
          }
          else if atkNum=1 //----- Second attack -----
          {
            var tChkDist;
            tChkDist=point_distance(x,0,oPlayer1.x,0)
            if round(tChkDist) mod 2=0
            {
              actCheck=6
            }
            else
            {
              actCheck=2
            }
          }
          else if atkNum=2 //----- Third attack -----
          {
            var tChkDist;
            tChkDist=point_distance(x,0,oPlayer1.x,0)
            if round(tChkDist) mod 2=0
            {
              actCheck=7
            }
            else
            {
              actCheck=6
            }
          }
          else if atkNum>=3 //----- Fourth attack -----
          {
            var tChkDist;
            tChkDist=round(point_distance(x,0,oPlayer1.x,0))
            if tChkDist<=96 {actCheck=2}
            else {actCheck=7}
            if bigBlockChk>=3
            {
              actCheck=5
              bigBlockChk=0
            }
          }
        }
        else if actCheck=1 //---------- ATTACK: SPEARHEAD RAIN ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabB; image_index=0
            var tEffect;
            tEffect=instance_create(x+(21*image_xscale),y-42,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            if image_xscale=1 {tEffect.image_angle=45}
            else {tEffect.image_angle=135}
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime>=15 and actTime<=30
          {
            if actTime mod 3=0
            {
              playSound(global.snd_SpearShot,0,0.98,1)
              var tNewAttack;
              tNewAttack=instance_create(x+(21*image_xscale),y-42,oPassBullet)
              tNewAttack.sprite_index=sSeraSpearhead; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=18
              tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33
              if image_xscale=1 {tNewAttack.direction=45}
              else {tNewAttack.direction=135}
            }
          }
          else if actTime=31
          {
            var tNewAttack;
            tNewAttack=instance_create(0,0,oSeraRainSpearheads)
            tNewAttack.atkPower=atkPower
          }
          else if actTime>=33
          {
            event_user(0)
          }
        }
        else if actCheck=2 //---------- ATTACK: SHATTERING ICE BLAST ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabC; image_index=0
            var tEffect;
            tEffect=instance_create(x+(21*image_xscale),y-6,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            if image_xscale=1 {tEffect.image_angle=315}
            else {tEffect.image_angle=225}
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime=13
          {
            playSound(global.snd_IceShot,0,1,1)
            var tNewAttack,tDir;
            tDir=point_direction(x+(21*image_xscale),y-6,oPlayer1.x,282)
            tNewAttack=instance_create(x+(21*image_xscale),y-6,oSeraIceShot)
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10; tNewAttack.type=0
            tNewAttack.direction=tDir; tNewAttack.image_angle=tDir
          }
          else if actTime>=17
          {
            event_user(0)
          }
        }
        else if actCheck=3 //---------- ATTACK: BIG ICE ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabA; image_index=0
            var tEffect;
            tEffect=instance_create(x+(29*image_xscale),y-23,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            if image_xscale=1 {tEffect.image_angle=0}
            else {tEffect.image_angle=180}
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime=13
          {
            var tNewAttack;
            tNewAttack=instance_create(-32,138,oSeraBigIce); tNewAttack.atkPower=atkPower+1; tNewAttack.xVel=2.75
            tNewAttack=instance_create(-32,250,oSeraBigIce); tNewAttack.atkPower=atkPower+1; tNewAttack.xVel=2.75
            if bossProgress>=2
            {
              tNewAttack=instance_create(room_width+32,138,oSeraBigIce); tNewAttack.atkPower=atkPower+1; tNewAttack.xVel=-4
              tNewAttack=instance_create(room_width+32,250,oSeraBigIce); tNewAttack.atkPower=atkPower+1; tNewAttack.xVel=-4
            }
          }
          else if actTime>=17
          {
            event_user(0)
          }
        }
        else if actCheck=4 //---------- ATTACK: DRAGON HEAD ----------
        {
          actTime+=1
          if actTime=1
          {
            playSound(global.snd_Magic,0,0.95,1)
            sprite_index=sSeraSpearSwirl; image_index=0
          }
          else if actTime=4 {image_index=1}
          else if actTime=7 {image_index=2}
          else if actTime=10 {image_index=3}
          else if actTime=13 {image_index=4}
          else if actTime=16 {image_index=5}
          else if actTime=19 {image_index=6}
          else if actTime=22 {image_index=7}
          else if actTime=25
          {
            image_index=8
            var tEffect;
            tEffect=instance_create(x+(25*image_xscale),y-26,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.5; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
          }
          else if actTime=30
          {
            var tNewAttack;
            tNewAttack=instance_create(x+(25*image_xscale),y-26,oSeraDragon)
            tNewAttack.atkPower=atkPower
            if image_xscale=1 {tNewAttack.direction=0}
            else {tNewAttack.direction=180}
          }
          else if actTime>=35
          {
            event_user(0)
          }
        }
        else if actCheck=5 //---------- ATTACK: SPEAR TWIRLING ICE SHATTER ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabB; image_index=0
            if image_xscale=1 {image_angle=45}
            else {image_angle=315}
            var tEffect;
            tEffect=instance_create(x-(16*image_xscale),y-44,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            tEffect.image_angle=90
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime=13
          {
            var tNewAttack;
            tNewAttack=instance_create(x-(16*image_xscale),y-44,oSeraShatteringIceBlock)
            tNewAttack.atkPower=atkPower
            if image_xscale=1 {tNewAttack.direction=0}
            else {tNewAttack.direction=180}
          }
          else if actTime=25
          {
            sprite_index=sSeraSpearSpin; image_angle=0
            xVel=4*-image_xscale
          }
          else if actTime>=30
          {
            if !instance_exists(oSeraShatteringIceBlock)
            {
              event_user(0)
            }
          }

          if sprite_index=sSeraSpearSpin {image_index+=0.33}
        }
        else if actCheck=6 //---------- ATTACK: CEILING SHATTER SHOT ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabB; image_index=0
            var tEffect;
            tEffect=instance_create(x+(21*image_xscale),y-42,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            if image_xscale=1 {tEffect.image_angle=45}
            else {tEffect.image_angle=135}
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime=13
          {
            playSound(global.snd_IceShot,0,1,27000)
            var tNewAttack,tDir;
            tDir=point_direction(x+(21*image_xscale),y-42,oPlayer1.x,70)
            tNewAttack=instance_create(x+(21*image_xscale),y-42,oSeraIceShot)
            tNewAttack.sprite_index=sSeraAtkIceA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
            tNewAttack.type=1; tNewAttack.direction=tDir
          }
          else if actTime>=17
          {
            event_user(0)
          }
        }
        else if actCheck=7 //---------- ATTACK: FLOOR ICE ----------
        {
          actTime+=1
          if actTime=1
          {
            sprite_index=sSeraSpearStabC; image_index=0
            var tEffect;
            tEffect=instance_create(x+(21*image_xscale),y-6,oEffect)
            tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.33; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
            if image_xscale=1 {tEffect.image_angle=315}
            else {tEffect.image_angle=225}
          }
          else if actTime=5 {image_index=1}
          else if actTime=9 {image_index=2}
          else if actTime=13
          {
            var tNewAttack;
            tNewAttack=instance_create(oPlayer1.x,yGround,oSeraFloorIce)
            tNewAttack.atkPower=atkPower; tNewAttack.image_xscale=image_xscale
          }
          else if actTime>=17
          {
            event_user(0)
          }
        }
      }
    }
    else if specialAttack=1 //Special Attack - No special attack, but this is left here anyway
    {
      specTime+=1
      if specTime=1 //Init
      {

      }
    }
  }
  enemyStepEvent()

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.86 and lifePercent>=0.71 and bossProgress=0
  {
    waitDelay-=5
    bossProgress+=1
  }
  else if lifePercent<=0.7 and lifePercent>=0.56 and bossProgress=1
  {
    waitDelay-=5
    atkMax+=1
    bossProgress+=1
  }
  else if lifePercent<=0.55 and lifePercent>=0.42 and bossProgress=2
  {
    waitDelay-=5
    bossProgress+=1
  }
  else if lifePercent<=0.41 and lifePercent>=0.21 and bossProgress=3
  {
    waitDelay-=5
    atkMax+=1
    bossProgress+=1
  }
  else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
  {
    waitDelay-=5
    bossProgress+=1
  }
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
    with oSeraRainSpearheads {instance_destroy()}
    sprite_index=sSeraHit
  }
  else if deathAnim>=2 and deathAnim<=60
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-20,20),y-random(40),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>61
  {
    if global.bBossGallery=1
    {
      bossRoomTally(48)
      global.newMapX=1320; global.newMapY=496; room_goto(rBossGallery)
    }
    else
    {
      oEvCh17MainA.sceneProgress=1
      instance_destroy()
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if enemyDeflect(1,1,1,1,1,1)=1 and sprite_index=sSeraSpearSpin
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x+random_range(-11,11),y-4-random(44),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else {event_inherited()}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//End attack
sprite_index=sSeraIdle
actTime=0
actCheck=0

atkNum+=1
waitTime=waitDelay-12

if atkNum>=atkMax
{
  moveType+=1
  if moveType=4 {moveType=0}
  roundNum+=1
  bigBlockChk+=1
  waitTime=0; atkNum=0
}
