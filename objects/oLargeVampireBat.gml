#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15

//Enemy base statistics
eName="Large Vampire Bat"
eLevel=10
maxLife=2600
life=maxLife
atkPower=5
resType[1]=4
resType[4]=4
resType[5]=2
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

atkProg=0
atkTime=5
atkDelay=64
atkNum=0
atkFreq=19

movePlace=0
moveSpd=0

deathAnim=0

jeremyText="This large bat waits a moment while it gets a target on you, then after a moment, it will strike the spot you are in at that moment. It has a few more tricks up its... err, wing, but nothing you can't handle."
chaoText="It actually works a lot like the original Castlevania boss in the first level. There's a few differences obviously from the Virus take over."
devText="For the first boss of the Gate, I didn't want something too difficult as it's Claire's first few moments with melee combat. It couldn't be too easy either since this is a decent amount of hours into the game. The result is this guy, something that would possibly beat the player only a few times. Plus the giant bat was the first boss encounter of the Castlevania series..."
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

  if bActive=true and life>0
  {
    if atkProg=0 //Wait time
    {
      atkTime+=1
      if atkTime=atkDelay-20
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      if atkTime=atkDelay-15 and bossProgress>=1
      {
        playSound(global.snd_Fireball,0,0.95,29000)
        var tFire,tFireDir,tFireAmt;
        tFireDir=player_sprite_center()
        tFireAmt=1
        if bossProgress>=2
        {
          tFireDir-=25
          tFireAmt=3
        }
        for(i=0;i<tFireAmt;i+=1)
        {
          tFire=instance_create(x,y,oPassBullet)
          tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.bulletSpeed=4
          tFire.direction=tFireDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
          tFireDir+=25
        }
      }

      if atkTime>=atkDelay
      {
        if bossProgress>=3
        {
          var tFire,tFireDir;
          tFireDir=player_sprite_center()
          tFireDir-=13
          for(i=0;i<2;i+=1)
          {
            tFire=instance_create(x,y,oPassBullet)
            tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.bulletSpeed=4
            tFire.direction=tFireDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
            tFireDir+=26
          }
        }
        targetSpotX=oPlayer1.x; targetSpotY=returnPlayerYCenter()
        moveDir=point_direction(x,y,targetSpotX,targetSpotY)
        moveSpd=6
        atkTime=0; atkProg=1
      }
    }
    else if atkProg=1 //Attack
    {
      speed=moveSpd
      direction=moveDir
      if point_distance(x,y,targetSpotX,targetSpotY)<12
      {
        atkNum+=1
        if atkNum mod 3=0
        {
          targetSpotX=1936
          targetSpotY=128
          moveSpd=5
        }
        else
        {
          if movePlace=0 {targetSpotX=1648; targetSpotY=112}
          else if movePlace=1 {targetSpotX=1792; targetSpotY=176}
          else if movePlace=2 {targetSpotX=1936; targetSpotY=112}
          else if movePlace=3 {targetSpotX=1648; targetSpotY=176}
          else if movePlace=4 {targetSpotX=1792; targetSpotY=112}
          movePlace+=1
          if movePlace>=5 {movePlace=0}
          moveSpd=3
        }
        moveDir=point_direction(x,y,targetSpotX,targetSpotY)
        atkProg=2
      }
    }
    else if atkProg=2 //Return
    {
      speed=moveSpd
      direction=moveDir
      if point_distance(x,y,targetSpotX,targetSpotY)<12
      {
        speed=0
        if atkNum mod 3=0 {atkProg=3}
        else {atkProg=0}
      }
    }
    else if atkProg=3 //Shoot fire from side
    {
      atkTime+=1
      if atkTime=1 {direction=270}
      if atkTime>=15
      {
        speed=5
        if y>=304 {direction=90}
        else if y<=112 {direction=270}
      }

      if atkTime mod atkFreq=0
      {
        playSound(global.snd_Fireball,0,0.95,32000)
        tFire=instance_create(x,y,oPassBullet)
        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.bulletSpeed=4
        tFire.direction=180; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
      }

      if atkTime mod atkFreq*2=0
      {
        var tFire,tFireDir;
        tFireDir=player_sprite_center()
        tFire=instance_create(x,y,oPassBullet)
        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.bulletSpeed=4
        tFire.direction=tFireDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
      }

      if atkTime>=120
      {
        direction=90
        atkTime=0; atkProg=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.82 and lifePercent>=0.68 and bossProgress=0
    {
      atkDelay-=3
      bossProgress+=1
    }
    else if lifePercent<=0.67 and lifePercent>=0.51 and bossProgress=1
    {
      atkDelay-=4
      atkFreq-=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.29 and bossProgress=2
    {
      atkDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.28 and lifePercent>=0 and bossProgress=3
    {
      atkDelay-=5
      atkFreq-=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      speed=0
      with oPassBullet
        instance_destroy()
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(10)
        global.newMapX=2280; global.newMapY=1312; room_goto(rBossGallery)
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
else
  speed=0
