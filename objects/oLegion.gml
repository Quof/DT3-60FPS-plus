#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
bCanDealDamage=false

//Enemy base statistics
eName="Death (Legion)"
eLevel=12
maxLife=7400
life=maxLife
atkPower=5
resType[1]=4
resType[2]=5
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0

//-- Movement Data --
moveSpd=0.5
moveCycle=0
stepCount=pi/2

//-- Attack Data --
scytheCircleTime=0
scytheCircleDelay=300
bigScytheTime=180
bigScytheDelay=270
bigScytheProg=0

//-- Misc Data --
xCenter=304
yGround=304
roomSpan=304

efFlyTime=0

deathAnim=0

jeremyText="The main thing you need to watch out for here are those spears. They constantly rotate and at set intervals, will stop and shoot out. At times, he summons a large menacing scythe at the top of the room, it hangs in the air for a bit and then it comes straight down. The rest of his attacks you're gonna have to use your wits depending on the situation to figure in the best dodging route."
chaoText="Death has called on the power of Legion to fight you now. At this point, Death isn't as focused. This shouldn't be as rough as his other phase, but don't take him TOO lightly."
devText="Final bosses in Castlevania games usually had two phases and that was usually for Dracula. Since he didn't have that second phase here, I figured Death would be a good candidate for that. His first phase, I know, is quite difficult and takes a lot of observation of what Death is doing. Seeing him form into something else I'm sure would make the fight feel even more daunting. There's a sense of dread I'm sure players would feel the first time on this."
extraInfo="Very vulnerable to Elemental damage."
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
    activateBoss=2
    bCanDealDamage=true
    //-- Spear Data --
    var tSetDir; tSetDir=0
    for(i=0;i<12;i+=1)
    {
      newSpear[i]=instance_create(x,y,oLegionSpear)
      newSpear[i].baseDir=tSetDir
      newSpear[i].stabTime=i*30
      tSetDir+=360/12
    }
    image_xscale=1.5
    image_yscale=1.5
  }

  if bActive=true and life>0
  {
    //---------- MOVEMENT ----------
    if moveCycle=0 //Right
    {
      x+=moveSpd
      if x>=(xCenter+roomSpan)-(sprite_width/2)-16 {moveCycle=1}
    }
    else if moveCycle=1 //Left
    {
      x-=moveSpd
      if x<=(xCenter-roomSpan)+(sprite_width/2)+16 {moveCycle=0}
    }
    stepCount+=pi/60
    y+=sin(stepCount)

    efFlyTime+=1
    if efFlyTime mod 3=0
    {
      var tEffect,tEfDist,tEfDir;
      tEfDist=random(56)*image_xscale
      tEfDir=random(360)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sLegionFly; tEffect.x=x+lengthdir_x(tEfDist,tEfDir); tEffect.y=y+lengthdir_y(tEfDist,tEfDir)
      tEffect.image_speed=0.5; tEffect.decay=6+irandom(4)
      tEffect.xSpd=(2+random(1))*choose(-1,1); tEffect.ySpd=(2+random(1))*choose(-1,1)
      tEffect.newBlend=-1; tEffect.followID=-1
    }

    //---------- ATTACK: SCYTHE CIRCLE ----------
    scytheCircleTime+=1
    if scytheCircleTime>=scytheCircleDelay
    {
      playSound(global.snd_OrbThrow,0,0.97,20000)
      var tAtkScythe,tAtkDir,tAtkSpawnDir;
      tAtkDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
      tAtkSpawnDir=0
      for(i=0;i<16;i+=1)
      {
        tAtkScythe=instance_create(x,y,oDeathFlyingScythe)
        tAtkScythe.x=x+lengthdir_x(80,tAtkSpawnDir); tAtkScythe.y=y+lengthdir_y(80,tAtkSpawnDir)
        tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=5; tAtkScythe.direction=tAtkDir
        tAtkSpawnDir+=360/16
      }
      scytheCircleTime=0
    }

    //---------- ATTACK: BIG SCYTHE ----------
    bigScytheTime+=1
    if bigScytheTime>=bigScytheDelay
    {
      playSound(global.snd_DeathSlash,0,0.97,14000)
      var tAtkScythe;
      if bigScytheProg<3
      {
        tAtkScythe=instance_create(160+(144*bigScytheProg),48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
      }
      else if bigScytheProg=3
      {
        tAtkScythe=instance_create(232,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
        tAtkScythe=instance_create(376,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
      }
      else if bigScytheProg=4
      {
        tAtkScythe=instance_create(32,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
        tAtkScythe=instance_create(96,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
        tAtkScythe=instance_create(512,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
        tAtkScythe=instance_create(576,48,oLegionScythe)
        tAtkScythe.atkPower=atkPower; tAtkScythe.direction=270
      }

      bigScytheProg+=1
      if bigScytheProg=5 {bigScytheProg=0}
      bigScytheTime=0
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
    {
      scytheCircleDelay-=10
      bigScytheDelay-=15
      bossProgress+=1
    }
    image_xscale=0.5+lifePercent
    image_yscale=0.5+lifePercent
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      bCanDealDamage=false
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5
        tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(14)
        global.newMapX=2856; global.newMapY=1312; room_goto(rBossGallery)
      }
      else
      {
        oEvCh6MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTakingDamage=false and other.bCanDealDamage=true and bActive=true
{
  var tEffect,txSpd,tLen,tDir;
  for(i=0;i<4;i+=1)
  {
    txSpd=random_range(-3,3)
    tLen=random(60)
    tDir=random(360)
    tEffect=instance_create(x,y,oEffectGrav)
    tEffect.x=x+lengthdir_x(tLen,tDir); tEffect.y=y+lengthdir_y(tLen,tDir); tEffect.type=2
    tEffect.sprite_index=sLegionBones; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.fadeSpd=0.015
    tEffect.xSpd=txSpd; tEffect.ySpd=-4-random(3); tEffect.grav=0.4; tEffect.rotation=-8*txSpd
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
  }
}
event_inherited()
