#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanTakeDamage=0

//Enemy base statistics
eName="Barba"
eLevel=6
maxLife=2800
life=maxLife
atkPower=6
resType[1]=2
resType[4]=4
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

atkSpot[0]=288
atkSpot[1]=392
atkSpot[2]=512

for(i=0;i<11;i+=1)
{
  bossBody[i]=instance_create(x,y+16+(i*16),oBarbaBody)
  bossBody[i].waveOffset=i*0.3
}
animDelay=0

atkNum=0
atkCycle=5
atkTime=-20
atkDelay=55
atkType=0
riseHeight=16
sprayDir=0
fireballStorm=0

currentSeq=0
appearSequence[0]=2
appearSequence[1]=0
appearSequence[2]=1
appearSequence[3]=0
appearSequence[4]=2
appearSequence[5]=1
appearSequence[6]=0

deathAnim=0

jeremyText="This thing works fairly close to the original Barba. He sometimes pops in low to blow some fire at ground level across the room. You'll need to react quick to that since he fires almost immediately after popping up."
chaoText="At lower HP, it'll start pulling fire out of the lava as it rises. Try not to be too close to the sides or you'll be hit by the oncoming fireballs."
devText="Originally this was going to be exactly the fight it was in Zelda 2, but that's not very good for DT. In the demo version, he was closer to the original than it is now."
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
    x+=sin(oGame.time/2.5)
    if atkCycle=0 //-------------------- Choose location --------------------
    {
      var nextSpotX;
      nextSpotX=atkSpot[appearSequence[currentSeq]]
      currentSeq+=1
      if currentSeq>=7 {currentSeq=0}
      x=nextSpotX
      for(i=0;i<11;i+=1)
      {
        bossBody[i].x=nextSpotX
      }
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      atkCycle+=1
      atkType+=1
      if atkType>=4 {atkType=1}
    }
    else if atkCycle=1 //-------------------- Rise up --------------------
    {
      y-=8
      for(i=0;i<11;i+=1)
      {
        bossBody[i].y-=8
      }
      atkTime+=1
      if atkTime=1
      {
        bCanTakeDamage=1
        if bossProgress>=4 {fireballStorm=1}
        playSound(global.snd_ShipMovement,0,0.98,41000)
        playSound(global.snd_Splash,0,0.94,36000)
      }
      if atkTime=5 and bossProgress>=2 //Rise fire
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oGravBulletAlt)
        tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
        tNewAttack.xVel=2; tNewAttack.yVel=-9; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        tNewAttack=instance_create(x,y,oGravBulletAlt)
        tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
        tNewAttack.xVel=-2; tNewAttack.yVel=-9; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        if bossProgress>=4
        {
          tNewAttack=instance_create(x,y,oGravBulletAlt)
          tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
          tNewAttack.xVel=4; tNewAttack.yVel=-10; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
          tNewAttack=instance_create(x,y,oGravBulletAlt)
          tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
          tNewAttack.xVel=-4; tNewAttack.yVel=-10; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        }
      }

      if atkType=1 //Normal attack
      {
        if atkTime>=riseHeight
        {
          atkTime=0
          atkCycle+=1
        }
      }
      else if atkType=2 //Line attack
      {
        if atkTime>=11
        {
          atkTime=0
          atkCycle+=1
        }
      }
      else if atkType=3 //Spray attack
      {
        if atkTime>=25
        {
          atkTime=0
          atkCycle+=1
        }
      }
    }
    else if atkCycle=2 //-------------------- Wait time --------------------
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      atkTime+=1
      if atkType=2
      {
        if bossProgress>=3 {atkTime+=5}
        else {atkTime+=2}
      }

      if atkTime>=atkDelay
      {
        animDelay+=1
        if animDelay=1 {image_index=1}
        else if animDelay=4 {image_index=2}
        else if animDelay=8
        {
          animDelay=0
          atkTime=0
          atkCycle+=1
        }
      }
    }
    else if atkCycle=3 //-------------------- Fire attack --------------------
    {
      atkTime+=1
      if atkTime>=1 and atkTime<=18
      {
        if atkTime=1
        {
          playSound(global.snd_FireLoop,0,1,1)
          if image_xscale=1 {sprayDir=40}
          else {sprayDir=140}
        }

        if atkTime mod 2=0
        {
          var tFire;
          tFire=instance_create(x+(12*image_xscale),y,oBarbaFire)
          if image_xscale=1
          {
            if atkType=1 {tFire.direction=298+random(4)}
            else if atkType=2 {tFire.direction=358+random(4)}
          }
          else
          {
            if atkType=1 {tFire.direction=238+random(4)}
            else if atkType=2 {tFire.direction=178+random(4)}
          }

          if atkType=3
          {
            tFire.direction=sprayDir
            tFire.bulletSpeed=5
            sprayDir+=15*-image_xscale
          }
          else {tFire.bulletSpeed=9}
        }
      }
      else if atkTime=19 {image_index=1}
      else if atkTime=23 {image_index=0}
      else if atkTime=30 {atkTime=0; atkCycle+=1}
    }
    else if atkCycle=4 //-------------------- Drop down --------------------
    {
      y+=8
      if atkTime=0
      {
        playSound(global.snd_ShipMovement,0,0.93,42000)
        playSound(global.snd_Splash,0,0.9,13000)
        atkTime=1
      }
      else if atkTime=1 and y>=336 and bossProgress>=3 //Drop fire
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oGravBulletAlt)
        tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
        tNewAttack.xVel=2; tNewAttack.yVel=-9; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        tNewAttack=instance_create(x,y,oGravBulletAlt)
        tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
        tNewAttack.xVel=-2; tNewAttack.yVel=-9; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        if bossProgress>=4
        {
          tNewAttack=instance_create(x,y,oGravBulletAlt)
          tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
          tNewAttack.xVel=4; tNewAttack.yVel=-10; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
          tNewAttack=instance_create(x,y,oGravBulletAlt)
          tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0; tNewAttack.damageType="ELEMENTAL"
          tNewAttack.xVel=-4; tNewAttack.yVel=-10; tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
        }
        atkTime=2
      }

      for(i=0;i<11;i+=1)
      {
        bossBody[i].y+=8
      }
      if y>=room_height {bCanTakeDamage=0; atkTime=0; atkCycle+=1}
    }
    else if atkCycle=5 //-------------------- Short wait --------------------
    {
      atkTime+=1
      if atkTime>=20
      {
        atkTime=0
        atkCycle=0
      }
    }

    if fireballStorm>=1 //-------------------- ATTACK: FIREBALL STORM --------------------
    {
      fireballStorm+=1
      var tFire;
      for(i=0;i<2;i+=1)
      {
        tFire=instance_create(x+random_range(-20,20),336+random(4),oBarbaFire)
        tFire.direction=random_range(89,91); tFire.bulletSpeed=10+random(2)
      }

      if fireballStorm>=50 {fireballStorm=0}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.89 and lifePercent>=0.74 and bossProgress=0
    {
      atkDelay-=4
      riseHeight+=1
      bossProgress+=1
    }
    else if lifePercent<=0.73 and lifePercent>=0.55 and bossProgress=1
    {
      atkDelay-=4
      riseHeight+=1
      bossProgress+=1
    }
    else if lifePercent<=0.54 and lifePercent>=0.37 and bossProgress=2
    {
      atkDelay-=4
      riseHeight+=2
      bossProgress+=1
    }
    else if lifePercent<=0.36 and lifePercent>=0 and bossProgress=3
    {
      atkDelay-=4
      riseHeight+=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oPassBullet {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height)+random(sprite_height*8),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(5)
        global.newMapX=1160; global.newMapY=1376; room_goto(rBossGallery)
      }
      else
      {
        oEvCh4MainA.sceneProgress=1
        with oBarbaBody {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
