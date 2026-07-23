#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
image_yscale=1.5

//Enemy base statistics
eName="Maoh the Giant"
eLevel=16
maxLife=3200
life=maxLife
atkPower=6
resType[0]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bombSpamTime=170
bombSpamDelay=350

armSpd=6
spikeLeftSeq=0
spikeLeftTime=60
spikeRightSeq=0
spikeRightTime=150
armSpikeDelay=210

specialAttack=0
specProg=0
specTime=0
specDir=0
wallSpikes=0
//--------------------
moveSpd=0
stepCount=pi/2

//Misc Data
xCenter=336
yGround=240
roomSpan=240

deathAnim=0
spikeOffsetX=87
spikeOffsetY=3
chainFrm=0

body=instance_create(x,y,oMaohBody)
leftSpike=instance_create(x-spikeOffsetX,y+spikeOffsetY,oMaohSpike)
leftSpike.type=1; leftSpike.ownerID=id; leftSpike.atkPower=atkPower; leftSpike.depth=1000001
rightSpike=instance_create(x+spikeOffsetX,y+spikeOffsetY,oMaohSpike)
rightSpike.type=2; rightSpike.ownerID=id; rightSpike.atkPower=atkPower; rightSpike.depth=1000001
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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="The first thing you probably notice is the red outline on the spiked arms, which means your dash invulnerability does not work for it. Don't forget your dash can also be used for quickly getting out of harm's way though. There's a scatter bomb attack that seems to target the field based on where you are."
    chaoText="This thing has been heavily modified from its original version by the Virus. It still doesn't move though..."
    devText="Initially Chapter 7 was where red traps would be introduced, but I decided about half way through its development to move it back to this point. Of course the X-Buster and wall jumping are introduced, but those are easy concepts to grasp. The red traps are scarce and also easy to understand."
    body.jeremyText=jeremyText; body.chaoText=chaoText; body.devText=devText
    leftSpike.depth=24; rightSpike.depth=24
    activateBoss=2
  }

  if bActive=true and life>0
  {
    stepCount+=pi/60
    y+=sin(stepCount)

    if specialAttack=0
    {
      //-------------------- LEFT ARM ATTACK --------------------
      spikeLeftTime+=1
      if spikeLeftSeq=0 //Wait time
      {
        if spikeLeftTime>=armSpikeDelay
        {
          spikeLeftTime=0
          spikeLeftSeq=1
        }
      }
      else if spikeLeftSeq=1 //Warning
      {
        if spikeLeftTime=1
        {
          var tEffect;
          for(i=0;i<16;i+=1)
          {
            tEffect=instance_create(leftSpike.x,leftSpike.y,oEffect)
            tEffect.sprite_index=sMMchargeEffect1; tEffect.direction=i*22.5; tEffect.image_angle=i*45
            tEffect.speed=4.5; tEffect.friction=0.1; tEffect.image_speed=0.2
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
        else if spikeLeftTime>=30
        {
          findLeftDir=point_direction(leftSpike.x,leftSpike.y,oPlayer1.x,returnPlayerYCenter())
          spikeLeftSeq=2
        }
      }
      else if spikeLeftSeq=2 //Attack
      {
        leftSpike.x+=armSpd*cos(degtorad(findLeftDir))
        leftSpike.y+=-armSpd*sin(degtorad(findLeftDir))
      }
      else if spikeLeftSeq>=3 and spikeLeftSeq<=4 //Slight wait before pull back
      {
        if spikeLeftTime>=40 {spikeLeftSeq=5}
      }
      else if spikeLeftSeq=5 //Pull back
      {
        findLeftDir=point_direction(leftSpike.x,leftSpike.y,x-spikeOffsetX,y+spikeOffsetY)
        leftSpike.x+=armSpd*cos(degtorad(findLeftDir))
        leftSpike.y+=-armSpd*sin(degtorad(findLeftDir))

        if point_distance(leftSpike.x,leftSpike.y,x-spikeOffsetX,y+spikeOffsetY)<6
        {
          leftSpike.x=x-spikeOffsetX; leftSpike.y=y+spikeOffsetY
          spikeLeftTime=0
          spikeLeftSeq=0
        }
      }

      //-------------------- RIGHT ARM ATTACK --------------------
      spikeRightTime+=1
      if spikeRightSeq=0 //Wait time
      {
        if spikeRightTime>=armSpikeDelay
        {
          spikeRightTime=0
          spikeRightSeq=1
        }
      }
      else if spikeRightSeq=1 //Warning
      {
        if spikeRightTime=1
        {
          var tEffect;
          for(i=0;i<16;i+=1)
          {
            tEffect=instance_create(rightSpike.x,rightSpike.y,oEffect)
            tEffect.sprite_index=sMMchargeEffect1; tEffect.direction=i*22.5; tEffect.image_angle=i*45
            tEffect.speed=4.5; tEffect.friction=0.1; tEffect.image_speed=0.2
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
        else if spikeRightTime>=30
        {
          findRightDir=point_direction(rightSpike.x,rightSpike.y,oPlayer1.x,returnPlayerYCenter())
          spikeRightSeq=2
        }
      }
      else if spikeRightSeq=2 //Attack
      {
        rightSpike.x+=armSpd*cos(degtorad(findRightDir))
        rightSpike.y+=-armSpd*sin(degtorad(findRightDir))
      }
      else if spikeRightSeq>=3 and spikeRightSeq<=4 //Slight wait before pull back
      {
        if spikeRightTime>=40 {spikeRightSeq=5}
      }
      else if spikeRightSeq=5 //Pull back
      {
        findRightDir=point_direction(rightSpike.x,rightSpike.y,x+spikeOffsetX,y+spikeOffsetY)
        rightSpike.x+=armSpd*cos(degtorad(findRightDir))
        rightSpike.y+=-armSpd*sin(degtorad(findRightDir))

        if point_distance(rightSpike.x,rightSpike.y,x+spikeOffsetX,y+spikeOffsetY)<6
        {
          rightSpike.x=x+spikeOffsetX; rightSpike.y=y+spikeOffsetY
          spikeRightTime=0
          spikeRightSeq=0
        }
      }

      //-------------------- ATTACK: SYNC BOMB SPAM --------------------
      bombSpamTime+=1
      if bombSpamTime>=bombSpamDelay and bombSpamTime<=bombSpamDelay+100 //Wait
      {
        bombSpamTime=10000
      }
      else if bombSpamTime>=10001 and bombSpamTime<=10040 //Smoke effect
      {
        if bombSpamTime mod 4=0
        {
          var tEffect;
          tEffect=instance_create(x-81+random(10),y-63+random(10),oEffect)
          tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.2+random(0.1)
          tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=-2-random(2); tEffect.tDecay=-100
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect=instance_create(x+71+random(10),y-63+random(10),oEffect)
          tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.2+random(0.1)
          tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=-2-random(2); tEffect.tDecay=-100
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      else if bombSpamTime=10041 //Launch bombs
      {
        playSound(global.snd_BombLaunch,0,1,1)
        for(i=0;i<5;i+=1)
        {
          lBomb[i]=instance_create(x-76,y-58,oPassBullet)
          lBomb[i].sprite_index=sEnmityBomb; lBomb[i].atkPower=atkPower; lBomb[i].bulletSpeed=7
          lBomb[i].image_speed=0.33; lBomb[i].decayTime=-100; lBomb[i].damageType="EXPLOSION"
          lBomb[i].direction=95+(i*20)
          rBomb[i]=instance_create(x+76,y-58,oPassBullet)
          rBomb[i].sprite_index=sEnmityBomb; rBomb[i].atkPower=atkPower; rBomb[i].bulletSpeed=7
          rBomb[i].image_speed=0.33; rBomb[i].decayTime=-100; rBomb[i].damageType="EXPLOSION"
          rBomb[i].direction=85-(i*20)
        }
      }
      else if bombSpamTime=10048 //Stop bombs
      {
        for(i=0;i<5;i+=1)
        {
          lBomb[i].bulletSpeed=0
          rBomb[i].bulletSpeed=0
        }
      }
      else if bombSpamTime=10090 //Check player position
      {
        if oPlayer1.x>=xCenter-80 and oPlayer1.x<=xCenter+80 {bombSpamTime=11000}
        else {bombSpamTime=12000}
        bombCheck=0
      }
      else if bombSpamTime>=11000 and bombSpamTime<=11100 //Player is under boss
      {
        if bombSpamTime mod 7=0
        {
          lBomb[bombCheck].bulletSpeed=7
          lBomb[bombCheck].direction=310-(bombCheck*10)
          rBomb[bombCheck].bulletSpeed=7
          rBomb[bombCheck].direction=230+(bombCheck*10)
          bombCheck+=1
          if bombCheck=5 {bombSpamTime=0}
        }
      }
      else if bombSpamTime>=12000 and bombSpamTime<=12100 //Player is not under boss
      {
        if bombSpamTime mod 7=0
        {
          lBomb[bombCheck].bulletSpeed=7
          lBomb[bombCheck].direction=280-(bombCheck*15)
          rBomb[bombCheck].bulletSpeed=7
          rBomb[bombCheck].direction=260+(bombCheck*15)
          bombCheck+=1
          if bombCheck=5 {bombSpamTime=0}
        }
      }
    }

    //-------------------- UTILITY: WALL SPIKES --------------------
    if wallSpikes>=1 and wallSpikes<=120
    {
      wallSpikes+=1
      if wallSpikes=70
      {
        var tEffect;
        for(i=0;i<16;i+=1)
        {
          tEffect=instance_create(56,56+(i*16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          leftSpikes[i]=instance_create(48,48+(i*16),oStaticSpike)
          rightSpikes[i]=instance_create(608,48+(i*16),oStaticSpike)
        }
      }
      else if wallSpikes>=71 and wallSpikes<=118
      {
        for(i=0;i<16;i+=1)
        {
          leftSpikes[i].x+=1
          rightSpikes[i].x-=1

          if wallSpikes mod 3=0 //Spike smoke effect
          {
            var tEffect;
            tEffect=instance_create(leftSpikes[i].x+4,leftSpikes[i].y+2+random(12),oEffect)
            tEffect.sprite_index=sMMSmokeCloud
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect=instance_create(rightSpikes[i].x+12,rightSpikes[i].y+2+random(12),oEffect)
            tEffect.sprite_index=sMMSmokeCloud
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
      }
    }
    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.8 and lifePercent>=0.76 and bossProgress=0
    {
      bombSpamDelay-=20
      armSpikeDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.61 and bossProgress=1
    {
      wallSpikes=1
      msgCreate(0,0,"Jeremy","Get away from the walls!",0,0,oMessagePerson,0)
      newMessage.fadingTime=70
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=2
    {
      bombSpamDelay-=20
      armSpikeDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=3
    {
      bombSpamDelay-=20
      armSpikeDelay-=10
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      bombSpamDelay-=30
      armSpikeDelay-=20
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sMaohGiantBody
      image_yscale=1
      with oMaohBody {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 6=0 {playSound(global.snd_BombExplode,0,0.92,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(17)
        global.newMapX=2248; global.newMapY=1024; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}

oMaohBody.x=x; oMaohBody.y=y
if spikeLeftSeq<=1 {leftSpike.x=x-spikeOffsetX; leftSpike.y=y+spikeOffsetY}
if spikeRightSeq<=1 {rightSpike.x=x+spikeOffsetX; rightSpike.y=y+spikeOffsetY}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0
{
  chainFrm+=0.35
  var tLeftDist,tLeftDir;
  tLeftDist=point_distance(x-spikeOffsetX,y+spikeOffsetY,leftSpike.x,leftSpike.y)
  tLeftDir=point_direction(x-spikeOffsetX,y+spikeOffsetY,leftSpike.x,leftSpike.y)
  draw_sprite(sMaohGiantChain,0,x-spikeOffsetX,y+spikeOffsetY)
  for(i=0;i<4;i+=1)
  {
    draw_sprite(sMaohGiantChain,chainFrm,x-spikeOffsetX+lengthdir_x(tLeftDist*(0.2*(i+1)),tLeftDir),y+spikeOffsetY+lengthdir_y(tLeftDist*(0.2*(i+1)),tLeftDir))
  }

  var tRightDist,tRightDir;
  tRightDist=point_distance(x+spikeOffsetX,y+spikeOffsetY,rightSpike.x,rightSpike.y)
  tRightDir=point_direction(x+spikeOffsetX,y+spikeOffsetY,rightSpike.x,rightSpike.y)
  draw_sprite(sMaohGiantChain,0,x+spikeOffsetX,y+spikeOffsetY)
  for(i=0;i<4;i+=1)
  {
    draw_sprite(sMaohGiantChain,chainFrm,x+spikeOffsetX+lengthdir_x(tRightDist*(0.2*(i+1)),tRightDir),y+spikeOffsetY+lengthdir_y(tRightDist*(0.2*(i+1)),tRightDir))
  }
}
else {event_inherited()}
