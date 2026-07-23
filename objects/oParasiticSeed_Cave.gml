#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0.33

//Enemy base statistics
eName="Parasitic Seed"
eLevel=40
maxLife=8700
life=maxLife
atkPower=12
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
dieSound=0
bossProgress=0
activateBoss=0

scaleWaveA=0.5
waveAUp=1

introProg=0
seqProg=0
seqTime=0
attackProg=0
attackTime=0
currentSide=1 //0:left, 1:right
currentAttack=0
bulletType=0

bulletModA=10 //Attack 1
bulletModB=13 //Attack 2
bulletModD=26 //Attack 4

hitCheckArrow=0
hitCheckMissile=0

zigzagTop=112
zigzagBottom=304

largeLaserCheck=0
railRockTime=30
railRockDelay=600

armorCheck=0
armorHP=5
armorAngle=0
armorDist=0
armorAlpha=0

mapRight=room_width+64
mapLeft=-64
ySpawn=144

xSpd=10
ySpd=0

deathAnim=0

jeremyText="Okay, I've got the thing trapped down here and it knows that. It's a little frantic so the attacks it uses are pretty wide spread. There's a very specified Mega Man like pattern that it never deviates from. It IS going to be attempting to resist your attacks though, so be prepared to change things up."
chaoText="After every 3 attacks, it'll use some big laser that takes up most of a single platform. There's an environmental hazard where rocks will be on the track. If you're on one of the platforms when they hit a rock, you'll be flung into the ceiling. Even if that happens, you have ways of stopping that."
devText="One month after the game's initial release, I started thinking about a short extra bit of content. A decent amount of it was laid out, but it wasn't until months after that I got all the small details worked out and actually started developing it."
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
    if introProg=0 //Start off-screen (Fight intro)
    {
      x=-80; y=144
      introProg=1
    }
    else if introProg=1 //Go right till off-screen
    {
      x+=xSpd
      if x>=mapRight {introProg=10}
    }
    else if introProg=10 //Boss fight sequence
    {
      if seqProg=0 //---------- Decide which action to choose ----------
      {
        seqTime+=1
        if seqTime>=15
        {
          if currentSide=0 {x=mapLeft}
          else {x=mapRight}
          y=ySpawn
          bulletType=0; seqTime=0; attackProg=0; attackTime=0
          currentAttack+=1
          if currentAttack=5 {currentAttack=1}
          seqProg=currentAttack
        }
      }
      else if seqProg=1 //---------- ATTACK 1 ----------
      {
        if attackProg=0
        {
          if currentSide=0 {xSpd=4}
          else {xSpd=-4}
          attackProg+=1
        }
        else if attackProg=1 //Attack cycle
        {
          x+=xSpd
          if (xSpd>0 and x>mapRight) or (xSpd<0 and x<mapLeft) {attackProg+=1}

          attackTime+=1
          if attackTime mod bulletModA=0
          {
            var tNewAttack,tDir;
            if bulletType=0 {tDir=player_sprite_center(); bulletType=1}
            else {tDir=270; bulletType=0}
            tNewAtk=instance_create(x,y,oPassBullet)
            tNewAtk.sprite_index=sAbom_ParaShot; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=6; tNewAtk.image_speed=0.33
            tNewAtk.decayTime=-100; tNewAtk.direction=tDir
          }
        }
        else if attackProg=2
        {
          if currentSide=0 {currentSide=1}
          else {currentSide=0}
          largeLaserCheck+=1
          seqProg=0; seqTime=0
        }
      }
      else if seqProg=2 //---------- ATTACK 2 ----------
      {
        if attackProg=0
        {
          if currentSide=0 {xSpd=12}
          else {xSpd=-12}
          attackProg+=1
        }
        else if attackProg=1 //Fly in
        {
          x+=xSpd
          attackTime+=1
          if attackTime>=12 {attackTime=0; attackProg+=1}
        }
        else if attackProg=2 //Slight wait
        {
          attackTime+=1
          if attackTime>=15 {attackTime=0; attackProg+=1}
        }
        else if attackProg=3 //Attack cycle
        {
          attackTime+=1
          if attackTime mod bulletModB=0
          {
            var tNewAtk,tDir;
            tDir=player_sprite_center()-9
            for(i=0;i<3;i+=1)
            {
              tNewAtk=instance_create(x,y,oPassBullet)
              tNewAtk.sprite_index=sAbom_ParaShot; tNewAtk.atkPower=atkPower; tNewAtk.image_speed=0.33
              tNewAtk.decayTime=-100; tNewAtk.direction=tDir
              tDir+=9
              if i=1 {tNewAtk.bulletSpeed=6}
              else {tNewAtk.bulletSpeed=3}
            }
          }
          if attackTime>=85 {attackTime=0; attackProg+=1}
        }
        else if attackProg=4 //Fly off
        {
          x-=xSpd
          if (xSpd<0 and x>mapRight) or (xSpd>0 and x<mapLeft) {attackProg+=1}
        }
        else if attackProg=5
        {
          largeLaserCheck+=1
          seqProg=0; seqTime=0
        }
      }
      else if seqProg=3 //---------- ATTACK 3 ----------
      {
        if attackProg=0
        {
          if currentSide=0 {xSpd=8}
          else {xSpd=-8}
          attackProg+=1
        }
        else if attackProg=1 //Fly in
        {
          x+=xSpd
          attackTime+=1
          if attackTime>=20 {attackTime=0; attackProg+=1}
        }
        else if attackProg=2 //Slight wait
        {
          attackTime+=1
          if attackTime>=10
          {
            direction=player_sprite_center()
            targetX=oPlayer1.x
            targetY=oPlayer1.bbox_top+abs(oPlayer1.sprite_height/2)-abs(oPlayer1.sprite_height/4)
            attackTime=0; attackProg+=1
          }
        }
        else if attackProg=3 //Attack cycle
        {
          attackTime+=1
          if attackTime=1
          {
            var tNewAtk;
            for(i=0;i<8;i+=1)
            {
              for(ii=0;ii<8;ii+=1)
              {
                tNewAtk=instance_create(x+random_range(-28,28),y+random_range(-28,28),oPassBullet)
                tNewAtk.sprite_index=sAbom_ParaShot; tNewAtk.atkPower=atkPower; tNewAtk.image_speed=0.33
                tNewAtk.decayTime=-100; tNewAtk.direction=direction; tNewAtk.bulletSpeed=2+i
              }
            }
          }
          speed=abs(xSpd)
          if point_distance(x,y,targetX,targetY)<=16
          {
            speed=0
            attackTime=0; attackProg+=1
          }
        }
        else if attackProg=4 //Slight wait
        {
          attackTime+=1
          if attackTime>=15
          {
            if currentSide=0 {checkSide=mapRight}
            else {checkSide=mapLeft}
            direction=point_direction(x,y,checkSide,ySpawn)
            attackTime=0; attackProg+=1
          }
        }
        else if attackProg=5 //Fly off
        {
          attackTime+=1
          if attackTime=1
          {
            var tNewAtk;
            for(i=0;i<8;i+=1)
            {
              for(ii=0;ii<6;ii+=1)
              {
                tNewAtk=instance_create(x+random_range(-20,20),y+random_range(-20,20),oPassBullet)
                tNewAtk.sprite_index=sAbom_ParaShot; tNewAtk.atkPower=atkPower; tNewAtk.image_speed=0.33
                tNewAtk.decayTime=-100; tNewAtk.direction=direction; tNewAtk.bulletSpeed=2+i
              }
            }
          }
          speed=abs(xSpd)
          if point_distance(x,y,checkSide,ySpawn)<=16
          {
            speed=0
            if currentSide=0 {currentSide=1}
            else {currentSide=0}
            largeLaserCheck+=1
            seqProg=0; seqTime=0
          }
        }
      }
      else if seqProg=4 //---------- ATTACK 4 ----------
      {
        if attackProg=0
        {
          if currentSide=0 {xSpd=2}
          else {xSpd=-2}
          ySpd=8
          attackProg+=1
        }
        else if attackProg=1
        {
          if ySpd>0 and y>zigzagBottom {ySpd=-8}
          if ySpd<0 and y<zigzagTop
          {
            playSound(global.snd_LightballSpread,0,0.95,34000)
            var tNewAtk,tDir;
            tDir=0
            for(i=0;i<bulletModD;i+=1)
            {
              tNewAtk=instance_create(x,y,oPassBullet)
              tNewAtk.sprite_index=sAbom_ParaShot; tNewAtk.atkPower=atkPower; tNewAtk.image_speed=0.33
              tNewAtk.decayTime=-100; tNewAtk.direction=tDir
              if i mod 2=0 {tNewAtk.bulletSpeed=4}
              else {tNewAtk.bulletSpeed=3}
              tDir+=360/bulletModD
            }
            ySpd=8
          }

          x+=xSpd
          y+=ySpd

          if (xSpd>0 and x>mapRight) or (xSpd<0 and x<mapLeft) {attackProg+=1}
        }
        else if attackProg=2
        {
          if currentSide=0 {currentSide=1}
          else {currentSide=0}
          largeLaserCheck+=1
          seqProg=0; seqTime=0
        }
      }

      //---------- Armor ----------
      armorAngle-=1
      if armorCheck=1 //Set up
      {
        armorDist=120
        armorCheck+=1
      }
      else if armorCheck=2 //Fade in
      {
        armorDist-=2
        armorAlpha+=0.025
        if armorAlpha>=1 {armorCheck+=1}
      }
      else if armorCheck=4 //Fade out
      {
        armorAlpha-=0.1
        if armorAlpha<=0 {armorCheck+=1}
      }

      //---------- Large laser ----------
      if largeLaserCheck=3
      {
        playSound(global.snd_ChargeStrike,0,1,17000)
        if oPlayer1.x<240 {instance_create(144,64,oPSF_LargeLaser)}
        else {instance_create(336,64,oPSF_LargeLaser)}
        largeLaserCheck=0
      }

      //---------- Rail rock ----------
      railRockTime+=1
      if railRockTime>=railRockDelay
      {
        instance_create(mapRight,320,oPSF_Cart_Rock)
        railRockTime=0
      }
    }
  }

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.78 and lifePercent>=0.59 and bossProgress=0
  {
    bulletModA-=1
    bulletModB-=1
    bulletModD+=2
    resType[3]=2
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=3; tAtkShield.atkUp=1
    bossProgress+=1
  }
  else if lifePercent<=0.58 and lifePercent>=0.36 and bossProgress=1
  {
    bulletModA-=1
    bulletModB-=1
    bulletModD+=2
    armorCheck=1
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    resType[4]=3
    bossProgress+=1
  }
  else if lifePercent<=0.35 and lifePercent>=0.16 and bossProgress=2
  {
    bulletModA-=1
    railRockDelay=200
    if hitCheckArrow>=hitCheckMissile
    {
      resType[1]=2
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
    }
    else
    {
      resType[5]=2
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
    }
    bossProgress+=1
  }
  else if lifePercent<=0.15 and lifePercent>=0 and bossProgress=3
  {
    bulletModB-=1
    bulletModD+=2
    if resType[1]=2
    {
      resType[5]=2
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
    }
    else
    {
      resType[1]=2
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=1; tAtkShield.atkUp=1
    }
    bossProgress+=1
  }
  enemyStepEvent()

  if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=60
    {
      if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
      var tEffect;
      tEffect=instance_create(x+random_range(-32,32),y+random_range(-32,32),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.3+random(0.3); tEffect.image_yscale=0.3+random(0.3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if deathAnim>61
    {
      if global.bBossGallery=1
      {
        bossRoomTally(60)
        global.newMapX=2168; global.newMapY=224; room_goto(rBossGallery)
      }
      else
      {
        oEvPttT.sceneProgress=2
        instance_destroy()
      }
    }
  }
}
else {speed=0}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if armorCheck=3
{
  if other.damageType="EXPLOSION"
  {
    armorHP-=1
    if armorHP<=0
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      resType[3]=2
      armorCheck+=1
    }
  }
}

if other.weaponTag=1 {hitCheckArrow+=1}
if other.weaponTag=41 {hitCheckMissile+=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if waveAUp=1
{
  scaleWaveA+=0.004
  if scaleWaveA>=0.55 {waveAUp=0}
}
else
{
  scaleWaveA-=0.004
  if scaleWaveA<=0.45 {waveAUp=1}
}
image_xscale=0.5+scaleWaveA
image_yscale=0.5+scaleWaveA
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if armorAlpha>0
{
  for(i=0;i<8;i+=1)
  {
    draw_sprite_ext(sPSF_Armor,image_index,x+lengthdir_x(armorDist,armorAngle+(i*45)),y+lengthdir_y(armorDist,armorAngle+(i*45)),image_xscale,image_yscale,armorAngle+(i*45),image_blend,armorAlpha)
  }
}
