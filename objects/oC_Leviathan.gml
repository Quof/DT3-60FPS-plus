#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=-1
bActive=1
bDamageFlash=0

//Enemy base statistics
eName="Leviathan"
eLevel=26
maxLife=9500
life=maxLife
atkPower=6
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0

moveProg=0
moveTime=0
otherAtkTime=0
fishTime=450
fishDelay=600
finalSection=0

deathAnim=0

jeremyText="Just shoot it down. Oh yeah, this is huge, and has a lot of guns."
chaoText="The sprite comes from the game ' Jim Powers: The Arcade Game' for the Sega Genesis. All of the sprites for this did, except for the Small Bot."
devText="This seemed like the best way to have the characters leave the city. On top of that, I wanted something where both characters could be represented, as I like when both characters are utilized together. The bike(truck) section itself is only meant to be more of a simple shooter."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    fishTime+=1
    if fishTime>=fishDelay
    {
      tNewEnemy=instance_create(-48,288,oCHAOS_FishBot)
      tNewEnemy.yThres=0
      fishTime=0
    }

    moveTime+=1
    otherAtkTime+=1
    if moveProg=0 //--------------------------------------------------------------------------------
    {
      if x>384 {x-=2}
      if moveTime mod 45=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+27,y+146,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+27,y+147,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
      }
      if lifePercent<=0.9 {fishDelay=570; moveTime=0; otherAtkTime=0; moveProg+=1}
    }
    else if moveProg=1 //--------------------------------------------------------------------------------
    {
      if x>80 {x-=2}
      if moveTime mod 50=0
      {
        var tNewAttack,tDir;
        tDir=point_direction(x+98,y+57,oPlayer1.x,oPlayer1.y-26)
        tDir-=20
        for(i=0;i<3;i+=1)
        {
          tNewAttack=instance_create(x+98,y+57,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=tDir
          tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
          tDir+=20
        }
      }
      if moveTime mod 60=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+300,y+54,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+300,y+54,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
      }
      if lifePercent<=0.7 {fishDelay=540; moveTime=0; otherAtkTime=0 moveProg+=1}
    }
    else if moveProg=2 //--------------------------------------------------------------------------------
    {
      if x>-110 {x-=2}
      if moveTime=40
      {
        var tNewAttack;
        tNewAttack=instance_create(x+271,y+109,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+261,y+109,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
      }
      else if moveTime=50
      {
        var tNewAttack;
        tNewAttack=instance_create(x+303,y+93,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+293,y+93,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
      }
      else if moveTime=60
      {
        var tNewAttack;
        tNewAttack=instance_create(x+335,y+109,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+325,y+109,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        moveTime=0
      }
      if otherAtkTime>=160
      {
        var tNewAttack;
        tNewAttack=instance_create(x+181,y+136,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=270
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        tNewAttack=instance_create(x+197,y+136,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=270
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        tNewAttack=instance_create(x+213,y+136,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=270
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2

        tNewAttack=instance_create(x+465,y+139,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=225
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        tNewAttack=instance_create(x+497,y+171,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=225
        tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        otherAtkTime=0
      }
      if lifePercent<=0.5 {fishDelay=510; moveTime=0; otherAtkTime=0 moveProg+=1}
    }
    else if moveProg=3 //--------------------------------------------------------------------------------
    {
      if x>-250 {x-=2}
      if moveTime=60
      {
        for(i=0;i<10;i+=1)
        {
          var tNewAttack;
          tNewAttack=instance_create(x+300+(48*i),y+93,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.decayTime=-100; tNewAttack.direction=270
          tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        }
      }
      else if moveTime=120
      {
        for(i=0;i<10;i+=1)
        {
          var tNewAttack;
          tNewAttack=instance_create(x+276+(48*i),y+93,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.decayTime=-100; tNewAttack.direction=270
          tNewAttack.image_xscale=1.2; tNewAttack.image_yscale=1.2
        }
        moveTime=0
      }
      if moveTime mod 40=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+650,y+70,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+650,y+70,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.5; tNewAttack.image_yscale=1.5
      }
      if lifePercent<=0.3 {fishDelay=480; moveTime=0; otherAtkTime=0 moveProg+=1}
    }
    else if moveProg=4 //--------------------------------------------------------------------------------
    {
      if x>-440 {x-=2}
      if moveTime mod 80=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+650,y+70,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+650,y+70,oPlayer1.x,oPlayer1.y-26)
        tNewAttack.image_xscale=1.4; tNewAttack.image_yscale=1.4
      }
      if moveTime mod 55=0
      {
        var tNewAttack,tDir;
        tDir=0
        for(i=0;i<20;i+=1)
        {
          tNewAttack=instance_create(x+556,y+86,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.decayTime=-100; tNewAttack.direction=tDir; tNewAttack.image_speed=0
          tNewAttack.image_xscale=1.1; tNewAttack.image_yscale=1.1
          tDir+=360/20
        }
      }
      if moveTime mod 65=0
      {
        var tNewAttack,tDir;
        tDir=direction=point_direction(x+820,y+70,oPlayer1.x,oPlayer1.y-26)
        for(i=0;i<20;i+=1)
        {
          tNewAttack=instance_create(x+820,y+70,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.decayTime=-100; tNewAttack.direction=tDir; tNewAttack.image_speed=0; tNewAttack.image_index=1
          tNewAttack.image_xscale=1.1; tNewAttack.image_yscale=1.1
          tDir+=360/20
        }
      }
      if lifePercent<=0.1 {fishDelay=450; moveTime=0; otherAtkTime=0 moveProg+=1}
    }
    else if moveProg=5 //--------------------------------------------------------------------------------
    {
      if finalSection=0
      {
        msgCreate(0,0,"Jeremy","Oh man, this thing is about to unleash a bullet storm. Let's see if we can beef up that cannon of yours.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
        finalSection+=1
      }
      else if finalSection=1
      {
        if y>-64 {y-=1}
        life=4000
        if moveTime>=150
        {
          oTeamTruck.fireRate=1
          oTeamTruck.gunSpread=5
          msgCreate(0,0,"Jeremy","There we go!",0,0,oMessagePerson,0)
          newMessage.fadingTime=55
          moveTime=0; finalSection+=1
        }
      }
      else if finalSection=2
      {
        life=3700
        if moveTime>=65 {moveTime=0; finalSection+=1}
      }
      else if finalSection=3
      {
        var tNewAttack;
        if moveTime mod 2=0
        {
          tNewAttack=instance_create(x+550+random(320),y+30+random(32),oLeviaBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=3
          tNewAttack.decayTime=-100; tNewAttack.direction=random_range(230,310)
          tNewAttack.image_xscale=1.5; tNewAttack.image_yscale=1.5; tNewAttack.image_speed=0
          tNewAttack=instance_create(x+550+random(320),y+30+random(32),oLeviaBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.decayTime=-100; tNewAttack.direction=random_range(230,310)
          tNewAttack.image_xscale=1.5; tNewAttack.image_yscale=1.5; tNewAttack.image_speed=0; tNewAttack.image_index=1
        }
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim>=1 and deathAnim<=60
    {
      if deathAnim mod 4=0 {playSound(global.snd_HardHit1,0,1,17000)}
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(random(448),random(160),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=61
    {
      if global.bBossGallery=1
      {
        if global.bossGalleryTime[40]>global.levelTimeSecond {global.bossGalleryTime[40]=global.levelTimeSecond}
        global.newMapX=2472; global.newMapY=752; room_goto(rBossGallery)
      }
      else
      {
        oEvCh14_Truck.sceneProgress=1
        global.gamePaused=true
        with oCHAOS_FishBot {instance_destroy()}
        with oEProjectileBase {instance_destroy()}
        with oAttackBase {instance_destroy()}
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
