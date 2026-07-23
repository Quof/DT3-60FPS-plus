#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15
bShowHealthBar=false
oHUD.dragoonBossCheck=1
oHUD.enemyCheckID=id
bActive=1

//Enemy base statistics
eName="Hex Worm"
eLevel=37
maxLife=700
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
weaponGive=300
bossProgress=0
activateBoss=0

moveBehavior=0
movePath=1
moveProg=0
moveSpd=4

deathAnim=0

jeremyText="It looks like the head is invulnerable to damage while any of the body segments are around."
chaoText="Ah lame, this just restores all of your health when you eat it."
devText="N/A"

partCheck=0
partNum=24
for(i=0;i<partNum;i+=1)
{
  bodyPart[i]=instance_create(x,y,oHW_Body)
  bodyPart[i].bodySeg=i
  bodyPart[i].depth=depth+i+1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    image_angle=direction
    if moveBehavior=0 //Decide on a move type
    {
      if movePath=1
      {
        instance_create(oEvShooter.spawnX,oEvShooter.spawnY2,oC_Butterdroid)
        instance_create(oEvShooter.spawnX,oEvShooter.spawnY6,oC_Sparker)
        targetPath=pth_HW_A; x=528; y=80
      }
      else if movePath=2 {targetPath=pth_HW_B; x=432; y=-32}
      else if movePath=3 {targetPath=pth_HW_C; x=432; y=384}
      else if movePath=4 {targetPath=pth_HW_D; x=-32; y=192}
      path_start(targetPath,moveSpd,0,true)
      with oHW_Body //Reset all body parts
      {
        x=oHexWorm.x; y=oHexWorm.y
        bCanTakeDamage=true
        path_start(oHexWorm.targetPath,oHexWorm.moveSpd,0,true)
        myMoveCheck=0
        var tDelay;
        tDelay=round(32/oHexWorm.moveSpd)
        fireTime=30-(bodySeg*2)
        moveDelay=tDelay+(bodySeg*tDelay)
      }
      moveBehavior=1
    }
    else if moveBehavior=1 //Follow a path
    {
      path_speed=moveSpd
      if partCheck>=partNum //Iterate to new path
      {
        if bossProgress=0 and partNum<=18 {moveSpd=5; bossProgress+=1}
        else if bossProgress=1 and partNum<=12 {moveSpd=6; bossProgress+=1}
        partCheck=0
        movePath+=1
        if movePath=5 {movePath=1}
        moveBehavior=0
      }
      if partNum=0 //All body parts eaten
      {
        path_speed=0
        moveBehavior=2
      }
    }
    else if moveBehavior=2 //Go to position
    {
      direction=point_direction(x,y,384,176)
      speed=4
      if point_distance(x,y,384,176)<=speed
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        speed=0
        movePath=30
        partCheck=0
        moveBehavior=3
      }
    }
    else if moveBehavior=3 //Shoot bullets
    {
      direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
      movePath+=1
      if movePath>=60
      {
        if movePath mod 8=0
        {
          playSound(global.snd_LaserA,0,0.9,32000)
          var tNewAttack,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
          for(i=0;i<14;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
            tNewAttack.decayTime=-100; tNewAttack.direction=partCheck+tDir
            tDir+=360/14
          }
          partCheck+=8
          if partCheck>=80
          {
            partCheck=0
            movePath=0
          }
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=2
    {
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=3
    {
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0 and bossProgress=4
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    with oEProjectileBase
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      instance_destroy()
    }
    oHUD.dragoonBossCheck=0
    playSound(global.snd_HealthPickup,0,1,1)
    oPlayer1.life=oPlayer1.maxLife
    instance_destroy()
  }
  enemyStepEvent()
}
else {path_speed=0; speed=0}
