#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
image_speed=0

//Enemy base statistics
eName="Helmethead Fake EX"
eLevel=40
maxLife=30000
life=maxLife
atkPower=1
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=1
hitSound=global.snd_EnemyHitZelda

shadowScale=0
shadowX=0
shadowOffsetX=0
endShadow=0

bMoveNormally=1
moveTime=0
moveThres=40
atkTime=0
atkDelay=90
bNormalAtk=1

finalAtkTime=0

xCenter=240
yGround=304
roomSpan=192

deathAnim=0

jeremyText="..."
chaoText="... ... ..."
devText="?????"
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
    //---------- Movement ----------
    if moveTime<moveThres
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if bMoveNormally=1 //Normal walk toward player
    {
      moveTime+=1
      if moveTime>=moveThres and moveTime<=moveThres+15
      {
        image_speed=0.2
        if image_xscale=1 {x+=1}
        else {x-=1}
      }
      else if moveTime>=moveThres+16
      {
        image_speed=0
        image_index=0
        xVel=0
        moveTime=0
      }
    }

    if bNormalAtk=1 //Normal attack toward player
    {
      atkTime+=1
      if atkTime=atkDelay //---------- Attack: Bullet toward player ----------
      {
        var tEffect;
        tEffect=instance_create(x,y-35,oEffect)
        tEffect.sprite_index=sMMchargeComplete
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_speed=0.5
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-35
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if atkTime>=atkDelay+20 and atkTime mod 3=0
      {
        var myDir;
        myDir=random(360)
        for(i=0;i<24;i+=1)
        {
          playSound(global.snd_HardHit3,0,1,17000)
          var tFire;
          tFire=instance_create(x,y-35,oPassBullet)
          tFire.direction=myDir; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=1; tFire.decayTime=-100
          myDir+=360/24
        }
      }
    }

    finalAtkTime+=1
    if finalAtkTime>=305
    {
      global.mapTeleport=0
      global.rbSwitchBlueOn=false
      global.currentBoss=""; global.bossTrack=0
      abilSetRemove(0)
      global.canPause=1
      global.BTB_HelmetHead=2
      global.newMapX=1936; global.newMapY=0
      room_goto(rMain_34)
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if bossProgress=0
  draw_sprite_ext(sHelmetHeadA,image_index,x,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
