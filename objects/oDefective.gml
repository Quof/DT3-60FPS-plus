#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Defective"
eLevel=35
maxLife=6100
life=maxLife
atkPower=15
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resistChange=0
resType[resistChange]=3
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
ringBulletTime=70
ringBulletDelay=210
ringBulletAmt=0
ringBulletMax=2
lightningTime=0
lightningDelay=250
lightningAmt=0
lightningMax=1

spikeProg=0
insultTime=490
insultDelay=720
insultNum=0
newSoundVol=0
pastAbilityA=0
pastAbilityB=0
//--------------------
armRotA=0
armRotB=0
phase=0
goDown=1
xSpd=0
ySpd=0

//Misc Data
xCenter=864
yGround=256
roomSpan=288

jeremyText="There's not much I can look up about this... thing. It's all scrambled. Only thing I'm able to interpret is that its resists cycle, but I don't know when."
chaoText="Same with Jeremy, I can't pull up anything about it. I'm pretty sure this thing was created just now. Huh... looks like its resists cycles with a certain attack that it performs? Ugh, this is so weird."
devText=". . ."

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
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //-------------------- MOVEMENT --------------------
    if goDown=0 //Up
    {
      if ySpd>-0.4 {ySpd-=0.01}
      if y<=96 {goDown=1}
    }
    else //Down
    {
      if ySpd<0.4 {ySpd+=0.01}
      if y>=192 {goDown=0}
    }
    if x>oPlayer1.x
    {
      if xSpd>-1.5 {xSpd-=0.01}
    }
    else
    {
      if xSpd<1.5 {xSpd+=0.01}
    }

    x+=xSpd; y+=ySpd

    //-------------------- ATTACK: RING BULLETS --------------------
    ringBulletTime+=1
    if ringBulletTime>=ringBulletDelay
    {
      var tAtk,tDir,tType;
      tDir=0
      tType=0
      if ringBulletAmt mod 2=0 {tType=1}
      for(i=0;i<20;i+=1)
      {
        tAtk=instance_create(x,y,oDefProjA)
        tAtk.direction=tDir; tAtk.type=tType
        tDir+=360/20
      }
      ringBulletAmt+=1
      if ringBulletAmt>=ringBulletMax
      {
        //Cycle through resists
        resistChange+=1
        if resistChange=6 {resistChange=0}
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        resType[resistChange]=3

        ringBulletAmt=0
        ringBulletTime=0
      }
      else {ringBulletTime=ringBulletDelay-20}
    }

    //-------------------- ATTACK: SKY LIGHTNING --------------------
    lightningTime+=1
    if lightningTime>=lightningDelay
    {
      var tAtk,;
      tAtk=instance_create(oPlayer1.x,0,oDefLightning)
      lightningAmt+=1
      if lightningAmt>=lightningMax
      {
        lightningAmt=0
        lightningTime=0
      }
      else {lightningTime=lightningDelay-25}
    }
    //-------------------- SPIKE WALLS --------------------
    if spikeProg=1
    {
      mySpikeA=instance_create(320,0,oDefSpike); mySpikeA.movement=272
      mySpikeB=instance_create(1408,0,oDefSpike); mySpikeB.movement=272; mySpikeB.image_xscale=-1
      spikeProg=2
    }

    //-------------------- INSULTS --------------------
    insultTime+=1
    if insultTime>=insultDelay and insultTime<=insultDelay+100
    {
      image_speed=0; insultTime=10000
    }
    else if insultTime=10001 //Insult player
    {
      var tMessage;
      tMessage=""
      if insultNum=0 {tMessage="You are worthless..."}
      else if insultNum=1 {tMessage="Pathetic..."}
      else if insultNum=2 {tMessage="Incompetent."}
      else if insultNum=3 {tMessage="You can't help anyone."}
      else if insultNum=4 {tMessage="You let them down."}
      else if insultNum=5 {tMessage="You are a failure."}
      msgCreate(200,48,"Defective",tMessage,7,0,oMessagePerson,0)
      newMessage.fadingTime=90
      insultNum+=1
      if insultNum=6 {insultNum=0}
      global.bSoundCanPlay=0
      for(i=0;i<5;i+=1)
      {
        if global.hasAbilToken[i]>=2 {global.hasAbilToken[i]=1}
      }
      pastAbilityA=global.activeAbility[0]
      pastAbilityB=global.activeAbility[1]
      global.activeAbility[0]=0
      global.activeAbility[1]=0
    }
    else if insultTime=10090 //Reset sound volume
    {
      global.bSoundCanPlay=1
      abilSetRemove(0)
      global.activeAbility[0]=pastAbilityA
      global.activeAbility[1]=pastAbilityB
      insultTime=0
    }
  }
  enemyStepEvent()

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.9 and lifePercent>=0.71 and bossProgress=0
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    spikeProg=1
    bossProgress+=1
  }
  else if lifePercent<=0.7 and lifePercent>=0.56 and bossProgress=1
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.55 and lifePercent>=0.39 and bossProgress=2
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    lightningMax+=1
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.38 and lifePercent>=0.2 and bossProgress=3
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=32; mySpikeB.movement+=32
    bossProgress+=1
  }
  else if lifePercent<=0.19 and lifePercent>=0 and bossProgress=4
  {
    ringBulletDelay-=4
    lightningDelay-=4
    insultDelay-=10
    if insultTime<insultDelay/2 {insultTime+=200}
    mySpikeA.movement+=16; mySpikeB.movement+=16
    bossProgress+=1
  }
}

if life<=0 //Defeat animation
{
  deathAnim+=1
  if deathAnim=1
  {
    with oEProjectileBase {instance_destroy()}
    with oMovingSolid {instance_destroy()}
    with oAttackBase {instance_destroy()}
  }
  else if deathAnim>=2
  {
    y+=1
    image_alpha-=0.02
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(53)
        global.newMapX=568; global.newMapY=560; room_goto(rBossGallery)
      }
      else
      {
        oEvCh19MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
armRotA+=2
for(i=0;i<12;i+=1)
{
  draw_sprite_ext(sDefective_ArmA,image_index,x+lengthdir_x(50,armRotA+(30*i)),y+lengthdir_y(50,armRotA+(30*i)),1,1,armRotA+(30*i),image_blend,image_alpha)
}

armRotB-=3
for(i=0;i<12;i+=1)
{
  draw_sprite_ext(sDefective_ArmB,image_index,x+lengthdir_x(50,armRotB+(30*i)),y+lengthdir_y(50,armRotB+(30*i)),1,1,armRotB+(30*i),image_blend,image_alpha)
}

phase+=0.02
draw_sprite_wave(sprite_index,image_index,x,y,1,12,1,phase)
