#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Malevolence"
eLevel=26
maxLife=10500
life=maxLife
atkPower=8
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
eyeFrm=0
mouthOpen=0

mouthFlameTime=190
mouthFlameDelay=240
sideStart=0 //1-Left, 2-Right

eyeLaserTime=100
eyeLaserDelay=140

lightningTime=200
lightningDelay=360
lightningFreq=45
lightningLength=100

firePillar=0
firePTime=0

specialAttack=0
specProg=0
specTime=0
specX=0
//--------------------

//Misc Data
xCenter=240
yGround=1344
roomSpan=192
yCenter=1264

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
    jeremyText="I know you're probably pretty upset at me right now, but let's not focus on that right now. This thing is piss easy. It has 3 fairly 'meh' attacks, they're kinda threatening when used together, but you've come across a lot worse. Some breath attack and lightning attack that you've already seen. Oh right, laser eyes. Yaaaaawn. You guys shouldn't have any problem with this...right?"
    chaoText="This is the final battle from the game 'King of Demons.' I think it was Japan only though."
    devText="While I wasn't going for a typical horror setting for the previous rooms, I was going for something a bit creepy. Chao and the HUD got in the way of the feel I was going for with this place, so it made sense to put this part at a moment when Jeremy is blocked out again."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack=0 or specialAttack=2
    {
      //Check player position and change eye direction based on that
      playerDist=point_distance(x,0,oPlayer1.x,0)
      if playerDist<=48 {eyeFrm=0}
      else
      {
        if oPlayer1.x<x {eyeFrm=1} else {eyeFrm=2}
      }

      //Head movement
      if bossProgress>=4
      {
        if mouthFlameTime<mouthFlameDelay
        {
          if x<oPlayer1.x
          {
            if x>xCenter-(roomSpan-104) {x-=1}
          }
          else if x>oPlayer1.x
          {
            if x<xCenter+(roomSpan-104) {x+=1}
          }
        }
      }

      //-------------------- ATTACK: MOUTH FLAME --------------------
      mouthFlameTime+=1
      if mouthFlameTime>=mouthFlameDelay and mouthFlameTime<=mouthFlameDelay+100 //Trigger attack
      {
        mouthOpen=1
        sideStart=choose(1,2)
        mouthFlameTime=10000
      }
      else if mouthFlameTime>=10001 and mouthFlameTime<=10099 //Go to chosen side
      {
        if sideStart=1
        {
          x-=6
          if x<xCenter-(roomSpan-56) {mouthFlameTime=10100}
        }
        else if sideStart=2
        {
          x+=6
          if x>xCenter+(roomSpan-56) {mouthFlameTime=10100}
        }

        if specialAttack=0
        {
          if y>yCenter-32 {y-=4}
          else {y+=4}
        }
        else if specialAttack=2
        {
          if y>yCenter-64 {y-=4}
          else {y+=4}
        }
      }
      else if mouthFlameTime>=10120 and mouthFlameTime<=10299 //Glide across room
      {
        if mouthFlameTime=10121 {playSound(global.snd_Beam,0,0.95,11025)}
        var tPoison;
        tPoison=instance_create(x+random_range(-3,3),y+random_range(-3,3),oM_PoisonBreath)
        tPoison.atkPower=atkPower; tPoison.bulletSpeed=5+random(2); tPoison.depth=24
        tPoison.animSpeed=0.25; tPoison.direction=270+random_range(-5,5); tPoison.image_blend=c_maroon

        if sideStart=1
        {
          x+=3
          if x>xCenter+(roomSpan-56) {mouthFlameTime=10300}
        }
        else if sideStart=2
        {
          x-=3
          if x<xCenter-(roomSpan-56) {mouthFlameTime=10300}
        }
      }
      else if mouthFlameTime=10301 {mouthOpen=0}
      else if mouthFlameTime>=10302 //Reset head position and end attack
      {
        if x<xCenter {x+=4}
        else {x-=4}
        if specialAttack=0
        {
          if y<yCenter {y+=4}
          else {y-=4}
          var tCentDist;
          tCentDist=point_distance(x,y,xCenter,yCenter)
        }
        else if specialAttack=2
        {
          if y<yCenter-80 {y+=4}
          else {y-=4}
          var tCentDist;
          tCentDist=point_distance(x,y,xCenter,yCenter-80)
        }

        if tCentDist<=3
        {
          x=xCenter
          if specialAttack=0 {y=yCenter}
          else if specialAttack=2 {y=yCenter-80}
          mouthFlameTime=0
        }
      }

      //-------------------- ATTACK: EYE LASER --------------------
      eyeLaserTime+=1
      if eyeLaserTime>=eyeLaserDelay and eyeLaserTime<=eyeLaserDelay+100 //Trigger attack
      {
        var tEffect;
        tEffect=instance_create(x+14,y-26,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.newBlend=-1; tEffect.followID=id; tEffect.xFollow=14; tEffect.yFollow=-26
        tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(x-14,y-26,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.newBlend=-1; tEffect.followID=id; tEffect.xFollow=-14; tEffect.yFollow=-26
        tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        eyeLaserTime=10000
      }
      else if eyeLaserTime=10025
      {
        playSound(global.snd_LaserA,0,0.95,24000)
        playSound(global.snd_CShotA,0,0.85,24000)
        var tNewAttack;
        tNewAttack=instance_create(x+14,y-26,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+14,y-26,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_angle=point_direction(x+14,y-26,oPlayer1.x,oPlayer1.y-26)
        tNewAttack=instance_create(x-14,y-26,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+14,y-26,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_angle=point_direction(x+14,y-26,oPlayer1.x,oPlayer1.y-26)
        eyeLaserTime=0
      }

      //-------------------- ATTACK: LIGHTNING --------------------
      lightningTime+=1
      if lightningTime>=lightningDelay and lightningTime<=lightningDelay+100 //Trigger attack
      {
        var tEffect;
        tEffect=instance_create(x+14,y-26,oEffect)
        tEffect.sprite_index=sFlameUp; tEffect.image_speed=0.5; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=id; tEffect.xFollow=14; tEffect.yFollow=-26
        tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(x-14,y-26,oEffect)
        tEffect.sprite_index=sFlameUp; tEffect.image_speed=0.5; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=id; tEffect.xFollow=-14; tEffect.yFollow=-26
        tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        lightningTime=10000
      }
      else if lightningTime>=10030 and lightningTime<=10030+lightningLength //Spawn lightning attack
      {
        if lightningTime mod lightningFreq=0
        {
          playSound(global.snd_OrbThrow,0,0.95,1)
          var tNewAttack;
          tNewAttack=instance_create(choose(112,176,240,304,368),1040,oPassBullet)
          tNewAttack.sprite_index=sMalevLightning; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4.5
          tNewAttack.decayTime=300; tNewAttack.direction=270
        }
      }
      else if lightningTime>=10031+lightningLength //End attack
      {
        lightningTime=0
      }

      if firePillar=1 or firePillar=3 or firePillar=5 or firePillar=7
      {
        firePTime+=1
        if firePTime=1
        {
          var tWarnSign;
          if firePillar=1 {tWarnSign=instance_create(176,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35}
          else if firePillar=3 {tWarnSign=instance_create(304,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35}
          else if firePillar=5
          {
            tWarnSign=instance_create(80,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35
            tWarnSign=instance_create(376,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35
          }
        }
        else if firePTime>=40
        {
          var tFireString;
          if firePillar=1 {tFireString=instance_create(176,1120,oMalevFireString); tFireString.atkPower=atkPower}
          else if firePillar=3 {tFireString=instance_create(304,1120,oMalevFireString); tFireString.atkPower=atkPower}
          else if firePillar=5
          {
            for(i=0;i<4;i+=1)
            {
              tFireString=instance_create(72+(i*8),1120,oMalevFireString); tFireString.atkPower=atkPower
              tFireString=instance_create(384+(i*8),1120,oMalevFireString); tFireString.atkPower=atkPower
            }
          }
          firePillar+=1
          firePTime=0
        }
      }
    }
    else if specialAttack=1 //Special Attack
    {
      specTime+=1
      if specTime=1 //Init
      {
        eyeFrm=-1
        mouthOpen=0
        mouthFlameTime=180
        lightningTime=200
      }
      else if specTime>=2 and specTime<=99 //Go to center -112,176,240,304,368
      {
        if x<xCenter {x+=4}
        else {x-=4}
        if y<yCenter-64 {y+=4}
        else {y-=4}
        var tCentDist;
        tCentDist=point_distance(x,y,xCenter,yCenter-64)
        if tCentDist<=2
        {
          x=xCenter; y=yCenter-64
          specTime=100
        }
      }
      else if specTime=110 {specX=112; event_user(0); specX=368; event_user(0)}
      else if specTime=150 {specX=240; event_user(0); specX=368; event_user(0)}
      else if specTime=190 {specX=112; event_user(0); specX=240; event_user(0)}
      else if specTime=230 {specX=176; event_user(0); specX=368; event_user(0)}
      else if specTime=270 {specX=112; event_user(0); specX=304; event_user(0)}
      else if specTime>=310
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        specialAttack+=1
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      mouthFlameDelay-=10
      eyeLaserDelay-=15
      lightningDelay-=15
      lightningFreq-=6
      lightningLength+=9
      firePillar+=1
      (314511).image_xscale-=0.05; (314511).image_yscale-=0.1
      (314512).image_xscale-=0.05; (314512).image_yscale-=0.1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=1
    {
      mouthFlameDelay-=10
      eyeLaserDelay-=15
      lightningDelay-=15
      lightningFreq-=6
      lightningLength+=9
      firePillar+=1
      (314511).image_xscale-=0.05; (314511).image_yscale-=0.2
      (314512).image_xscale-=0.05; (314512).image_yscale-=0.2
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.38 and bossProgress=2
    {
      specialAttack+=1
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
    else if lifePercent<=0.37 and lifePercent>=0.2 and bossProgress=3
    {
      mouthFlameDelay-=20
      eyeLaserDelay-=15
      lightningDelay-=25
      lightningFreq-=6
      lightningLength+=8
      firePillar+=1
      (314511).image_xscale-=0.1; (314511).image_yscale-=0.2
      (314512).image_xscale-=0.1; (314512).image_yscale-=0.2
      bossProgress+=1
    }
    else if lifePercent<=0.19 and lifePercent>=0 and bossProgress=4
    {
      mouthFlameDelay-=20
      eyeLaserDelay-=15
      lightningDelay-=25
      lightningFreq-=5
      lightningLength+=8
      (314511).image_xscale-=0.2; (314511).image_yscale-=0.3
      (314512).image_xscale-=0.2; (314512).image_yscale-=0.3
      bossProgress+=1
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
  }
  else if deathAnim>=2 and deathAnim<=90
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    if oGame.time mod 2=0
    {
      var tEffect;
      tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim>=91
  {
    if global.bBossGallery=1
    {
      bossRoomTally(39)
      global.newMapX=2328; global.newMapY=752; room_goto(rBossGallery)
    }
    else {instance_destroy()}
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_OrbThrow,0,0.95,1)
var tNewAttack;
tNewAttack=instance_create(specX,1040,oPassBullet)
tNewAttack.sprite_index=sMalevLightning; tNewAttack.atkPower=atkPower
tNewAttack.bulletSpeed=4; tNewAttack.decayTime=300; tNewAttack.direction=270
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sMalevBody,0,xCenter,yGround-68,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMalevNeck,0,xCenter,yGround-68,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
//Neck parts
var tNeckDist,tNeckDir;
tNeckDist=point_distance(xCenter,yGround-68,x,y+24)
tNeckDir=point_direction(xCenter,yGround-68,x,y+24)
for(i=0;i<4;i+=1)
{
  draw_sprite_ext(sMalevNeck,0,xCenter+lengthdir_x(tNeckDist*(0.2*(i+1)),tNeckDir),yGround-68+lengthdir_y(tNeckDist*(0.2*(i+1)),tNeckDir),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

draw_sprite_ext(sMalevNeck,0,x,y+24,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
event_inherited() //Head
if mouthOpen=1 {draw_sprite_ext(sMalevJaw,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
if eyeFrm>=0 {}draw_sprite_ext(sMalevEyes,eyeFrm,x,y-20,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
