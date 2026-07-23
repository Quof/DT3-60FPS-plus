#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
image_blend=make_color_rgb(100,100,100)

//Enemy base statistics
eName="Enmity"
eLevel=14
maxLife=7200
life=maxLife
atkPower=5
resType[2]=4
resType[1]=2
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bombSpamTime=200
bombSpamDelay=370

rightRegen=0
leftRegen=0

specialAttack=0
specProg=0
specTime=0
specDir=0

secondResistChange=0
//--------------------
moveSpd=0

//Misc Data
xCenter=288
yGround=320
roomSpan=256

deathAnim=0

body=instance_create(x,y,oEnmityBody)
rightBooster=instance_create(x+81,y-30,oEnmityBooster)
leftBooster=instance_create(x-81,y-30,oEnmityBooster); leftBooster.image_xscale=-1
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
    jeremyText="The body can't do too much on its own, but it does control the hands, which I don't think can be stopped. The only attack, aside from the hands that this has are large bombs it scatters. If you're not comfortable with dodging them up top, take safety underneath, just watch for those hands."
    chaoText="This robot looks to be designed to guard this temple, though there doesn't seem to be anything here to guard. The robot was inactive until the Virus infected it and caused it to attack."
    devText="This boss was designed to be a bit easier than Death as it's there to encourage the player to swap in the optimal character and ease them into that concept."
    body.jeremyText=jeremyText; body.chaoText=chaoText; body.devText=devText
    oEnemyBase.image_blend=c_white
    with oEnmityBooster
    {
      jeremyText="These are multi-purpose auxiliary units. They may not have been in their original source, but here they have been modified. The first thing you'll notice is they'll launch off homing missiles, which I might add, are quite a nuisance. Best way I found to handle them would be to get them to propel themselves into a wall. Luckily they don't track around solid objects."
      chaoText="Looks like Jeremy didn't touch on it, but these also have energy stored away in them, which they use to regenerate the body. It's a slow regeneration, but I imagine still bothersome if you leave it alone. Something I'd like to add here. You can destroy ALMOST ALL homing based attacks with explosive damage."
      devText="The original concept for these was to have them rotate and track the player with a laser. Of course the player would avoid them by either dashing through them or standing under the platforms. The missiles served this same purpose better, at least I think so."
      bActive=1
    }
    rightHand=instance_create(x+roomSpan,y,oEnmityHand)
    leftHand=instance_create(x-roomSpan,y,oEnmityHand); leftHand.image_xscale=-1
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack=0
    {
      //-------------------- ATTACK: BOMB SPAM --------------------
      bombSpamTime+=1
      if bombSpamTime>=bombSpamDelay and bombSpamTime<=bombSpamDelay+100
      {
        xSpam=-3-random(0.5)
        bombSpamTime=10000
      }
      else if bombSpamTime>=10001
      {
        if bombSpamTime mod 6=0
        {
          playSound(global.snd_BombLaunch,0,0.92,1)
          var tNewAttack;
          tNewAttack=instance_create(x,y-58,oGravityBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.sprite_index=sEnmityBomb
          tNewAttack.image_speed=0.33; tNewAttack.damageType="EXPLOSION"
          tNewAttack.xVel=xSpam; tNewAttack.yVel=-4

          if bombSpamTime>=10001 and bombSpamTime<=10100
          {
            xSpam+=1.3+random(0.2)
            if xSpam>=4 {bombSpamTime=10100}
          }
          else if bombSpamTime>=10101 and bombSpamTime<=10200
          {
            xSpam-=1.3-random(0.2)
            if xSpam<=-4 {bombSpamTime=0}
          }
        }
      }

      //-------------------- UTILITY: BOOSTER REGENERATION --------------------
      if instance_exists(rightBooster) or instance_exists(leftBooster)
      {
        if oGame.time mod 2=0
        {
          if life<maxLife {life+=1}
        }
      }

      if !instance_exists(rightBooster)
      {
        rightRegen+=1
        if rightRegen>=2000
        {
          rightRegen=0
          rightBooster=instance_create(x+81,y-30,oEnmityBooster)
          rightBooster.image_blend=c_white
          rightBooster.bActive=1
          playSound(global.snd_LightballSpread,0,0.94,18000)
          var tEffect;
          tEffect=instance_create(x+81,y-30,oEffect)
          tEffect.sprite_index=sMMchargeComplete
          tEffect.image_speed=0.5; tEffect.image_xscale=3; tEffect.image_yscale=3
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      if !instance_exists(leftBooster)
      {
        leftRegen+=1
        if leftRegen>=2000
        {
          leftRegen=0
          leftBooster=instance_create(x-81,y-30,oEnmityBooster); leftBooster.image_xscale=-1
          leftBooster.image_blend=c_white
          leftBooster.bActive=1
          playSound(global.snd_LightballSpread,0,0.94,18000)
          var tEffect;
          tEffect=instance_create(x-81,y-30,oEffect)
          tEffect.sprite_index=sMMchargeComplete
          tEffect.image_speed=0.5; tEffect.image_xscale=3; tEffect.image_yscale=3
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
    }

    //-------------------- SUPER ATTACK: MISSILE SPAM --------------------
    if specialAttack=1
    {
      bombSpamTime=bombSpamDelay-90
      oEnmityHand.bCanDealDamage=false
      oEnmityHand.image_blend=make_color_rgb(100,100,100)
      if rightHand.atkProg=1 and rightHand.ceilingAtk=0
      {
        rightHand.atkTime=0
        rightHand.atkProg=2
      }
      if leftHand.atkProg=1 and leftHand.ceilingAtk=0
      {
        leftHand.atkTime=0
        leftHand.atkProg=2
      }

      var tEffect;
      for(i=0;i<20;i+=1)
      {
        tEffect=instance_create(384+random(64),224+random(16),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.15+random(0.15)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(128+random(64),224+random(16),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.15+random(0.15)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }

      tile_layer_hide(999999)
      with (209516) {instance_destroy()}
      with (209517) {instance_destroy()}
      specialAttack=2
    }
    else if specialAttack=2
    {
      specTime+=1
      if specTime=60
      {
        var tMissile;
        tMissile=instance_create(x+36,y-12,oEnmityMissile)
        tMissile.atkPower=atkPower; tMissile.targetTime=20
        tMissile.direction=30+specDir
        tMissile=instance_create(x-36,y-12,oEnmityMissile)
        tMissile.atkPower=atkPower; tMissile.targetTime=20
        tMissile.direction=150-specDir
        specDir+=20
        specProg+=1
        if specProg<5 {specTime-=10}
        else
        {
          specDir=0
          specProg=0
          specTime=61
        }
      }
      else if specTime=200
      {
        for(i=0;i<3;i+=1)
        {
          var tMissile;
          tMissile=instance_create(x+36,y-12,oEnmityMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20
          tMissile.direction=i*120
          tMissile=instance_create(x-36,y-12,oEnmityMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20
          tMissile.direction=i*120+60
        }
        specProg+=1
        if specProg<2 {specTime-=100}
        else
        {
          specDir=0
          specProg=0
          specTime=201
        }
      }
      else if specTime=360
      {
        var tMissDir;
        tMissDir=0
        for(i=0;i<12;i+=1)
        {
          var tMissile;
          tMissile=instance_create(x,y,oEnmityMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=10
          tMissile.direction=tMissDir
          tMissDir+=360/12
        }
      }
      else if specTime=490
      {
        oEnmityHand.bCanDealDamage=true
        oEnmityHand.image_blend=c_white
        tile_layer_show(999999)
        var tEffect,tNewSolid;
        for(i=0;i<20;i+=1)
        {
          tEffect=instance_create(384+random(64),224+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1; tEffect.image_yscale=1
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect=instance_create(128+random(64),224+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1; tEffect.image_yscale=1
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        tNewSolid=instance_create(384,224,oInvisibleSolid); tNewSolid.image_xscale=4
        tNewSolid=instance_create(128,224,oInvisibleSolid); tNewSolid.image_xscale=4
        specialAttack=0
      }
    }

    if secondResistChange>=1 and secondResistChange<=99
    {
      secondResistChange+=1
      if secondResistChange=40
      {
        var tAtkShield;
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
        tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=2; tAtkShield.atkUp=1
        resType[2]=3; oEnmityBody.resType[2]=3
        secondResistChange=100
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      bombSpamDelay-=10
      oEnmityHand.atkDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=1
    {
      bombSpamDelay-=10
      oEnmityHand.atkDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=2
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
      resType[0]=2; oEnmityBody.resType[0]=2
      secondResistChange=1
      oEnmityHand.moveSpd+=1
      oEnmityHand.atkDelay-=15
      specialAttack+=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=3
    {
      bombSpamDelay-=10
      oEnmityHand.atkDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
      resType[1]=1; oEnmityBody.resType[1]=1
      bombSpamDelay-=10
      oEnmityHand.atkDelay-=15
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
    if global.bBossGallery=1
    {
      bossRoomTally(16)
      global.newMapX=2760; global.newMapY=1024; room_goto(rBossGallery)
    }
    else
    {
      sprite_index=sEnmityBody
      with oEnmityBody {instance_destroy()}
      with oEnmityBooster {instance_destroy()}
      with oEnmityHand {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}

      global.gamePaused=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      oPlayer1.visible=0; oPlayer1.x=xCenter; oPlayer1.y=yGround

      mashingButtons=instance_create(0,0,oMashButtons)
      mashingButtons.xCenter=288; mashingButtons.yCenter=192
      mashingButtons.startJerryX=416; mashingButtons.startJerryY=224
      mashingButtons.startClaireX=160; mashingButtons.startClaireY=224
    }
  }
  else if deathAnim=15
  {
    msgCreate(0,0,"Jerry","Ready Claire?",0,0,oMessagePerson,0)
    newMessage.fadingTime=45
  }
  else if deathAnim=65
  {
    msgCreate(0,0,"Claire","Let's do this!",0,0,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if deathAnim=120
  {
    mashingButtons.bCanHit=1
  }
  else if deathAnim>=130 and deathAnim<=140
  {
    if deathAnim=135 {deathAnim=130}

    if mashingButtons.timeToStop<=0
    {
      global.gamePaused=false
      mashingButtons.bCanHit=2
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
      oPlayer1.visible=1
      deathAnim=150
    }
  }
  else if deathAnim>=151 and deathAnim<=210
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
  else if deathAnim>=211
  {
    instance_destroy()
  }
}
