#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
bShowHealthBar=false
oHUD.dragoonBossCheck=1
oHUD.enemyCheckID=id
bActive=1

//Enemy base statistics
eName="MkII Ver 3.14"
eLevel=37
maxLife=3500
life=maxLife
atkPower=12
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
weaponGive=300
bossProgress=0
activateBoss=0

moveBehavior=0
moveCount=3
moveProg=0
moveSpd=2
bulletCheck=0
missileNum=16
arcNum=16

deathAnim=0

jeremyText="Oddly, this thing's legs are not part of its hitbox. Only the body is vulnerable to damage. There's an oddity you may see with its movement. There's a starting position for all its movement cycles, the place it flew toward at the start. It seems to stutter/snap into that position. I don't know, just something I noticed. It has bullet patterns. I don't really know how to help you two there."
chaoText="Ah lame, this just restores all of your health when you eat it."
devText="N/A"
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
    if moveBehavior=0
    {
      x-=4
      if x<=368 {x=368; y=176; moveBehavior=1}
    }
    else if moveBehavior=1 //Decide on a move type
    {
      moveCount+=1
      if moveCount=5 {moveCount=1}
      if moveCount=1 {path_start(pth_Mark_A,moveSpd,0,true)}
      else if moveCount=3 {path_start(pth_Mark_B,8,0,true)}
      bulletCheck=point_direction(x,y,oPlayer1.x,oPlayer1.y)
      if bossProgress=1
      {
        missileNum+=4
        arcNum+=6
        bossProgress=2
      }
      moveProg=0
      moveBehavior=2
    }
    else if moveBehavior=2
    {
      if moveCount=1 //---------- Arc bullets ----------
      {
        path_speed=moveSpd
        moveProg+=1
        if moveProg<=40
        {
          if moveProg mod 2=0
          {
            var tNewAttack;
            tNewAttack=instance_create(x,y,oCW_ArcBullet)
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
            tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
          }
        }
        else if moveProg>=41 and moveProg<=60
        {
          if moveProg mod 2=0
          {
            var tNewAttack,tDir;
            tDir=0
            for(i=0;i<arcNum;i+=1)
            {
              tNewAttack=instance_create(x,y,oCW_ArcBullet)
              tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
              tNewAttack.decayTime=-100; tNewAttack.direction=tDir
              tDir+=360/arcNum
            }
          }
        }
        else {moveProg=0}

        if path_position>=0.99
        {
          path_speed=0
          x=368; y=176
          moveBehavior=1
        }
      }
      else if moveCount=2 //---------- Spin missiles ----------
      {
        moveProg+=1
        if moveProg=30
        {
          var tAtk,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)-25
          for(i=0;i<9;i+=1)
          {
            tAtk=instance_create(x,y,oPassBullet)
            tAtk.sprite_index=sC_RevShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8
            tAtk.decayTime=-100; tAtk.direction=tDir
            tDir+=5
          }
          tDir=0
          for(i=0;i<missileNum;i+=1)
          {
            tAtk=instance_create(x,y,oCW_SpinMissile)
            tAtk.sprite_index=sC_MarkBullet; tAtk.atkPower=atkPower; tAtk.turnDir=4; tAtk.direction=tDir
            tDir+=360/missileNum
          }
        }
        else if moveProg=60
        {
          var tAtk,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)-25
          for(i=0;i<9;i+=1)
          {
            tAtk=instance_create(x,y,oPassBullet)
            tAtk.sprite_index=sC_RevShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=8
            tAtk.decayTime=-100; tAtk.direction=tDir
            tDir+=5
          }
          tDir=0
          for(i=0;i<missileNum;i+=1)
          {
            tAtk=instance_create(x,y,oCW_SpinMissile)
            tAtk.sprite_index=sC_MarkBullet; tAtk.atkPower=atkPower; tAtk.turnDir=-4; tAtk.direction=tDir
            tDir+=360/missileNum
          }
        }
        else if moveProg>=90
        {
          moveProg=0
          moveBehavior=1
        }
      }
      else if moveCount=3 //---------- Star pattern ----------
      {
        moveProg+=1
        if moveProg<999
        {
          path_speed=7
          if moveProg mod 2=0
          {
            var tAtk,tDir;
            tDir=0
            for(i=0;i<5;i+=1)
            {
              tAtk=instance_create(x,y,oCW_MarkShot)
              tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.direction=bulletCheck+tDir
              tAtk.image_blend=make_color_rgb(255-(i*20),255,255-(i*20))
              tDir+=360/5
            }
            bulletCheck+=7
          }

          if path_position>=0.99
          {
            path_speed=0
            x=368; y=176
            moveProg=1000
          }
        }
        else if moveProg=1020
        {
          with oCW_MarkShot {bulletProg=1}
        }
        else if moveProg>=1090
        {
          moveProg=0
          moveBehavior=1
        }
      }
      else if moveCount=4 //---------- Spawn enemies ----------
      {
        moveProg+=1
        if moveProg mod 10=0
        {
          tAtk=instance_create(x,y,oPassBullet)
          tAtk.sprite_index=sC_MarkBullet; tAtk.atkPower=atkPower; tAtk.bulletSpeed=5
          tAtk.decayTime=-100; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
        }

        if moveProg=1
        {
          instance_create(oEvShooter.spawnX,oEvShooter.spawnY2,oC_Butterdroid)
          instance_create(oEvShooter.spawnX,oEvShooter.spawnY6,oC_DopeyBot)
        }
        else if moveProg>=120
        {
          moveProg=0
          moveBehavior=1
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.7 and lifePercent>=0.41 and bossProgress=0
    {
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0 and bossProgress=2
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sCHAOS_Mark_Body,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
