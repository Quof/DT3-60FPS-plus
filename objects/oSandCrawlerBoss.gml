#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(1,1,1,1)
image_speed=0.6
image_xscale=1.25
image_yscale=1.25
visible=0
bCanDealDamage=false
bCanTakeDamage=false
bActive=1

//Enemy base statistics
eName="Sand Crawler"
if global.modeWahfuu=1 {eName="Wahfuu Jr."}
eLevel=26
maxLife=6000
life=maxLife
atkPower=20
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=5
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

biteTime=-1
biteSpd=0.2
moveProg=0
xVel=0

deathAnim=0

jeremyText="So I know this is probably gonna suck a little, but you're gonna need to use bombs when it comes out of the sand. Just remember your bomb timing and it shouldn't be too much. I've removed its health regeneration as well as its annoying insta-death bite."
chaoText="This thing is from King of Monsters 2. It chased Claire through a desert when we were on that island. Looks like Jeremy has finally found a way to make this thing beatable."
devText="Beating this thing should be satisfying."
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

  if life>0
  {
    if bossProgress>=1
    {
      if biteTime=-1
      {
        if x>oPlayer1.x and xVel>-5.5 {xVel-=0.33}
        else if x<oPlayer1.x and xVel<5.5 {xVel+=0.33}
        x+=xVel

        var tEffect;
        if x<=208 or x>=432 {tEffect=instance_create(x+random_range(-32,32),896+random(32),oEffect)}
        else {tEffect=instance_create(x+random_range(-32,32),864+random(32),oEffect)}
        tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.1+random(0.2); tEffect.image_alpha=0.6; tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1); tEffect.image_blend=c_orange

        if oGame.time mod 18=0 and bossProgress=2
        {
          var tAtk,tYY;
          if x<=208 or x>=432 {tYY=928}
          else {tYY=896}
          tAtk=instance_create(x,tYY,oGravPassBullet)
          tAtk.sprite_index=sRobotExplosion; tAtk.image_index=1; tAtk.image_speed=0; tAtk.image_blend=c_orange
          tAtk.yVel=-9; tAtk.atkPower=8
        }
        else if oGame.time mod 24=0 and bossProgress=3
        {
          var tAtk,tYY;
          if x<=208 or x>=432 {tYY=928}
          else {tYY=896}
          tAtk=instance_create(x-48,tYY,oGravPassBullet)
          tAtk.sprite_index=sRobotExplosion; tAtk.image_index=1; tAtk.image_speed=0; tAtk.image_blend=c_orange
          tAtk.yVel=-9; tAtk.atkPower=8
          tAtk=instance_create(x+48,tYY,oGravPassBullet)
          tAtk.sprite_index=sRobotExplosion; tAtk.image_index=1; tAtk.image_speed=0; tAtk.image_blend=c_orange
          tAtk.yVel=-9; tAtk.atkPower=8
        }
      }
    }

    //---------- NORMAL BITE ----------
    if biteTime>=0
    {
      if biteTime=0
      {
        sprite_index=sSandCrawlerClaws
        visible=1
      }

      biteTime+=1
      if biteTime=8
      {
        sprite_index=sSandCrawlerBite
        image_index=0
      }

      if sprite_index=sSandCrawlerBite
      {
        image_speed=biteSpd
        if image_index>=1.3 and image_index<=3 {bCanDealDamage=true}
        else {bCanDealDamage=false}

        if image_index>=0.5 and image_index<=3.9 {bCanTakeDamage=true}
        else {bCanTakeDamage=false}

        if image_index>=5.5
        {
          bCanTakeDamage=false
          y=room_height+128
          visible=0
          xVel=0
          biteTime=-1
        }
      }
      else {image_speed=0.6}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      with oBossCrawlerSpawner
      {
        y-=48
        image_yscale=4
      }
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      biteSpd=0.25
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0 and bossProgress=2
    {
      biteSpd=0.3
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      bCanDealDamage=false
      image_speed=0
      visible=1
      sprite_index=sSandCrawlerBite
      image_index=0
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x-50+random(100),y-random(64),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(38)
        global.newMapX=2184; global.newMapY=752; room_goto(rBossGallery)
      }
      else
      {
        var tEffect;
        tEffect=instance_create(x,y-64,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.25; tEffect.depth=9; tEffect.image_xscale=4; tEffect.image_yscale=4
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
        oEvCh14MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {image_speed=0}
