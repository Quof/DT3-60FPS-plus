#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Ridley"
eLevel=20
maxLife=10000
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
bWave=1
moveWaveX=pi/2
moveWaveY=pi/2
moveSpd=0

extendStream=0
atkProg=0
atkTime=20
if room=rSamus5_Lv1_D {atkDelay=50}
else if room=rSamus5_Lv1_E {atkDelay=80}
else if room=rSamus5_Lv1_F {atkDelay=25; extendStream=2}

//Body Data
ridParts[0]=instance_create(x,y,oRidleyFirstParts); ridParts[0].depth=4; ridParts[0].type=0
ridParts[1]=instance_create(x,y,oRidleyFirstParts); ridParts[1].sprite_index=sRidleyWings; ridParts[1].depth=5; ridParts[1].type=1
ridParts[2]=instance_create(x,y,oRidleyFirstParts); ridParts[2].sprite_index=sRidleyArms; ridParts[2].depth=6; ridParts[2].type=2
for(i=0;i<3;i+=1)
{
  ridParts[i].myOwner=id
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyFirstParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
}
ridTail[6].sprite_index=sRidleyTailEnd; ridTail[6].depth=9
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
    if room=rSamus5_Lv1_D {jeremyText="You probably know all about this guy already. For this, he doesn't seem to be trying all that hard though. He'll cycle through a focused fire attack, slow dive, then race across the area blasting fire toward you. The last of these can be bad if you're positioned incorrectly, though maybe you can use the Morph Ball to dodge easier."}
    else {jeremyText="Looks like Ridley is just gonna stay back and use his fireballs at this point. If at any time he tries to get in the way, try to lure him in such a way that gives you space to get through."}
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="No Dev Commentary."
    with oRidleyFirstParts
    {
      jeremyText=oRidleyFirst.jeremyText
      chaoText=oRidleyFirst.chaoText
      devText=oRidleyFirst.devText
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bWave=1
    {
      moveWaveY+=0.2
      y+=sin(moveWaveY)
      if x+16<oPlayer1.x {image_xscale=1}
      else if x-16>oPlayer1.x {image_xscale=-1}
    }

    if room=rSamus5_Lv1_D
    {
      atkTime+=1
      if atkProg=0 //Fire breath
      {
        if atkTime>=atkDelay and atkTime<=atkDelay+100 {atkTime=1000}
        else if atkTime=1001 {ridParts[0].image_index=1}
        else if atkTime=1004 {ridParts[0].image_index=2}
        else if atkTime>=1010 and atkTime<=1025
        {
          if atkTime mod 3=0
          {
            playSound(global.snd_RidleyFire,0,0.98,1)
            var tNewAttack;
            tNewAttack=instance_create(x+(9*image_xscale),y-4,oMetBulletPass)
            tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=7
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
            tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,oPlayer1.y-26)+random_range(-5,5)
          }
        }
        else if atkTime=1038 {ridParts[0].image_index=1}
        else if atkTime=1041 {ridParts[0].image_index=0}
        else if atkTime=1052 {atkTime=0; atkProg+=1}
      }
      else if atkProg=1 //Swoop out at player
      {
        if atkTime=40 {bWave=0; ridParts[1].animSpd=1.5; oRidleyFirstParts.tailType=0}
        else if atkTime=54
        {
          strikeDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
          if strikeDir=270 {strikeDir+=random_range(-1,1)}
          else if strikeDir>=91 and strikeDir<=225 {strikeDir=225}
          else if (strikeDir>=315 and strikeDir<=360) or strikeDir<=89 {strikeDir=315}
          if strikeDir<270 {moveArc=-2} else {moveArc=2}
        }
        else if atkTime>=55 and atkTime<=150
        {
          if atkTime<=90 {strikeDir+=moveArc}
          direction=strikeDir
          speed=6.5
          if x>=room_width+96 or x<=-96 or y<=-96 {atkTime=150}
        }
        else if atkTime=151 {speed=0; atkTime=0; atkProg+=1}
      }
      else if atkProg=2 //Fly across upper screen region, use fire breath
      {
        if atkTime=1
        {
          ridParts[0].image_index=2
          ridParts[1].animSpd=2; oRidleyFirstParts.tailType=3
          strikeDir=choose(-8,8)
          if strikeDir>0 {x=-96; image_xscale=1}
          else {x=room_width+96; image_xscale=-1}
          y=96
        }
        else if atkTime>=2 and atkTime<=999
        {
          x+=strikeDir
          if atkTime mod 13=0
          {
            playSound(global.snd_RidleyFire,0,0.98,1)
            var tNewAttack;
            tNewAttack=instance_create(x+(9*image_xscale),y-4,oMetBulletPass)
            tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=7
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
            tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
          }

          if (image_xscale=1 and x>=room_width+96) or (x<=-96) {atkTime=1000}
        }
        else if atkTime=1001
        {
          ridParts[0].image_index=0
          ridParts[1].animSpd=1; oRidleyFirstParts.tailType=1
          atkTime=0; atkProg+=1
        }
      }
      else if atkProg=3 //Find a spot to fly down upon
      {
        if atkTime=1
        {
          strikeDir=choose(1,2,3)
          if strikeDir=1 {x=336}
          else if strikeDir=2 {x=480}
          else if strikeDir=3 {x=624}
          y=-96
        }
        else if atkTime>=2
        {
          y+=7
          if y>=128
          {
            y=128
            moveWaveY=pi/2
            bWave=1
            atkTime=0; atkProg=0
          }
        }
      }
    }
    else if room=rSamus5_Lv1_E or room=rSamus5_Lv1_F
    {
      if room=rSamus5_Lv1_E
      {
        moveWaveX+=0.05
        x+=sin(moveWaveX)

        if y<oPlayer1.y-26 //Above player
        {
          if moveSpd<4 {moveSpd+=0.3}
        }
        else if y>oPlayer1.y-26 //Below player
        {
          if moveSpd>-4 {moveSpd-=0.3}
        }
        y+=moveSpd
      }
      else if room=rSamus5_Lv1_F
      {
        if x<oPlayer1.x
        {
          if moveSpd<4 {moveSpd+=0.3}
        }
        else if x>oPlayer1.x
        {
          if moveSpd>-4 {moveSpd-=0.3}
        }
        x+=moveSpd
      }

      atkTime+=1
      if atkTime>=atkDelay and atkTime<=atkDelay+100 {atkTime=1000}
      else if atkTime=1001 {ridParts[0].image_index=1}
      else if atkTime=1004 {ridParts[0].image_index=2}
      else if atkTime>=1010 and atkTime<=1025+extendStream
      {
        if atkTime mod 3=0
        {
          playSound(global.snd_RidleyFire,0,0.98,1)
          var tNewAttack;
          tNewAttack=instance_create(x+(9*image_xscale),y-4,oMetBulletPass)
          tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=7
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
          tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
        }
      }
      else if atkTime=1038 {ridParts[0].image_index=1}
      else if atkTime=1041 {ridParts[0].image_index=0}
      else if atkTime=1052 {atkTime=0}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.95 and lifePercent>=0.9 and bossProgress=0
    {
      resType[3]=2
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=3; tAtkShield.atkUp=1
      with oRidleyFirstParts {resType[3]=2}
      bossProgress+=1
    }
    else if lifePercent<=0.89 and lifePercent>=0.21 and bossProgress=1
    {
      resType[3]=1
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=3; tAtkShield.atkUp=1
      with oRidleyFirstParts {resType[3]=1}
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=2
    {
      life=round(maxLife/5)
    }
  }
  oRidleyFirstParts.image_blend=image_blend
  oRidleyFirstParts.image_xscale=image_xscale
  enemyStepEvent()
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
