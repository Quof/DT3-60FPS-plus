#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
image_xscale=-1

//Enemy base statistics
eName="Arachnus"
eLevel=23
maxLife=3750
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
behavior=0
progTime=0
progDelay=150

runSpd=2.75
bWalkNormal=1

rollDir=0 //0-Left; 1-Up; 2-Right; 3-Down
rollSpd=11
turnCur=0
turnMax=5
bHitCorner=0

bLavaRise=0
stepCount=pi

otherColor=255

//Misc Data
xCenter=240
yGround=256
roomSpan=144

deathAnim=0

myShell=instance_create(x,y,oArachnusShell)
myShell.image_xscale=1.5
myShell.image_yscale=3
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
    jeremyText="The first thing you'll notice is it stands up and roars. When this happens, he's going to swing and create a wave of energy. Immediately after, he curls into a ball and will begin to zip around the edges of the room. You'll be on the defensive till he stops, though I am seeing an odd behavior with the spin that he may use at some point. There's not much to say, it's an easy pattern he has."
    chaoText="This is an optional boss fight in the Game Boy game, 'Metroid 2: Return of Samus', which would earn you the Spring Ball upgrade. It was later seen as the first boss fight in Metroid Fusion. In the Game Boy version, it could only be damaged by bombs."
    devText="Arachnus was planned to be the easiest of the 3 bosses in Gate 5. (At least Pre-Tourian) However, I feel he turned out the most challenging. Like the path to Kraid, Arachnus was also originally able to be fought earlier, but due to the fight almost requiring the air dash, he was moved."
    with oKraidParts
    {
      jeremyText=oKraid.jeremyText
      chaoText=oKraid.chaoText
      devText=oKraid.devText
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if sprite_index=sArachnusIdle or sprite_index=sArachnusWalk
    {
      bCanTakeDamage=true
      myShell.bCanTakeDamage=true
      myShell.bCanDealDamage=true
      if bWalkNormal=1
      {
        if x<oPlayer1.x {image_xscale=1} else {image_xscale=-1}
      }
      else
      {
        if x>oPlayer1.x {image_xscale=1} else {image_xscale=-1}
      }
    }
    else if sprite_index=sArachnusSwingPrep
    {
      bCanTakeDamage=true
      myShell.bCanTakeDamage=false
      myShell.bCanDealDamage=false
    }
    else
    {
      bCanTakeDamage=false
      myShell.bCanTakeDamage=false
      myShell.bCanDealDamage=false
    }

    progTime+=1
    if behavior=0 //Roar and create energy wave
    {
      if progTime=20
      {
        if bLavaRise=1 {bLavaRise=2} //Only start lava rise phase when he roars before the energy wave to make sure it's not at a weird interval
        playSound(global.snd_KraidRoarA,0,1,68000)
        sprite_index=sArachnusSwingPrep
      }
      else if progTime=45
      {
        sprite_index=sArachnusIdle
        var tEffect;
        for(i=0;i<12;i+=1)
        {
          tEffect=instance_create(x+random_range(-24,24),y+random(8),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        var tAtk;
        tAtk=instance_create(x+(4*image_xscale),y-24,oPassBullet)
        tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.decayTime=-100
        if image_xscale=1 {tAtk.direction=0}
        else {tAtk.direction=180}
        progTime=0; behavior+=1
      }
    }
    else if behavior=1 //Go into shell
    {
      if progTime=15
      {
        sprite_index=sArachnusIntoBall
        image_speed=0; image_index=0
      }
      else if progTime=17 {image_index=1}
      else if progTime=19 {image_index=2}
      else if progTime=21 {image_index=3}
      else if progTime=23 {sprite_index=sArachnusBall; image_index=0}
      else if progTime=30 {image_speed=0.5}
      else if progTime=40
      {
        if image_xscale=1 {rollDir=2}
        else {rollDir=0}
        progTime=0; behavior+=1
      }
    }
    else if behavior=2 //Roll around edges
    {
      if rollDir=0 //Left
      {
        x-=rollSpd
        if x<=xCenter-roomSpan+16
        {
          x=xCenter-roomSpan+16
          bHitCorner=1; turnCur+=1
          if y<yGround-96 {rollDir=3}
          else {rollDir=1}
        }
      }
      else if rollDir=1 //Up
      {
        y-=rollSpd
        if y<=yGround-176
        {
          y=yGround-176
          bHitCorner=1; turnCur+=1
          if x<xCenter {rollDir=2}
          else {rollDir=0}
        }
      }
      else if rollDir=2 //Right
      {
        x+=rollSpd
        if x>=xCenter+roomSpan-16
        {
          x=xCenter+roomSpan-16
          bHitCorner=1; turnCur+=1
          if y<yGround-96 {rollDir=3}
          else {rollDir=1}
        }
      }
      else if rollDir=3 //Down
      {
        y+=rollSpd
        if y>=yGround
        {
          y=yGround
          bHitCorner=1; turnCur+=1
          if x<xCenter {rollDir=2}
          else {rollDir=0}
        }
      }
      
      if bHitCorner=1 //Projectile when corner is hit
      {
        bHitCorner=0
        if bossProgress=0
        {
          var tAtk;
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)
        }
        else if bossProgress=3 or bossProgress=4 or bossProgress=5
        {
          var tAtk;
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)-10
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)+10
        }
        else if bossProgress=1 or bossProgress=2 or bossProgress=6 or bossProgress=7
        {
          var tAtk;
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)-10
          tAtk=instance_create(x,y-16,oPassBullet)
          tAtk.sprite_index=sArachnusEnergyWave; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=-100
          tAtk.image_xscale=0.3; tAtk.image_yscale=0.3
          tAtk.direction=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-26)+10
        }
      }
      
      if turnCur>=8 and turnMax=100 //Turn red
      {
        if otherColor>100 {otherColor-=2}
        if otherColor<200
        {
          tEffect=instance_create(x+random_range(-16,16),y+random(32),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        
        baseColor=make_color_rgb(255,otherColor,otherColor)
        image_blend=baseColor
        turnCur=50
      }
      else if turnCur>=50 and turnCur<=60 {turnCur=50}
      
      if turnCur>=turnMax and turnMax<100 //End roll attack
      {
        if y=yGround
        {
          var tDistCheck;
          tDistCheck=point_distance(x,0,xCenter,0)
          if tDistCheck<=16
          {
            sprite_index=sArachnusIdle
            image_speed=0.2
            turnCur=0
            progTime=0; behavior+=1
          }
        }
      }
    }
    else if behavior=3 //Walk around
    {
      if y<yGround {y+=2}
      
      if progTime=25
      {
        sprite_index=sArachnusWalk
        image_speed=0; image_index=0
      }
      else if progTime>=26 and progTime<=60 //Walk forward
      {
        image_speed=runSpd/4
        x+=runSpd*image_xscale
      }
      else if progTime=61
      {
        sprite_index=sArachnusIdle
        image_speed=0.2
      }
      else if progTime>=80 and progTime<=110 //Run forward
      {
        image_speed=runSpd/2
        x+=(runSpd*2)*image_xscale
      }
      else if progTime=111
      {
        sprite_index=sArachnusIdle
        image_speed=0.2
        bWalkNormal=0
      }
      else if progTime>=130 and progTime<=195 //Walk backward
      {
        image_speed=0
        image_index-=runSpd/4
        x+=runSpd*-image_xscale
      }
      else if progTime=196
      {
        sprite_index=sArachnusIdle
        image_speed=0.2
      }
      else if progTime=215
      {
        bWalkNormal=1
        progTime=0; behavior=0
      }
    }
    
    //Lava control
    if bLavaRise=2
    {
      stepCount+=pi/33
      (288153).y+=sin(stepCount)*1.9
    }
    else
    {
      if (288153).y<290 {(288153).y+=2}
    }
    
    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.77 and bossProgress=0
    {
      rollSpd+=1
      bossProgress+=1
    }
    else if lifePercent<=0.76 and lifePercent>=0.65 and bossProgress=1
    {
      rollSpd+=1
      bossProgress+=1
    }
    else if lifePercent<=0.64 and lifePercent>=0.5 and bossProgress=2
    {
      rollSpd+=1
      turnMax+=4
      bLavaRise=1
      bossProgress+=1
    }
    else if lifePercent<=0.49 and lifePercent>=0.38 and bossProgress=3
    {
      rollSpd+=1
      bossProgress+=1
    }
    else if lifePercent<=0.37 and lifePercent>=0.21 and bossProgress=4
    {
      rollSpd+=1
      turnMax+=4
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.1 and bossProgress=5
    {
      jeremyText="When his shell is really hot from rolling so much, it looks like you'll need to use something to blow him out of it."
      turnMax=100
      bLavaRise=0
      bossProgress+=1
    }
    else if lifePercent<=0.09 and lifePercent>=0 and bossProgress=6
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      with oEnemyBase {resType[5]=2}
      bossProgress+=1
    }
    
    if image_xscale=1 {myShell.x=x-23}
    else {myShell.x=x-2}
    myShell.y=y-47
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      bCanDealDamage=false
      with myShell {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x-24+random(48),y-random(48),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(30)
        global.newMapX=792; global.newMapY=848; room_goto(rBossGallery)
      }
      else
      {
        oEvCh13MainA.sceneProgress=1
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
if life>0 {redDmgHit(0)}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if other.damageType="EXPLOSION"
{
  if turnCur>=8 and turnMax=100 and y=yGround
  {
    playSound(global.snd_KraidRoarA,0,1,78000)
    sprite_index=sArachnusIdle
    image_speed=0.2
    baseColor=c_white
    image_blend=baseColor
    otherColor=255
    turnCur=0
    progTime=0; behavior=3
  }
}
