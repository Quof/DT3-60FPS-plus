#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="Lv.?? The Flame Elemental"
eLevel=28
maxLife=3500
life=maxLife
atkPower=10
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=6
dieEffect=0
bossProgress=0
activateBoss=0

bCanBeBlocked=1
bParryOpp=0
blockCost=100

firstSpawn=0
waitTime=0
atkAmt=8
atkCycle=0
atkChange=0
myDir=0

//--------------------

//Misc Data
xCenter=712
yGround=304
roomSpan=136

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
    jeremyText="This isn't really a boss fight, is it? I mean, it's pretty simple."
    chaoText="This sprite is from the Sega Genesis game, 'Ghostbusters'."
    devText="Eh?"
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if firstSpawn=0
    {
      if y>=232 {firstSpawn=1}
      else {y+=8}
    }
    else
    {
      speed=1.5
      direction+=2

      if oGame.time mod 3=0
      {
        if image_xscale=1 {image_xscale=-1}
        else {image_xscale=1}
      }

      waitTime+=1
      if waitTime>=40
      {
        playSound(global.snd_Flame1,0,0.9,29000)
        var tNewAttack,tDir;
        tDir=0
        atkCycle+=1
        if atkCycle>=5
        {
          for(i=0;i<atkAmt*2;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sPT_FE_BigFire; tNewAttack.atkPower=atkPower+1; tNewAttack.decayTime=-100
            tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=350; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
            tNewAttack.direction=myDir+tDir; tNewAttack.depth=9; tNewAttack.bulletSpeed=4; tNewAttack.image_speed=0.33
            tDir+=360/atkAmt
          }
          atkCycle=0
        }
        else
        {
          var tAtkSet;
          atkChange+=1
          if atkChange>=8
          {
            tAtkSet=atkAmt*3
            atkChange=0
          }
          else {tAtkSet=atkAmt}
          for(i=0;i<tAtkSet;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sPT_FE_Fireball; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
            tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
            tNewAttack.direction=myDir+tDir; tNewAttack.depth=9; tNewAttack.bulletSpeed=6; tNewAttack.image_speed=0.33
            tDir+=360/tAtkSet
          }
        }
        myDir+=9
        waitTime=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      bossProgress+=1
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
    tEffect=instance_create(x+random_range(-14,14),y+random_range(-28,28),oEffect)
    tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
    tEffect.image_alpha=0.5+(image_alpha/3)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    image_alpha-=0.02
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(42)
        global.newMapX=2536; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        oEvCh15MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {speed=0}
