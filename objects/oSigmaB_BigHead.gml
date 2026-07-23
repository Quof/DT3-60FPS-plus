#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0
image_alpha=0
bActive=true

//Enemy base statistics
eName="Sigma Head"
eLevel=18
maxLife=550
life=maxLife
pointWorth=5
atkPower=6
resType[0]=2
resType[1]=2
stunResist=50
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
greenFlash=make_color_rgb(150,255,150)

atkProg=0
atkTime=0
spikeSeq=0

xSpd=0
ySpd=0

mySolid=0
mySpikeA=0
mySpikeB=0

jeremyText="You're in the Boss Gallery now it seems. I'm not telling you anything about this guy, you already know what he can do. Plus I'm feeling lazy, leave me alone."
chaoText="Each of these cycles through an active phase and an inactive phase. The sequence never breaks; the order is in Yellow -> Red -> Blue. Between each of these active phases, Sigma will perform some actions that I'm not able to read unfortunately."
devText="When reviewing Mega Man X boss encounters, I was seeing that most of them followed fairly strict patterns. DT boss usually don't use this type of structure for bosses, letting them go more on reactions based on the player. For this Gate, I wanted to try having most of the bosses use the Mega Man X approach. It worked out really well I think."

alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(mySolid) {with mySolid {instance_destroy()}}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 or type=3 //Yellow
{
  resType[3]=4
  resType[5]=2
}
else if type=1 or type=4 //Red
{
  resType[2]=2
  resType[5]=4
  baseColor=make_color_rgb(255,0,50)
}
else if type=2 or type=5 //Blue
{
  resType[2]=4
  resType[3]=2
  baseColor=make_color_rgb(0,50,255)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    atkTime+=1
    if atkProg=0 //Fade in
    {
      if atkTime mod 4=0 //Flash color
      {
        if image_blend=baseColor {image_blend=greenFlash}
        else {image_blend=baseColor}
      }
      image_alpha+=0.04
      if image_alpha>=1
      {
        if oPlayer1.x>=x-26 and oPlayer1.x<=x+26 and oPlayer1.y>=y-16 and oPlayer1.y<=y+48 //Player is inside head
        {
          if y<176 {oPlayer1.y=y+80}
          else {oPlayer1.y=y-35}
        }
        mySolid=instance_create(x-28,y-40,oMovingSolid) //Create solid
        with mySolid
        {
          sprite_index=sInvisibleSolidMask; visible=0
          image_xscale=3.5; image_yscale=5
          viscidTop=1
          makeActive()
        }
        bCanTakeDamage=true
        image_blend=baseColor
        if type=0 {atkTime=10}
        else {atkTime=0}

        if bMain=1 {atkProg=1}
        else {atkProg=10}
      }
    }
    else if atkProg=1 //-------------------- MAIN ATTACK --------------------
    {
      x+=xSpd; y+=ySpd
      mySolid.xVel=xSpd; mySolid.yVel=ySpd

      if type=0 //---------- YELLOW 1 ----------
      {
        if atkTime mod 20=0
        {
          playSound(global.snd_Shock,0,0.88,1)
          var tNewAtk;
          tNewAtk=instance_create(x,y+16,oSigmaB_HeadBall)
          tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=10
          tNewAtk.direction=point_direction(x,y+16,oPlayer1.x,returnPlayerYCenter())
        }
      }
      else if type=1 //---------- RED ----------
      {
        if atkTime=1 {image_index=1}
        else if atkTime=4 {image_index=2}
        else if atkTime=7 {image_index=3}
        else if atkTime>=10
        {
          if atkTime mod 20=0
          {
            playSound(global.snd_Flame1,0,0.94,32000)
            var tNewAtk,tAtkDir;
            tAtkDir=point_direction(x+16,y,oPlayer1.x,returnPlayerYCenter())
            for(i=0;i<2;i+=1)
            {
              tNewAtk=instance_create(x-16+(i*32),y-24,oPassBullet)
              tNewAtk.sprite_index=sMMFireWall; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=12; tNewAtk.decayTime=-100
              tNewAtk.direction=90
              tNewAtk=instance_create(x-16+(i*32),y+24,oPassBullet)
              tNewAtk.sprite_index=sMMFireWall; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=12; tNewAtk.decayTime=-100
              tNewAtk.direction=270
              tNewAtk=instance_create(x+16+lengthdir_x(16,tAtkDir+90+(i*180)),y+lengthdir_y(16,tAtkDir+90+(i*180)),oPassBullet)
              tNewAtk.sprite_index=sMMFireWall; tNewAtk.image_speed=0.5
              tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=12; tNewAtk.decayTime=-100
              tNewAtk.direction=tAtkDir
            }
          }
        }
      }
      else if type=2 //---------- BLUE ----------
      {
        if atkTime=1 {image_xscale=-1; image_index=1}
        else if atkTime=4 {image_index=2}
        else if atkTime=7 {image_index=3}
        else if atkTime=11 {playSound(global.snd_FireCrackle,0,0.92,42000)}
        else if atkTime>=12
        {
          xSpd=-3
          var tIceBreath;
          tIceBreath=instance_create(x-22,y+17,oM_PoisonBreath)
          tIceBreath.atkPower=atkPower; tIceBreath.bulletSpeed=6+random(3); tIceBreath.image_blend=c_teal
          tIceBreath.animSpeed=0.25; tIceBreath.direction=235+random_range(-12,12)
        }
      }
      else if type=3 //---------- YELLOW 2 ----------
      {
        if atkTime=1 {image_xscale=-1; image_index=1}
        else if atkTime=4 {image_index=2}
        else if atkTime=7 {image_index=3}
        else if atkTime>=12
        {
          if atkTime mod assistMod=0
          {
            playSound(global.snd_Shock,0,0.88,32000)
            var tNewAtk;
            tNewAtk=instance_create(x-22,y+16,oPassBullet)
            tNewAtk.sprite_index=sSigmaB_ElectricBall; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=9
            tNewAtk.decayTime=-100; tNewAtk.direction=point_direction(x,y+16,oPlayer1.x,returnPlayerYCenter())
            tNewAtk.image_xscale=0.75; tNewAtk.image_yscale=0.75
          }
        }
      }
      else if type=4 //---------- YELLOW 3 ----------
      {
        if atkTime=1 {image_index=1}
        else if atkTime=4 {image_index=2}
        else if atkTime=7 {image_index=3}
        else if atkTime>=12
        {
          if atkTime mod assistMod=0
          {
            playSound(global.snd_Shock,0,0.88,32000)
            var tNewAtk;
            tNewAtk=instance_create(x+22,y+16,oPassBullet)
            tNewAtk.sprite_index=sSigmaB_ElectricBall; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=6
            tNewAtk.decayTime=-100; tNewAtk.direction=point_direction(x,y+16,oPlayer1.x,returnPlayerYCenter())
            tNewAtk.image_xscale=0.75; tNewAtk.image_yscale=0.75
          }
        }
      }
      else if type=5 //---------- RED 2 ----------
      {
        if atkTime=1 {image_xscale=-1; image_index=1}
        else if atkTime=4 {image_index=2}
        else if atkTime=7 {image_index=3}
        else if atkTime>=12
        {
          if atkTime mod assistMod=0
          {
            playSound(global.snd_Shock,0,0.88,36000)
            var tNewAtk;
            tNewAtk=instance_create(x-22,y+16,oPassBullet)
            tNewAtk.sprite_index=sSigmaB_ElectricBall; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=6
            tNewAtk.decayTime=-100; tNewAtk.direction=point_direction(x,y+16,oPlayer1.x,returnPlayerYCenter())
            tNewAtk.image_xscale=0.75; tNewAtk.image_yscale=0.75
          }
        }
      }
    }
    else if atkProg=100 //Fade out
    {
      if atkTime=1
      {
        bCanTakeDamage=false
        if instance_exists(mySpikeA) {with mySpikeA {instance_destroy()}}
        if instance_exists(mySpikeB) {with mySpikeB {instance_destroy()}}
        with mySolid {instance_destroy()}
      }
      if atkTime mod 4=0 //Flash color
      {
        if image_blend=c_white {image_blend=c_green}
        else {image_blend=c_white}
      }
      image_alpha-=0.04
      if image_alpha<=0 {instance_destroy()}
    }

    //----- Head Spikes -----
    if atkProg>=1
    {
      if spikeType=1 //Side
      {
        spikeSeq+=1
        if spikeSeq=11
        {
          mySpikeA=instance_create(x,y,oMarioSpikeCeiling)
          mySpikeA.sprite_index=sSigmaB_HeadSpike; mySpikeA.image_xscale=-0.1
          mySpikeA.bFollow=1; mySpikeA.idFollow=id; mySpikeA.xFollow=-33; mySpikeA.yFollow=-18
          mySpikeB=instance_create(x,y,oMarioSpikeCeiling)
          mySpikeB.sprite_index=sSigmaB_HeadSpike; mySpikeB.image_xscale=0.1
          mySpikeB.bFollow=1; mySpikeB.idFollow=id; mySpikeB.xFollow=33; mySpikeB.yFollow=-18
        }
        else if spikeSeq>=12 and spikeSeq<=20
        {
          mySpikeA.image_xscale-=0.1
          mySpikeB.image_xscale+=0.1
        }
      }
      else if spikeType=2 //Top
      {
        spikeSeq+=1
        if spikeSeq=11
        {
          mySpikeA=instance_create(x,y,oMarioSpikeCeiling)
          mySpikeA.sprite_index=sSigmaB_HeadSpike; mySpikeA.image_xscale=-0.1; mySpikeA.image_angle=90
          mySpikeA.bFollow=1; mySpikeA.idFollow=id; mySpikeA.xFollow=11; mySpikeA.yFollow=-40
        }
        else if spikeSeq>=12 and spikeSeq<=20 {mySpikeA.image_xscale-=0.1}
      }
    }
  }
  else
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x-16,y-16,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect=instance_create(x+16,y-16,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect=instance_create(x-16,y+16,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect=instance_create(x+16,y+16,oEffect); tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if oSigmaB.life>=800 {oSigmaB.life-=300}
    instance_destroy()
  }
  enemyStepEvent()
}
