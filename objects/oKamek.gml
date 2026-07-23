#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15
image_xscale=-1

//Enemy base statistics
eName="Kamek"
maxLife=5
life=maxLife
atkPower=3
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
xCenter=272
yGround=288
roomSpan=144

atkTime=0
moveType=0
moveSpd=2
shockPass=2
maxFlames=3
bShadow=0
shadowScl=1
meteorSeq=0
walkFrm=0

hitStateTime=0
wandState=0
shieldAnim=0

jeremyText="I haven't found a way to read its data yet, check back in a bit."
chaoText="Hey, I've seen this somewhere... Hmm... OH!#It's by a guy who does really good sprite work on a site called 'Spriters Resource.' I guess the program found this one... I guess? That's the only explanation I can think of, unless the original creators used it as a creepy placeholder for something. Ask Jeremy about behaviors, I can't figure this one out."
devText="I had tons of ideas for the boss fight here, but I knew I wanted it to have a somewhat creepy vibe to it. That ruled out quite a lot of the ideas I initially had. During the demo release, this boss didn't exist, but since all the other Nightmare Gates had a boss fight, and seeing how there weren't that many other planned Mario related bosses, I wanted to put one in here."
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
    activateBoss=2
  }

  if sprite_index=sKamekHit and hitStateTime>0 and life>0
  {
    hitStateTime-=1
    if hitStateTime=0 {sprite_index=sKamekIdle}
  }

  if bActive=true and hitStateTime=0 and life>0
  {
    if sprite_index=sKamekWalk //Walk animation
    {
      walkFrm+=1
      if walkFrm=1 {image_index=0}
      else if walkFrm=7 {image_index=1}
      else if walkFrm=13 {image_index=2}
      else if walkFrm=19 {image_index=1}
      else if walkFrm>=24 {walkFrm=0}
    }

    atkTime+=1
    if moveType=0 //Walk to one end of the room and spawn orbs, walk to other end, spawn orbs, repeat
    {
      if atkTime=15 {sprite_index=sKamekHandsUp}
      else if atkTime=25 //Spawn Spin Orbs
      {
        var tEffect,tAtk;
        tEffect=instance_create(x+(12*image_xscale),y-26,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        if life=5 or life=4
        {
          for(i=0;i<2;i+=1)
          {
            tAtk=instance_create(x+(12*image_xscale),y-26,oKamBounceBall)
            tAtk.atkPower=atkPower; tAtk.type=i; tAtk.myDir=i*180; tAtk.xOrig=x+(12*image_xscale); tAtk.yOrig=y-26; tAtk.projType=0
          }
        }
        else
        {
          for(i=0;i<3;i+=1)
          {
            tAtk=instance_create(x+(12*image_xscale),y-26,oKamBounceBall)
            tAtk.atkPower=atkPower; tAtk.type=i; tAtk.myDir=i*120; tAtk.xOrig=x+(12*image_xscale); tAtk.yOrig=y-26; tAtk.projType=0
          }
        }
      }
      else if atkTime=45
      {
        sprite_index=sKamekIdle
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
      }
      else if atkTime>=60 and atkTime<=999 //Walk to end of room
      {
        sprite_index=sKamekWalk
        x+=moveSpd*image_xscale
        if shockPass>=3 //Middle of the room
        {
          if point_distance(x,0,xCenter,0)<moveSpd {sprite_index=sKamekHandsUp; shockPass=1000; atkTime=1000}
        }
        if (image_xscale=-1 and x<=xCenter-roomSpan+48) or (image_xscale=1 and x>=xCenter+roomSpan-48) //At end of the room
        {
          if life<=3 {shockPass+=1}
          sprite_index=sKamekIdle; atkTime=0
        }
      }
      else if atkTime=1050 //Release Charge
      {
        var tAtk;
        tAtk=instance_create(x,y-32,oPassBullet)
        tAtk.sprite_index=sKamFlame; tAtk.direction=90; tAtk.damageType="ELEMENTAL"
        tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.decayTime=-100
        sprite_index=sKamekIdle
        if x<oPlayer1.x {image_xscale=-1} else {image_xscale=1}
      }
      else if atkTime=1080 //Flames fall
      {
        playSound(global.snd_Fireball,0,0.98,1)
        var tAtk,tXpos;
        tXpos=xCenter-88
        for(i=0;i<maxFlames;i+=1)
        {
          tAtk=instance_create(tXpos,2,oPassBullet)
          tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100
          if maxFlames=3 {tXpos+=88}
          else if maxFlames=5 {tXpos+=44}
        }
        shockPass=0
        atkTime=50
      }
    }
    else if moveType=1 //Move to right side of room and face left
    {
      if atkTime>=1 and atkTime<=199
      {
        sprite_index=sKamekWalk; image_xscale=1
        x+=2
        if x>=xCenter+roomSpan-48
        {
          sprite_index=sKamekIdle; image_xscale=-1
          atkTime=0; moveType=2
        }
      }
    }
    else if moveType=2 //Shadow forms
    {
      if atkTime=30 {sprite_index=sKamekHandsUp; bShadow=1}
      else if atkTime=50 {playSound(global.snd_DemonLaugh,0,1,10000)}
      else if atkTime>=51 and atkTime<=110 {shadowScl+=0.05}
      else if atkTime>=120 {atkTime=0; moveType=3}
    }
    else if moveType=3 //Meteor shower
    {
      if atkTime=1 {sprite_index=sKamekHandsUp}
      else if atkTime>=20 and atkTime<=155 //From top
      {
        if atkTime mod 10=0
        {
          event_user(0)
          meteorSeq+=1
        }
      }
      else if atkTime=170 {meteorSeq=0}
      else if atkTime>=190 and atkTime<=335 //From right
      {
        if atkTime mod 17=0
        {
          event_user(1)
          meteorSeq+=1
        }
      }
      else if atkTime>=350 //Wait time
      {
        meteorSeq=0
        atkTime=0
      }
    }

    if wandState=0 and life<maxLife //----- Spawn Wand -----
    {
      instance_create(x,yGround-158,oKamWand)
      for(i=0;i<20;i+=1)
      {
        var tEffect;
        tEffect=instance_create(oKamWand.x,oKamWand.y,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.15+random(0.05); tEffect.newBlend=-1
        tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
        tEffect.image_xscale=2; tEffect.image_yscale=2
      }
      wandState=2
    }

    //---------- Boss Difficulty Curve ----------
    if bossProgress=0 and life=4
    {
      jeremyText="So something is going on with that Wand. I know Kamek is controlling it, but it's like it has a mind of its own. Kamek is still able to cast spells while the wand does that as well."
      bossProgress+=1
    }
    else if bossProgress=1 and life=3
    {
      bossProgress+=1
    }
    else if bossProgress=2 and life=2
    {
      moveType=1
      bossProgress+=1
    }
    else if bossProgress=3 and life=1
    {
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    atkTime+=1
    if atkTime=1
    {
      bShadow=0
      with oEProjectileBase {instance_destroy()}
    }
    if atkTime mod 5=0
    {
      var tEffect;
      for(i=0;i<6;i+=1)
      {
        tEffect=instance_create(x-12+random(24),bbox_bottom-4-random(sprite_height-8),oKillEffect)
        tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
        tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
      }
    }

    image_alpha-=0.01
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(2)
        global.newMapX=552; global.newMapY=1376; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
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
if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-8
    if platformCharacterIs(IN_AIR)
      other.yAdjust=0
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    if bCanDealDamage=true
    {
      with other
        hitPlayer(other)
    }
  }
  else
  {
    if global.hasAbilToken[0]>=2 and oPlayer1.starmanTime<=0
    {
      var tDmgCheck;
      tDmgCheck=0
      if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
      {
        if oPlayer1.bCanTakeHit=true
        {
          if oPlayer1.dashInvulnerabilityTime=0
            tDmgCheck=1
        }
        else
        {
          if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.yVel>0
            tDmgCheck=1
        }
      }

      if tDmgCheck=1
      {
        with oPlayer1
        {
          if platformCharacterIs(ON_GROUND)
            yVel=-2
          if platformCharacterIs(IN_AIR)
          {
            if oPlayer1.jumpTime<oPlayer1.jumpTimeTotal-5
              oPlayer1.jumpTime=oPlayer1.jumpTimeTotal-5
            if kJump or kUp
              yVel=-13.5
            else
              yVel=-6.5
          }
          scrSlowFall(5,0.4,0)
        }
        //Damage effect
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5
        tFlash.fadeSpeed=0.1
        playSound(global.snd_MarioStomp,0,0.98,1)
        for(i=0;i<9;i+=1)
        {
          tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
          tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
          tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        oPlayer1.canAirDash=1
        oPlayer1.doubleJumpCheck=1
        life-=1 //Damage Boss
        sprite_index=sKamekHit
        bCanTakeDamage=false
        hitStateTime=30
        shockPass=0
        wandState=0
        meteorSeq=0
        with oKamWand {instance_destroy()}
        atkSequence=0
        atkTime=0
        if life=0 //Boss defeat
        {
          sprite_index=sKamekHit
          bCanDealDamage=false
          atkSequence=0
          atkTime=0
        }
      }
    }
    else
    {
      if bCanDealDamage=true
      {
        with other
          hitPlayer(other)
      }
    }
  }
}
else
{
  if bCanDealDamage=true
  {
    with other
      hitPlayer(other)
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Fireball,0,0.92,1)
var tXX;
if meteorSeq=0 {tXX=256}
else if meteorSeq=1 {tXX=288}
else if meteorSeq=2 {tXX=192}
else if meteorSeq=3 {tXX=360}
else if meteorSeq=4 {tXX=224}
else if meteorSeq=5 {tXX=304}
else if meteorSeq=6 {tXX=240}
else if meteorSeq=7 {tXX=320}
else if meteorSeq=8 {tXX=248}
else if meteorSeq=9 {tXX=336}
else if meteorSeq=10 {tXX=168}
else if meteorSeq=11 {tXX=376}
else if meteorSeq=12 {tXX=296}
else if meteorSeq=13 {tXX=232}
else {tXX=360} //Used as a failsafe

//Main
tAtk=instance_create(tXX,2,oPassBullet)
tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

//Sides
tAtk=instance_create(144,2,oPassBullet)
tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
tAtk=instance_create(400,2,oPassBullet)
tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

if meteorSeq mod 4=0
{
  tAtk=instance_create(oPlayer1.x,2,oPassBullet)
  tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
  tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Fireball,0,0.92,1)
var tYY;
if meteorSeq=0 {tYY=272}
else if meteorSeq=1 {tYY=208}
else if meteorSeq=2 {tYY=160}
else if meteorSeq=3 {tYY=244}
else if meteorSeq=4 {tYY=192}
else if meteorSeq=5 {tYY=264}
else if meteorSeq=6 {tYY=224}
else if meteorSeq=7 {tYY=192}
else if meteorSeq=8 {tYY=244}
else if meteorSeq=9 {tYY=208}
else {tYY=244} //Used as a failsafe

//Main
tAtk=instance_create(xCenter+roomSpan+120,tYY,oPassBullet)
tAtk.sprite_index=sKamFlame; tAtk.direction=180; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

if meteorSeq=0 or meteorSeq=8
{
  tAtk=instance_create(xCenter+roomSpan+120,oPlayer1.y-26,oPassBullet)
  tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
  tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShadow=1 //Shadow
{
  draw_sprite_ext(sprite_index,image_index,x,y,-shadowScl,shadowScl*1.25,image_angle,c_black,0.6)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if wandState=2 //Barrier
{
  shieldAnim+=0.2
  draw_sprite_ext(sWaterBarrier,shieldAnim,x,y-21,image_xscale,image_yscale,image_angle,image_blend,0.33)
}

if shockPass=1000 //Fire charge effect
{
  var tEfAlpha,tEfScl;
  if oGame.time mod 2=0 {tEfAlpha=0.4} else {tEfAlpha=0.6}
  if oGame.time mod 3=0 {tEfScl=1} else {tEfScl=1.2}
  draw_sprite_ext(sEfPowerWave,0,x,y,tEfScl,tEfScl,0,c_white,tEfAlpha)
}
