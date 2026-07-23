#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Phase times: 24,29,29,45,85,121

event_inherited()
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="The Executive"
eLevel=40
maxLife=30000
life=maxLife
atkPower=9
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

phaseNum=6 //Total phases
atkPhase=1 //Current phase

moveProg=0
moveTime=0
currHspd=0
currVspd=0
maxSpeed=4

atkProg=0
for(i=0;i<5;i+=1) {atkTime[i]=0}

phase1_circle=1
phase2_cycle=0
phase2_lineLength=3
phase2_extraLine=0
phase2_shootUnder=0
phase3_platformAppear=0
phase3_aimedBullets=28
phase3_bulletScaleA=1
phase3_bulletScaleB=1
phase4_pillarHeight=2
phase4_bulletLines=0
phase5_continuousCycle=1
newColorFinal=make_color_rgb(150,150,255)
phase6_phase=1
phase6_normalRes=1
phase6_bulletCheckA=0
phase6_canMove=1

leftPlatA=0
leftPlatB=0
rightPlatA=0
rightPlatB=0
phase6_platA=0
phase6_platB=0
phase6_platC=0
phase6_platD=0
heartGrab=0
pepsiLogo=0

//Misc Data
xCenter=864
yGround=312
roomSpan=192

for(i=0;i<3;i+=1) {exVal[i]=0}

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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=3
    jeremyText="This may be non-canon, but the same game rules still apply. There ARE a few new rules though. Jerry, you can parry his blue bullets. His green bullets can be taken out with your secondary attacks, but can't be parried. The red bullets can't be parried or dashed through, avoid them entirely. Anything else, and remember this, will be normal non-Gate 6 rules... uh, you got all that?"
    chaoText="The boss isn't too happy with us and it's going to take effort to cool him down... ugh, why did I stoop that low? Anyway, he's insanely difficult. There's also an extra rule here that's beneficial. Jerry's Wave of Awesome that's created after he parries will restore 2 Game Power for every bullet it eats."
    devText="I had quite a few alternate ending ideas. One of them I thought of directly referencing Chrono Trigger, specifically the reptite ending. In another one, I thought about having the player control Hex to fight Jerry and Claire due to it turning out that he was the hero the whole time. That required coding ANOTHER play style, so it was dropped. I'm happy with what I chose in the end though. Plus the fanbase asked for a super boss. This is your fault, remember that. <3 (I'm aware this bleeds off the edge.)"
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if oGame.time mod 3=0
    {
      if image_xscale=1 {image_xscale=-1}
      else {image_xscale=1}
    }

    for(i=0;i<5;i+=1)
    {
      atkTime[i]+=1
    }

    if heartGrab>0 {heartGrab-=1}

    //ATTACK PHASES
    event_user(atkPhase)

    //---------- Boss Difficulty Curve ----------
    if atkPhase=1 //========================================
    {
      if bossProgress=0 and life<=maxLife-5000
      {
        phase1_circle=0
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-10000
      {
        resType[1]=1; resType[5]=1
        atkTime[2]=0
        phase1_circle=2
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-15000
      {
        resType[1]=3; resType[5]=3
        moveProg=1
        bossProgress+=1
      }
      else if bossProgress=3 and life<=maxLife-20000
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        with oEProjectileBase {instance_destroy()}
        life=maxLife; bCanTakeDamage=0; bCanDealDamage=0
        event_user(8)
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
      }
    }
    else if atkPhase=2 //========================================
    {
      if bossProgress=0 and life<=maxLife-5000
      {
        phase2_shootUnder=1
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-9000
      {
        phase2_extraLine=1
        atkTime[3]=260
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-14000
      {
        resType[5]=1
        phase2_lineLength+=1
        bossProgress+=1
      }
      else if bossProgress=3 and life<=maxLife-20000
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        with oEProjectileBase {instance_destroy()}
        life=maxLife; bCanTakeDamage=0; bCanDealDamage=0
        event_user(8)
        atkProg=0
        resType[5]=3
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
      }
    }
    else if atkPhase=3 //========================================
    {
      if bossProgress=0 and life<=maxLife-10000
      {
        atkTime[0]=0
        phase3_aimedBullets=22
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-14000
      {
        resType[1]=1; resType[5]=1
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-20000
      {
        jeremyText="<CURRENTLY AWAY>"
        chaoText="Zzzzz"
        devText="I don't know why they're not responding."
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        with oLargeJumper {instance_destroy()}
        with oEProjectileBase {instance_destroy()}
        tile_layer_hide(999998)
        with midPlatA {instance_destroy()}; with midPlatB {instance_destroy()};
        life=maxLife; bCanTakeDamage=0; bCanDealDamage=0
        event_user(8)
        resType[1]=3; resType[5]=3
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
      }
    }
    else if atkPhase=4 //========================================
    {
      if bossProgress=0 and life<=maxLife-3000
      {
        phase4_pillarHeight=3
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-6000
      {
        resType[1]=1; resType[5]=1
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-9000
      {
        phase4_pillarHeight=5
        resType[3]=1
        bossProgress+=1
      }
      else if bossProgress=3 and life<=maxLife-13000
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
        instance_create(704,288,oLargeJumper)
        instance_create(852,288,oLargeJumper)
        instance_create(1000,288,oLargeJumper)
        var tNewCrystal;
        tNewCrystal=instance_create(864,124,oLatchCrystal); tNewCrystal.image_alpha=0.4; tNewCrystal.bDamageFlash=0
        tNewCrystal.depth=50; tNewCrystal.image_xscale=24; tNewCrystal.image_yscale=5
        moveProg=10
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        bossProgress+=1
      }
      else if bossProgress=4 and life<=maxLife-16000
      {
        phase4_bulletLines=1
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
        bossProgress+=1
      }
      else if bossProgress=5 and life<=maxLife-20000
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        with oLargeJumper {instance_destroy()}
        with oLatchCrystal {instance_destroy()}
        with oEProjectileBase {instance_destroy()}
        life=maxLife; bCanTakeDamage=0; bCanDealDamage=0
        event_user(8)
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
      }
    }
    else if atkPhase=5 //========================================
    {
      if bossProgress=0 and life<=maxLife-20000
      {
        jeremyText="Okay, take note that he's completely invulnerable now. Since you guys lost against this guy a bazillion times, I took that time to sneak into his office. Well, I figured out that he becomes vulnerable to NORMAL type attacks when all the blue bullets have been destroyed. Eh... but Claire, you'll need to parry to do any decent damage."
        chaoText="Hmm? Oh sorry, I fell asleep because you guys were losing too much. Uh, go team?##Yeah! GO TEAM!!##Wait a sec! Jerry, your Wave of Awesome is a bit bigger for this phase! Oh and while he's on the floor, you should be able to damage him after a parry, Jerry."
        devText="Full disclosure, the game doesn't check how many times you've lost here. These messages are the same regardless. Though lets be honest, your death count went up at least a few points... unless this is a return visit."
        oPlayer1.waveOfAwesomeScale=4
        var tNewScanInfo; tNewScanInfo=instance_create(x,y,oMsgNewScanInfo); tNewScanInfo.myTarget=id; tNewScanInfo.xOffset=0; tNewScanInfo.yOffset=-48
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        with oLargeJumper {instance_destroy()}
        with oEProjectileBase {instance_destroy()}
        maxLife=30000; life=maxLife; bCanTakeDamage=0; bCanDealDamage=0
        event_user(8)
        for(i=0;i<6;i+=1) {resType[i]=1}
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
      }
    }
    else if atkPhase=6 //========================================
    {
      if bossProgress=0 and life<=maxLife-2000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-5000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-8000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=3 and life<=maxLife-11000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=4 and life<=maxLife-14000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=5 and life<=maxLife-17000
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
        tile_layer_hide(999999)
        if instance_exists(leftPlatA)
        {
          with leftPlatA {instance_destroy()}
          with leftPlatB {instance_destroy()}
          with rightPlatA {instance_destroy()}
          with rightPlatB {instance_destroy()}
        }
        for(i=0;i<6;i+=1) {resType[i]=1}
        phase6_phase=6
        phase6_bulletCheckA=0
        moveTime=0; moveProg=1
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        bossProgress+=1
      }
      else if bossProgress=6 and life<=maxLife-20000
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
        with oExe_TempPlat {instance_destroy()}
        life=maxLife-20000
        phase6_phase=7
        moveTime=0; moveProg=1
        for(i=0;i<6;i+=1) {resType[i]=1}
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        bossProgress+=1
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      if global.difficulty=2 or global.bNightmareMode=1
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,12)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNoticeSS)
          tAchievement.myAchievement="Pure Skill"; tAchievement.checkNum=12
        }
      }
    }
    else if deathAnim=2
    {
      ini_open(global.paraString[0])
      sectionWrite="ALPHA"
      ini_write_string(sectionWrite,"143ss",global.tokenRecognitionsSetTwo)
      ini_close()
    }

    if image_blend=c_white {image_blend=c_red}
    else {image_blend=c_white}

    if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
    tEffect=instance_create(x+random_range(-17,17),y+random_range(-34,34),oEffect); tEffect.sprite_index=sShipExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5+random(0.5)

    if deathAnim>=60
    {
      playSound(global.snd_HardHit1,0,1,14000)
      for(i=0;i<32;i+=1)
      {
        tEffect=instance_create(x+random_range(-34,34),y+random_range(-68,68),oEffect); tEffect.sprite_index=sShipExplosion
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5+random(0.5)
      }
      if global.bBossGallery=1
      {
        bossRoomTally(63)
        global.newMapX=2776; global.newMapY=224; room_goto(rBossGallery)
      }
      else
      {
        oEvAltAbomEnding.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkPhase=3
{
  if global.stJGame_C[0]>4000
  {
    resType[3]=4
    event_inherited()
    resType[3]=3
  }
  else {event_inherited()}
}
else if atkPhase=4
{
  if global.stJGame_C[0]>4000
  {
    if bossProgress<3 {resType[0]=4}
    if bossProgress<4 {resType[3]=3}
    else {resType[0]=3}
    event_inherited()
    resType[0]=2
    if bossProgress<4 {resType[3]=2}
    else {resType[3]=1}
  }
  else {event_inherited()}
}
else if atkPhase=6
{
  if global.stJGame_C[0]>4000
  {
    if phase6_phase<=3 {resType[3]=2}
    resType[0]=3
    event_inherited()
    resType[0]=phase6_normalRes
    resType[3]=1
  }
  else {event_inherited()}
}
else {event_inherited()}
#define Collision_oHealthPickup
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if heartGrab=0 and life<maxLife and atkPhase!=5
{
  playSound(global.snd_HealthPickup,0,1,15000)
  life+=250
  if life>maxLife {life=maxLife}

  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sHeal; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  msgCreate(32,128,"Executive","If you don't want the hearts, I'll take them.",0,1,oMessagePerson,0)
  newMessage.fadingTime=70
  with other {instance_destroy()}
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Dick bullet pattern
for(i=0;i<20;i+=1)
{
  var tAtk; tAtk=instance_create(800+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+180
  var tAtk; tAtk=instance_create(928+lengthdir_x(640,18*i),256+lengthdir_y(640,18*i),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+180
}
for(i=0;i<10;i+=1)
{
  var tAtk; tAtk=instance_create(864+lengthdir_x(640,9+(18*i)),112+lengthdir_y(640,9+(18*i)),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=(18*i)+189
}
for(i=0;i<8;i+=1)
{
  var tAtk; tAtk=instance_create(224,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=0
  var tAtk; tAtk=instance_create(1504,128+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=180
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 1
if moveProg=1 //----- Teleport -----
{
  moveTime+=1
  if moveTime=15
  {
    instance_create(x,y,oExe_Ef_Flame)
    bCanTakeDamage=0; bCanDealDamage=0; image_alpha=0; phase1_circle=0; atkTime[2]=0
    x=xCenter; y=80; sprite_index=sPT_EX_Outline
    playSound(global.snd_Teleport,0,0.92,44100)
  }
  else if moveTime>=51 and moveTime<=70 {image_alpha+=0.05}
  else if moveTime=71
  {
    sprite_index=sPT_FE_ArmsOut; bCanTakeDamage=1; bCanDealDamage=1; phase1_circle=2
    for(i=0;i<48;i+=1)
    {
      if exVal[0]=0 {var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=7.5*i; exVal[0]+=1}
      else if exVal[0]=1 {var tAtk; tAtk=instance_create(x,y,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=7.5*i; exVal[0]+=1}
      else if exVal[0]=2 {var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=7.5*i; exVal[0]=0}
    }
    moveProg=2; moveTime=0
  }
}

if atkTime[0] mod 12=0 //----- Vertical lines -----
{
  if atkTime[0]>=12 and atkTime[0]<=96
  {
    var tAtk; tAtk=instance_create(xCenter-72,2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
  }
  else if atkTime[0]>=108 and atkTime[0]<=144
  {
    var tAtk; tAtk=instance_create(xCenter-72,2,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
  }

  if atkTime[0]>=24 and atkTime[0]<=60
  {
    var tAtk; tAtk=instance_create(xCenter+72,2,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
  }
  else if atkTime[0]=12 or (atkTime[0]>=60 and atkTime[0]<=144)
  {
    var tAtk; tAtk=instance_create(xCenter+72,2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
  }
  if atkTime[0]=144 {atkTime[0]=0}

  if atkTime[3]=72 //----- Horizontal lines -----
  {
    for(i=0;i<7;i+=1)
    {
      var tAtk; tAtk=instance_create(xCenter-56+(18*i),2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
    }
  }
  else if atkTime[3]=216
  {
    for(i=0;i<6;i+=1)
    {
      var tAtk; tAtk=instance_create(xCenter-180+(18*i),2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
      var tAtk; tAtk=instance_create(xCenter+88+(18*i),2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
    }
  }
  else if atkTime[3]=288 {atkTime[3]=0}
}

if phase1_circle=1 //----- Circle straight -----
{
  atkTime[2]+=1
  if atkTime[2]>=100
  {
    for(i=0;i<16;i+=1)
    {
      var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=22.5*i
    }
    atkTime[2]=0
  }
}
else if phase1_circle=2 //----- Circle line curve -----
{
  atkTime[2]+=1
  if atkTime[2]>=150 and atkTime[2] mod 5=0
  {
    for(i=0;i<16;i+=1)
    {
      var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=2; tAtk.curveTime=50; tAtk.direction=22.5*i
    }
  }
  if atkTime[2]>=180 {atkTime[2]=0}
}

atkTime[4]+=1
if atkTime[4]=220 //----- Diagonal lines -----
{
  for(i=0;i<16;i+=1)
  {
    var tAtk; tAtk=instance_create(xCenter+110+(i*12),-16+(i*10),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=225
  }
}
else if atkTime[4]=440
{
  for(i=0;i<16;i+=1)
  {
    var tAtk; tAtk=instance_create(xCenter-110-(i*12),-16+(i*10),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=315
  }
  atkTime[4]=0
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 2
if moveProg=0 //----- Move into place -----
{
  moveTime+=1
  if moveTime=1 {bCanDealDamage=0}
  if moveTime>=10
  {
    direction=point_direction(x,y,xCenter-144,208)
    speed=4
    if point_distance(x,y,xCenter-144,208)<=4
    {
      x=xCenter-144; y=208
      atkTime[2]=15
      speed=0
      bCanTakeDamage=1; bCanDealDamage=1
      moveTime=0; moveProg=1
    }
  }
}
else if moveProg=1 //----- Targeted swirly bullet line -----
{
  if atkTime[2]=76 {exVal[0]=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)}
  if atkTime[2]>=77 and atkTime[2] mod 7=0
  {
    var tAtk; tAtk=instance_create(x,y,oExe_FireGreen); tAtk.type=2; tAtk.bulSpd=1.5; tAtk.curveAmt=30; tAtk.direction=exVal[0]
  }
  if atkTime[2]>=77+(phase2_lineLength*7) {atkTime[2]=0}

  if atkTime[1]>=490 and atkTime[2]<=41 {atkTime[2]=15}
}

if oGame.time mod 8=0 //----- Side red vertical lines -----
{
  var tAtk; tAtk=instance_create(xCenter-176,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=270
  var tAtk; tAtk=instance_create(xCenter+176,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=270
}

if atkTime[0]=55 //----- Vertical lines -----
{
  for(i=0;i<8;i+=1)
  {
    for(ii=0;ii<6;ii+=1)
    {
      var tAtk; tAtk=instance_create(xCenter-160+(ii*64),-4-(i*20),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=270
    }
  }
}
else if atkTime[0]=110
{
  for(i=0;i<8;i+=1)
  {
    for(ii=0;ii<5;ii+=1)
    {
      var tAtk; tAtk=instance_create(xCenter-128+(ii*64),-4-(i*20),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=270
    }
  }
  atkTime[0]=0
}

if atkTime[1]=70 //Blue bullet
{
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
}
else if atkTime[1]=140
{
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
}
else if atkTime[1]=210
{
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
}
else if atkTime[1]=410
{
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
}

if atkTime[1]=250 //----- 2 green lines -----
{
  for(i=0;i<2;i+=1)
  {
    for(ii=0;ii<23;ii+=1)
    {
      var tAtk; tAtk=instance_create(xCenter-160+(ii*16),-4-(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270
    }
  }
}
else if atkTime[1]=420 //----- Red line -----
{
  for(i=0;i<23;i+=1)
  {
    var tAtk; tAtk=instance_create(xCenter-160+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=270
  }
}
else if atkTime[1]=530 //----- Teleport to top -----
{
  playSound(global.snd_Teleport,0,0.92,44100)
  instance_create(x,y,oExe_Ef_Outline)
  if phase2_cycle=0 {x=xCenter-144; y=80}
  else {x=xCenter+144; y=80}
}
else if atkTime[1]=535
{
  if phase2_cycle=0
  {
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=300
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=315
  }
  else
  {
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=240
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=225
  }
}
else if atkTime[1]=540
{
  playSound(global.snd_Teleport,0,0.92,44100)
  instance_create(x,y,oExe_Ef_Outline)
  x=xCenter; y=80
}
else if atkTime[1]=545
{
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=285
  var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=255
}
else if atkTime[1]=550
{
  playSound(global.snd_Teleport,0,0.92,44100)
  instance_create(x,y,oExe_Ef_Outline)
  if phase2_cycle=0 {x=xCenter+144; y=80}
  else {x=xCenter-144; y=80}
}
else if atkTime[1]=555
{
  if phase2_cycle=0
  {
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=240
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=225
  }
  else
  {
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=300
    var tAtk; tAtk=instance_create(x,y,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=315
  }
}
else if atkTime[1]>=590 //----- Move down -----
{
  y+=2
  if y>=208
  {
    phase2_cycle=!phase2_cycle
    y=208
    atkTime[1]=0
  }
}

if phase2_shootUnder=1 //----- Shoot under -----
{
  if atkTime[1]<=520
  {
    if atkTime[4] mod 10=0
    {
      for(i=0;i<3;i+=1)
      {
        var tAtk; tAtk=instance_create(x-24+(i*24),y+24,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=270
      }
    }
  }
}

if phase2_extraLine=1 //----- Extra bullet line -----
{
  if atkTime[3]=269
  {
    if exVal[2]=0 {exVal[1]=720}
    else {exVal[1]=1008}
  }
  if atkTime[3]=290
  {
    var tAtk; tAtk=instance_create(exVal[1],-4,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=2.5; tAtk.direction=270
    if exVal[2]=0 {exVal[1]+=32}
    else {exVal[1]-=32}

    atkTime[3]=270
    if exVal[1]<=720 or exVal[1]>=1008
    {
      exVal[2]=!exVal[2]
      atkTime[3]=0
    }
  }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 3
if moveProg=0 //Move to corner
{
  moveTime+=1
  if moveTime=1
  {
    oPlayer1.jumpTimeTotal=37
    bCanDealDamage=0
  }
  if moveTime>=10
  {
    direction=point_direction(x,y,688,64)
    speed=4
    if point_distance(x,y,688,64)<=4
    {
      x=688; y=64
      speed=0
      bCanTakeDamage=1; bCanDealDamage=1
      moveTime=0; moveProg+=1
    }
  }
}
else if moveProg=1 //Move to bottom-left
{
  direction=point_direction(x,y,688,288)
  speed=2
  if point_distance(x,y,688,288)<=2
  {
    x=688; y=288
    moveProg+=1
  }
}
else if moveProg=2 //Move to bottom-right
{
  direction=point_direction(x,y,1024,288)
  speed=2
  if point_distance(x,y,1024,288)<=2
  {
    x=1024; y=288
    moveProg+=1
  }
}
else if moveProg=3 //Move to top-right
{
  direction=point_direction(x,y,1024,64)
  speed=2
  if point_distance(x,y,1024,64)<=2
  {
    x=1024; y=64
    moveProg+=1
  }
}
else if moveProg=4 //Move to top-left
{
  direction=point_direction(x,y,688,64)
  speed=2
  if point_distance(x,y,688,64)<=2
  {
    x=688; y=64
    moveProg=1
  }
}

if phase3_platformAppear=0 //----- Platforms appear in the middle -----
{
  if oPlayer1.y>=272
  {
    tile_layer_show(999998)
    midPlatA=instance_create(752,184,oInvisibleSolid); midPlatA.image_xscale=4
    midPlatB=instance_create(912,184,oInvisibleSolid); midPlatB.image_xscale=4
    phase3_platformAppear=1
  }
}

if moveProg>=1
{
  if atkTime[0] mod phase3_aimedBullets=0 //----- Continuous aimed bullets -----
  {
    if exVal[0]=0 {var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)}
    else {var tAtk; tAtk=instance_create(x,y,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)}
    exVal[0]=!exVal[0]
  }

  if atkTime[1]=200 or atkTime[1]=600 or atkTime[1]=1000 or atkTime[1]=1400 //----- Circle formation -----
  {
    var tLocX,tCirY1,tCirY2,tCirDir,tBlueY;
    if x<=xCenter-96 {tLocX=xCenter+152} //Find x position
    else if x>=xCenter+96 {tLocX=xCenter-152}
    else {tLocX=xCenter}

    tCirY1=416; tCirY2=143; tCirDir=90; tBlueY=-64
    exVal[1]=!exVal[1]

    for(i=0;i<18;i+=1)
    {
      var tAtk; tAtk=instance_create(tLocX+lengthdir_x(44,tCirY2+(15*i)),tCirY1+lengthdir_y(44,tCirY2+(15*i)),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.75; tAtk.direction=tCirDir
    }
    var tAtk; tAtk=instance_create(tLocX,tBlueY,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=tCirDir+180; tAtk.image_xscale=phase3_bulletScaleA; tAtk.image_yscale=phase3_bulletScaleA
  }

  if atkTime[1]=400 //Bottom-right opening
  {
    for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(1120,48+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180}
    for(i=0;i<5;i+=1)
    {
      var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleA; tAtk.image_yscale=phase3_bulletScaleA
      var tAtk; tAtk=instance_create(1144,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
      var tAtk; tAtk=instance_create(1096,240+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
    }
  }
  else if atkTime[1]=800 //Top-left opening
  {
    for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(608,48+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0}
    for(i=0;i<5;i+=1)
    {
      var tAtk; tAtk=instance_create(608,96+(i*16),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleA; tAtk.image_yscale=phase3_bulletScaleA
      var tAtk; tAtk=instance_create(584,96+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
      var tAtk; tAtk=instance_create(632,96+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
    }
    for(i=0;i<9;i+=1) {var tAtk; tAtk=instance_create(608,176+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0}
  }
  else if atkTime[1]=1200 //Top-right opening
  {
    for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,48+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180}
    for(i=0;i<5;i+=1)
    {
      var tAtk; tAtk=instance_create(1120,96+(i*16),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleA; tAtk.image_yscale=phase3_bulletScaleA
      var tAtk; tAtk=instance_create(1144,96+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
      var tAtk; tAtk=instance_create(1096,96+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
    }
    for(i=0;i<9;i+=1) {var tAtk; tAtk=instance_create(1120,176+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180}
  }
  else if atkTime[1]=1600 //Bottom-left opening
  {
    for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(608,48+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0}
    for(i=0;i<5;i+=1)
    {
      var tAtk; tAtk=instance_create(608,240+(i*16),oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleA; tAtk.image_yscale=phase3_bulletScaleA
      var tAtk; tAtk=instance_create(584,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
      var tAtk; tAtk=instance_create(632,240+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=0; tAtk.image_xscale=phase3_bulletScaleB; tAtk.image_yscale=phase3_bulletScaleB
    }
    atkTime[1]=0
  }
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 4
if moveProg=0 //Move to bottom-center
{
  moveTime+=1
  if moveTime=1
  {
    oPlayer1.jumpTimeTotal=21
    bCanDealDamage=0
  }
  if moveTime>=10
  {
    direction=point_direction(x,y,xCenter,272)
    speed=4
    if point_distance(x,y,xCenter,272)<=4
    {
      x=xCenter; y=272
      speed=0
      bCanTakeDamage=1; bCanDealDamage=1
      resType[0]=2; resType[3]=2
      moveTime=0; moveProg+=1
    }
  }
}
else if moveProg=1 //Move slowly toward player
{
  if x>oPlayer1.x+4 {x-=1}
  else if x<oPlayer1.x-4 {x+=1}
}
else if moveProg=2 //Wait till slash ends
{
  if !instance_exists(oExe_FireSlash)
  {
    atkTime[0]=0
    moveProg=1
  }
}
else if moveProg=10 //Slight wait (Between attack phase)
{
  moveTime+=1
  if moveTime>=30
  {
    moveTime=0; moveProg+=1
  }
}
else if moveProg=11 //Track player x
{
  if x>oPlayer1.x
  {
    if currHspd>-maxSpeed {currHspd-=0.2}
    else {currHspd+=0.2}
  }
  else if x<oPlayer1.x
  {
    if currHspd<maxSpeed {currHspd+=0.2}
    else {currHspd-=0.2}
  }

  if x<=704 {x=705; currHspd*=-1}
  else if x>=1024 {x=1023; currHspd*=-1}

  hspeed=currHspd

  moveTime+=1
  if moveTime=60 //End track period before attack
  {
    hspeed=0
    moveTime=0; moveProg=12
  }
}
else if moveProg=12 //Slight wait
{
  moveTime+=1
  if moveTime=25
  {
    var tNewAtk,tChkDir;
    if x>oPlayer1.x {tChkDir=-1}
    else {tChkDir=1}
    tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
    tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
  }
  else if moveTime=30
  {
    currVspd=-9
    moveTime=0; moveProg+=1
  }
}
else if moveProg=13
{
  if exVal[0]=0 and currVspd>=-2 and phase4_bulletLines=0 //Bullets after attack
  {
    if exVal[1]=0
    {
      var tAtk; tAtk=instance_create(608,144,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=0
      exVal[1]=1
    }
    else if exVal[1]=1
    {
      var tAtk; tAtk=instance_create(608,96,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=0
      var tAtk; tAtk=instance_create(608,192,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=0
      exVal[1]=0
    }
    exVal[0]=1
  }

  currVspd+=0.25
  vspeed=currVspd

  if currVspd>=1 and y>=272
  {
    y=272
    currVspd=0; vspeed=0
    exVal[0]=0
    moveProg=11
  }
}

if moveProg>=1 and moveProg<=9
{
  if atkTime[0]=105 //Periodic melee attack
  {
    var tNewAtk,tChkDir;
    if x>oPlayer1.x {tChkDir=-1}
    else {tChkDir=1}
    tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
    tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
    moveProg=2
  }

  if atkTime[1]=100 //Bullet pillars from the side
  {
    for(i=0;i<phase4_pillarHeight;i+=1) {var tAtk; tAtk=instance_create(608,304-(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}
  }
  else if atkTime[1]=200
  {
    for(i=0;i<phase4_pillarHeight+1;i+=1) {var tAtk; tAtk=instance_create(608,304-(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}
  }
  else if atkTime[1]=300
  {
    for(i=0;i<phase4_pillarHeight;i+=1) {var tAtk; tAtk=instance_create(1120,304-(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}
  }
  else if atkTime[1]=400
  {
    for(i=0;i<phase4_pillarHeight+1;i+=1) {var tAtk; tAtk=instance_create(1120,304-(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}
    atkTime[1]=0
  }

  //Bullet circles on top
  if atkTime[2]=140 //Left
  {
    for(i=0;i<24;i+=1)
    {
      if i=9 {var tAtk; tAtk=instance_create(768+lengthdir_x(40,15*i),112+lengthdir_y(40,15*i),oExe_FireBlue)}
      else {var tAtk; tAtk=instance_create(768+lengthdir_x(40,15*i),112+lengthdir_y(40,15*i),oExe_FireGreen)}
      tAtk.type=3; tAtk.bulSpd=1; tAtk.newSpd=6; tAtk.spdTime=40; tAtk.direction=(15*i)+180
    }
  }
  else if atkTime[2]=280 //Right
  {
    for(i=0;i<24;i+=1)
    {
      if i=3 {var tAtk; tAtk=instance_create(960+lengthdir_x(40,15*i),112+lengthdir_y(40,15*i),oExe_FireBlue)}
      else {var tAtk; tAtk=instance_create(960+lengthdir_x(40,15*i),112+lengthdir_y(40,15*i),oExe_FireGreen)}
      tAtk.type=3; tAtk.bulSpd=1; tAtk.newSpd=6; tAtk.spdTime=40; tAtk.direction=(15*i)+180
    }
  }
  else if atkTime[2]=420 //Mid
  {
    for(i=0;i<48;i+=1)
    {
      var tAtk;
      if i mod 2=0 {tAtk=instance_create(xCenter+lengthdir_x(56,7.5*i),80+lengthdir_y(56,7.5*i),oExe_FireGreen)}
      else {tAtk=instance_create(xCenter+lengthdir_x(56,7.5*i),80+lengthdir_y(56,7.5*i),oExe_FireBlue)}
      tAtk.type=3; tAtk.bulSpd=1; tAtk.newSpd=7; tAtk.spdTime=56; tAtk.direction=(7.5*i)+180
    }
  }
  else if atkTime[2]=480 {atkTime[2]=0}
}
else if moveProg>=10
{
  if oGame.time mod 3=0 //Improved Game Power recovery
  {
    global.hudGame_WeaponEn[0]+=1
    if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
  }

  if atkTime[0]>=35 and atkTime[0] mod 20=0 //Continuous bullets on bottom
  {
    var tAtk; tAtk=instance_create(608,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0
    var tAtk; tAtk=instance_create(1120,288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
  }

  if phase4_bulletLines=1
  {
    if atkTime[3] mod 112=0
    {
      if exVal[2]=0
      {
        for(i=0;i<7;i+=1) {var tAtk; tAtk=instance_create(608,48+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=0}
      }
      else
      {
        for(i=0;i<7;i+=1) {var tAtk; tAtk=instance_create(608,224-(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=0}
      }
      exVal[2]=!exVal[2]
    }
  }
}
#define Other_15
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 5
if moveProg=0 //Move to top-center
{
  moveTime+=1
  if moveTime>=10
  {
    direction=point_direction(x,y,xCenter,96)
    speed=4
    if point_distance(x,y,xCenter,96)<=4
    {
      x=xCenter; y=96
      speed=0
      for(i=0;i<5;i+=1) {atkTime[i]=0}
      moveTime=0; moveProg+=1
    }
  }
}

if moveProg>=1 //Normal sequence
{
  life-=8

  if atkTime[0] mod 10=0 and phase5_continuousCycle=1
  {
    var tAtk; tAtk=instance_create(1120,212,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
  }

  if atkProg=0
  {
    if atkTime[1]=10 {for(i=0;i<7;i+=1) {var tAtk; tAtk=instance_create(1120,180+(i*20),oExe_FireOther); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    else if atkTime[1]=40 {for(i=0;i<7;i+=1) {var tAtk; tAtk=instance_create(1120,180+(i*20),oExe_FireOther); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    else if atkTime[1]=50 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=75 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=100 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=125 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=160
    {
      var tAtk; tAtk=instance_create(1104,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    }
    else if atkTime[1]=200
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    }
    else if atkTime[1]=210 //Green vertical line
    {
      for(i=0;i<5;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=1.5; tAtk.direction=180}
    }
    else if atkTime[1]=220 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(608,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}
    else if atkTime[1]=240 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(608,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}
    else if atkTime[1]=270 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(608,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=0}}
    else if atkTime[1]=280 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=305 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}}
    else if atkTime[1]=320 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}}
    else if atkTime[1]=340 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}}

    if atkTime[1]=210 //Force player to the left-
    {
      for(i=0;i<19;i+=1) {var tAtk; tAtk=instance_create(752+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=270}
    }
    else if atkTime[1]=340 //-then to the right
    {
      for(i=0;i<19;i+=1) {var tAtk; tAtk=instance_create(688+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=270}
    }
    //Down on left
    if atkTime[1]=300 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(688,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270}}
    else if atkTime[1]=330 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(736,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270}}
    else if atkTime[1]=360 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(704,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=270}}

    if atkTime[1]=330 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}}
    else if atkTime[1]=365 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}}
    else if atkTime[1]=390 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}} //Last
    else if atkTime[1]=413 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}} //Last
    else if atkTime[1]=436 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}} //Last
    //Horizontal streams from left
    if atkTime[1]=535 {for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(608-(i*16),288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}
    else if atkTime[1]=613 {for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(608-(i*16),288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}
    else if atkTime[1]=702 {for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(608-(i*16),288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}
    else if atkTime[1]=780 {for(i=0;i<12;i+=1) {var tAtk; tAtk=instance_create(608-(i*16),288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0}}

    if atkTime[1]=700
    {
      var tAtk; tAtk=instance_create(1120,288,oExe_FireOther); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}
    }

    if atkTime[1]=840 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=870 {var tAtk; tAtk=instance_create(1120,240,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
    else if atkTime[1]=900
    {
      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
      }
    }
    else if atkTime[1]=920 {var tAtk; tAtk=instance_create(1120,184,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180} //Over line
    else if atkTime[1]=960 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,272+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}}
    else if atkTime[1]=985
    {
      var tAtk; tAtk=instance_create(1120,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180
      for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
    }
    else if atkTime[1]=1005
    {
      var tAtk; tAtk=instance_create(1120,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180
      for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
    }
    else if atkTime[1]=1025
    {
      var tAtk; tAtk=instance_create(1120,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180
      for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
    }
    else if atkTime[1]=1120 //Fast parry walls
    {
      var tAtk; tAtk=instance_create(1104,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1145
    {
      var tAtk; tAtk=instance_create(624,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0}}
    }
    else if atkTime[1]=1170
    {
      var tAtk; tAtk=instance_create(624,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0}}
    }
    else if atkTime[1]=1195
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1215
    {
      var tAtk; tAtk=instance_create(624,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0}}
    }
    else if atkTime[1]=1235
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1250
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1265
    {
      var tAtk; tAtk=instance_create(624,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0}}
    }
    else if atkTime[1]=1278
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1292
    {
      var tAtk; tAtk=instance_create(1104,256,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=180}}
    }
    else if atkTime[1]=1307
    {
      var tAtk; tAtk=instance_create(624,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=0}}
    }
    else if atkTime[1]=1320
    {
      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
      }
    }
    else if atkTime[1]=1325 {var tAtk; tAtk=instance_create(1120,184,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180} //Over line
    else if atkTime[1]=1350
    {
      var tAtk; tAtk=instance_create(1120,288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1136,272,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1152,256,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1168,272,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1184,288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180

      var tAtk; tAtk=instance_create(1208,224,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1224,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1240,256,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1256,240,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1272,224,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180

      var tAtk; tAtk=instance_create(1296,288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1312,272,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1328,256,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1344,272,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
      var tAtk; tAtk=instance_create(1360,288,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
    }
    else if atkTime[1]=1380 {var tAtk; tAtk=instance_create(1120,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=180}
    else if atkTime[1]=1420
    {
      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=0}
      }
    }
    else if atkTime[1]=1460
    {
      var tAtk; tAtk=instance_create(1104,288,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180
      for(i=0;i<5;i+=1) {for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(1120+(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=180}}
    }
    else if atkTime[1]=1480
    {
      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<2;ii+=1) {var tAtk; tAtk=instance_create(608-(ii*16),240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=1; tAtk.direction=0}
      }
    }
    else if atkTime[1]=1750 //Line of bullets that stop (and move later)
    {
      for(i=0;i<5;i+=1)
      {
        for(ii=0;ii<2;ii+=1)
        {
          var tAtk; tAtk=instance_create(784+(ii*16),356+(i*16),oExe_FireRed) tAtk.type=4; tAtk.bulSpd=2; tAtk.newSpdA=0; tAtk.spdTimeA=60; tAtk.newSpdB=8; tAtk.spdTimeB=226; tAtk.direction=90
          var tAtk; tAtk=instance_create(944-(ii*16),356+(i*16),oExe_FireRed) tAtk.type=4; tAtk.bulSpd=2; tAtk.newSpdA=0; tAtk.spdTimeA=60; tAtk.newSpdB=8; tAtk.spdTimeB=226; tAtk.direction=90
        }
      }
      for(i=0;i<6;i+=1)
      {
        var tAtk; tAtk=instance_create(688+(i*16),356,oExe_FireRed) tAtk.type=4; tAtk.bulSpd=2; tAtk.newSpdA=0; tAtk.spdTimeA=36; tAtk.newSpdB=8; tAtk.spdTimeB=250; tAtk.direction=90
        var tAtk; tAtk=instance_create(1040-(i*16),356,oExe_FireRed) tAtk.type=4; tAtk.bulSpd=2; tAtk.newSpdA=0; tAtk.spdTimeA=36; tAtk.newSpdB=8; tAtk.spdTimeB=250; tAtk.direction=90
      }
    }
    else if atkTime[1]=1770 {var tAtk; tAtk=instance_create(1120,300,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=180}
    else if atkTime[1]=1840 {var tAtk; tAtk=instance_create(624,300,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=4; tAtk.direction=0}

    if atkTime[1]=1700 //Spiral bullet set
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=22.5*i
      }
    }
    else if atkTime[1]=1720
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=22.5*i
      }
    }
    else if atkTime[1]=1740
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=7+(22.5*i)
      }
    }
    else if atkTime[1]=1760
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=7+(22.5*i)
      }
    }
    else if atkTime[1]=1780
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=14+(22.5*i)
      }
    }
    else if atkTime[1]=1800
    {
      for(i=0;i<16;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=14+(22.5*i)
      }
    }
    else if atkTime[1]=1820
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=15*i
      }
    }
    else if atkTime[1]=1840
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=15*i
      }
    }
    else if atkTime[1]=1860
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=6+(15*i)
      }
    }
    else if atkTime[1]=1880
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=6+(15*i)
      }
    }
    else if atkTime[1]=1900
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=12+(15*i)
      }
    }
    else if atkTime[1]=1920
    {
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=12+(15*i)
      }
    }

    //Final segment
    if atkTime[1]=2100
    {
      for(i=0;i<10;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=36*i
      }
    }
    else if atkTime[1]=2170
    {
      for(i=0;i<10;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=36*i
      }
    }
    else if atkTime[1]=2240
    {
      for(i=0;i<10;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=36*i
      }
    }
    else if atkTime[1]=2310
    {
      for(i=0;i<10;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=4; tAtk.curveTime=40; tAtk.direction=36*i
      }
    }
    else if atkTime[1]=2380
    {
      for(i=0;i<10;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=1; tAtk.bulSpd=3; tAtk.curveAmt=-4; tAtk.curveTime=40; tAtk.direction=36*i
      }
    }

    //From top
    if atkTime[1]=2080 {for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(680+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}}
    else if atkTime[1]=2140 {for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(936+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}}
    else if atkTime[1]=2200 {for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(808+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}}
    else if atkTime[1]=2260
    {
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(680+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(936+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }
    else if atkTime[1]=2310
    {
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(808+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(936+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }
    else if atkTime[1]=2360
    {
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(680+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(808+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }
    else if atkTime[1]=2410
    {
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(680+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      for(i=0;i<8;i+=1) {var tAtk; tAtk=instance_create(936+(i*16),-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }

    //From sides
    if atkTime[1]=2090 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2110 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2130 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2150 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2170 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2190 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2210 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2230 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2250 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2270 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2290 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2310 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2330 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2350 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2370 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2390 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2410 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2430 {for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,288+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2450 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
    else if atkTime[1]=2470 {for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(1120,240+(i*16),oExe_FireRed); tAtk.type=0; tAtk.bulSpd=5; tAtk.direction=180}}
  }
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHASE 6

if moveProg=0 //Move to bottom-right
{
  moveTime+=1
  if moveTime=1 {bCanDealDamage=0}
  if moveTime>=10
  {
    direction=point_direction(x,y,976,256)
    speed=8
    if point_distance(x,y,976,256)<=8
    {
      x=976; y=256
      speed=0
      bCanTakeDamage=1; bCanDealDamage=1
      for(i=0;i<5;i+=1) {atkTime[i]=-1}
      for(i=0;i<6;i+=1) {resType[i]=1}
      moveTime=0; moveProg+=1
    }
  }
}
else if moveProg>=1
{
  if phase6_phase=1 //========== PHASE 1 (Circle 1) ==========
  {
    if atkTime[0] mod 60=0
    {
      for(i=0;i<4;i+=1) {var tAtk; tAtk=instance_create(688+(i*72),-2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }

    if phase6_bulletCheckA=0 //Spawn bullets
    {
      for(i=0;i<12;i+=1)
      {
        var tAtk;
        if i=0 {tAtk=instance_create(x,y,oExe_FireBlue)}
        else if i=1 or i=11 {tAtk=instance_create(x,y,oExe_FireGreen)}
        else {tAtk=instance_create(x,y,oExe_FireRed)}
        tAtk.type=5; tAtk.rotSpd=2.5; tAtk.curDir=30*i; tAtk.distMax=96

        var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=-2; tAtk.curDir=30*i; tAtk.distMax=156
      }
      phase6_normalRes=1; resType[0]=phase6_normalRes
      phase6_bulletCheckA=1
    }
    else if phase6_bulletCheckA=1 //Check if all blue bullets gone
    {
      if !instance_exists(oExe_FireBlue)
      {
        phase6_normalRes=2; resType[0]=phase6_normalRes
        phase6_bulletCheckA=2
      }
    }
    else if phase6_bulletCheckA=2 //Fire slash
    {
      exVal[0]+=1
      if exVal[0]=30
      {
        var tNewAtk,tChkDir;
        if x>oPlayer1.x {tChkDir=-1}
        else {tChkDir=1}
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
      }
      else if exVal[0]=105
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if exVal[0]=110
      {
        exVal[0]=0
        phase6_bulletCheckA=0
        if bossProgress>=1 {phase6_bulletCheckA=3}
      }
    }
    else if phase6_bulletCheckA=3 //Move and go to next phase
    {
      exVal[0]+=1
      if exVal[0]>=1 and exVal[0]<=8 {x-=1; y-=1}
      else if exVal[0]>=10
      {
        exVal[0]=0
        phase6_bulletCheckA=0
        phase6_phase+=1
      }
    }
  }
  else if phase6_phase=2 //========== PHASE 2 (Circle 2) ==========
  {
    if atkTime[0] mod 6=0
    {
      var tAtk; tAtk=instance_create(840,-2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270
    }

    if phase6_bulletCheckA=0 //Spawn bullets
    {
      for(i=0;i<12;i+=1)
      {
        var tAtk;
        if i=0 {tAtk=instance_create(x,y,oExe_FireBlue)}
        else if i=1 or i=11 {tAtk=instance_create(x,y,oExe_FireGreen)}
        else {tAtk=instance_create(x,y,oExe_FireRed)}
        tAtk.type=5; tAtk.rotSpd=-2.5; tAtk.curDir=30*i; tAtk.distMax=88

        if i=3 or i=9 {tAtk=instance_create(x,y,oExe_FireBlue)}
        else if i=2 or i=4 or i=8 or i=10 {tAtk=instance_create(x,y,oExe_FireGreen)}
        else {tAtk=instance_create(x,y,oExe_FireRed)}
        tAtk.type=5; tAtk.rotSpd=2.5; tAtk.curDir=30*i; tAtk.distMax=156
      }
      phase6_normalRes=1; resType[0]=phase6_normalRes
      phase6_bulletCheckA=1
    }
    else if phase6_bulletCheckA=1 //Check if all blue bullets gone
    {
      if !instance_exists(oExe_FireBlue)
      {
        phase6_normalRes=2; resType[0]=phase6_normalRes
        phase6_bulletCheckA=2
      }
    }
    else if phase6_bulletCheckA=2 //Fire slash
    {
      exVal[0]+=1
      if exVal[0]=30
      {
        var tNewAtk,tChkDir;
        if x>oPlayer1.x {tChkDir=-1}
        else {tChkDir=1}
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
      }
      else if exVal[0]=105
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if exVal[0]=110
      {
        exVal[0]=0
        phase6_bulletCheckA=0
        if bossProgress>=2 {phase6_bulletCheckA=3}
      }
    }
    else if phase6_bulletCheckA=3 //Move and go to next phase
    {
      exVal[0]+=1
      if exVal[0]>=1 and exVal[0]<=8 {x-=1; y-=1}
      else if exVal[0]>=10
      {
        exVal[0]=0
        phase6_bulletCheckA=0
        phase6_phase+=1
      }
    }
  }
  else if phase6_phase=3 //========== PHASE 3 (Circle 3) ==========
  {
    if atkTime[0] mod 100=0
    {
      var tAtk; tAtk=instance_create(1120,yGround-12,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180
    }
    if atkTime[1] mod 130=0
    {
      for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(700+(i*70),-2,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
    }

    if phase6_bulletCheckA=0 //Spawn bullets
    {
      for(i=0;i<12;i+=1)
      {
        var tAtk;
        if i=6 {tAtk=instance_create(x,y,oExe_FireBlue)}
        else if i=5 or i=7 {tAtk=instance_create(x,y,oExe_FireGreen)}
        else {tAtk=instance_create(x,y,oExe_FireRed)}
        tAtk.type=5; tAtk.rotSpd=2.5; tAtk.curDir=30*i; tAtk.distMax=96

        if i=0 {tAtk=instance_create(x,y,oExe_FireBlue)}
        else if i=1 or i=11 {tAtk=instance_create(x,y,oExe_FireGreen)}
        else {tAtk=instance_create(x,y,oExe_FireRed)}
        tAtk.type=5; tAtk.rotSpd=-2.5; tAtk.curDir=30*i; tAtk.distMax=156
      }
      for(i=0;i<24;i+=1)
      {
        var tAtk; tAtk=instance_create(x,y,oExe_FireGreen); tAtk.type=5; tAtk.rotSpd=3; tAtk.curDir=15*i; tAtk.distMax=216
      }

      phase6_normalRes=1; resType[0]=phase6_normalRes
      phase6_bulletCheckA=1
    }
    else if phase6_bulletCheckA=1 //Check if all blue bullets gone
    {
      if !instance_exists(oExe_FireBlue)
      {
        phase6_normalRes=2; resType[0]=phase6_normalRes
        phase6_bulletCheckA=2
      }
    }
    else if phase6_bulletCheckA=2 //Fire slash
    {
      exVal[0]+=1
      if exVal[0]=30
      {
        var tNewAtk,tChkDir;
        if x>oPlayer1.x {tChkDir=-1}
        else {tChkDir=1}
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
      }
      else if exVal[0]=105
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if exVal[0]=110
      {
        exVal[0]=0
        phase6_bulletCheckA=0
        if bossProgress>=3 {phase6_bulletCheckA=3}
      }
    }
    else if phase6_bulletCheckA=3 //Move up
    {
      exVal[0]+=1
      if exVal[0]>=1 and exVal[0]<=99
      {
        y-=4
        if y<=128
        {
          oPlayer1.x=xCenter; oPlayer1.y=yGround
          var tFFScl,tEffect;
          for(i=0;i<64;i+=1)
          {
            tFFScl=random(0.1)
            tEffect=instance_create(oPlayer1,oPlayer1-26,oEffectB)
            tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
            tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
            tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
            tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),255,random(50))
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
          y=128
          tile_layer_show(999999)
          leftPlatA=instance_create(736,280,oInvisibleSolid); leftPlatA.image_xscale=6; leftPlatA.image_yscale=2
          leftPlatB=instance_create(752,248,oInvisibleSolid); leftPlatB.image_xscale=4; leftPlatB.image_yscale=2
          rightPlatA=instance_create(896,280,oInvisibleSolid); rightPlatA.image_xscale=6; rightPlatA.image_yscale=2
          rightPlatB=instance_create(912,248,oInvisibleSolid); rightPlatB.image_xscale=4; rightPlatB.image_yscale=2
          exVal[0]=0
          phase6_bulletCheckA=0
          phase6_phase+=1
        }
      }
    }
  }
  else if phase6_phase=4 //========== PHASE 4 (Rotating bullet lines with blue) ==========
  {
    if phase6_canMove=1 //Move left
    {
      if moveProg=1
      {
        x-=1.5
        if x<=xCenter-roomSpan+64 {moveProg=2}
      }
      else if moveProg=2 //Move right
      {
        x+=1.5
        if x>=xCenter+roomSpan-64 {moveProg=1}
      }
      else if moveProg=3 //Move down
      {
        y+=4
        moveTime+=1
        if moveTime>=10 {moveTime=0; moveProg=4}
      }
      else if moveProg=5 //Move up
      {
        y-=4
        moveTime+=1
        if moveTime>=10 {moveTime=0; moveProg=1}
      }
    }

    //Extra bullets
    if bossProgress=3
    {
      if atkTime[0] mod 100=0
      {
        for(i=0;i<2;i+=1) {var tAtk; tAtk=instance_create(1120,224+(i*60),oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180}
      }
    }
    else if bossProgress=4
    {
      if atkTime[0] mod 100=0
      {
        for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(736+(i*128),-2,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      }
    }

    if phase6_bulletCheckA=0 //Spawn bullet lines
    {
      if bossProgress=3 //---------- First ----------
      {
        for(i=0;i<20;i+=1)
        {
          for(ii=0;ii<2;ii+=1)
          {
            var tAtk;
            if i>=6 and i<=10 {tAtk=instance_create(x,y,oExe_FireBlue)}
            else if i=5 or i=11 {tAtk=instance_create(x,y,oExe_FireGreen)}
            else {tAtk=instance_create(x,y,oExe_FireRed)}
            tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*180; tAtk.distMax=80+(i*12)
          }
        }
      }
      else if bossProgress=4 //---------- Second ----------
      {
        for(i=0;i<20;i+=1)
        {
          for(ii=0;ii<4;ii+=1)
          {
            var tAtk;
            if i>=6 and i<=10 {tAtk=instance_create(x,y,oExe_FireBlue)}
            else if i=5 or i=11 {tAtk=instance_create(x,y,oExe_FireGreen)}
            else {tAtk=instance_create(x,y,oExe_FireRed)}
            tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=80+(i*12)
          }
        }
      }
      //------------------------------
      phase6_normalRes=1; resType[0]=phase6_normalRes
      phase6_bulletCheckA=1
    }
    else if phase6_bulletCheckA=1 //Check if all blue bullets gone
    {
      if !instance_exists(oExe_FireBlue)
      {
        moveProg=3
        phase6_normalRes=2; resType[0]=phase6_normalRes
        phase6_bulletCheckA=2
      }
    }
    else if phase6_bulletCheckA=2 //Fire slash
    {
      exVal[0]+=1
      if exVal[0]=30
      {
        var tNewAtk,tChkDir;
        if x>oPlayer1.x {tChkDir=-1}
        else {tChkDir=1}
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
        tNewAtk=instance_create(x,y,oExe_FireSlash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
      }
      else if exVal[0]=105
      {
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if exVal[0]=110
      {
        moveProg=5
        exVal[0]=0
        phase6_bulletCheckA=0
        if bossProgress>=5
        {
          moveProg=1; moveTime=0
          resType[0]=1
          phase6_phase=5
        }
      }
    }
  }
  else if phase6_phase=5 //========== PHASE 5 (Rotating bullet lines, gaps only) ==========
  {
    moveTime+=1
    if moveProg=1
    {
      if moveTime>=30
      {
        direction=point_direction(x,y,xCenter,144)
        speed=8
        if point_distance(x,y,xCenter,144)<=8
        {
          phase6_normalRes=2; resType[0]=phase6_normalRes
          x=xCenter; y=144
          speed=0
          for(i=0;i<5;i+=1) {atkTime[i]=-1}
          moveTime=0; moveProg+=1
        }
      }
    }

    if bossProgress=5
    {
      if atkTime[0] mod 100=0
      {
        for(i=0;i<3;i+=1) {var tAtk; tAtk=instance_create(736+(i*128),-2,oExe_FireGreen); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270}
      }
    }

    exVal[0]+=1
    if exVal[0]=15
    {
      phase6_normalRes=2; resType[0]=phase6_normalRes
      exVal[1]=1
    }

    if phase6_bulletCheckA=0 and exVal[1]=1 //Spawn bullet lines
    {
      for(i=6;i<24;i+=1)
      {
        for(ii=0;ii<2;ii+=1)
        {
          tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=i*15; tAtk.distMax=40+(ii*12)
        }
      }
      for(i=0;i<24;i+=1)
      {
        for(ii=0;ii<4;ii+=1)
        {
          var tAtk;
          if ii=0
          {
            if i>=5 {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=1
          {
            if (i>=0 and i<=7) or (i>=13) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=2
          {
            if (i>=0 and i<=5) or (i>=11) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=3
          {
            if (i>=0 and i<=3) or (i>=9) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }

          /*if ii=0
          {
            if i>=5 {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=1
          {
            if (i>=0 and i<=4) or (i>=10) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=2
          {
            if (i>=0 and i<=7) or (i>=12) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }
          else if ii=3
          {
            if (i>=0 and i<=10) or (i>=16) {tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=5; tAtk.rotSpd=1.5; tAtk.curDir=ii*90; tAtk.distMax=40+(i*12)}
          }*/
        }
      }
      phase6_bulletCheckA=1
    }
  }
  else if phase6_phase=6 //========== PHASE 6 (PLATFORM PHASE) ==========
  {
    if moveProg=1 //Move to top-right
    {
      moveTime+=1
      if moveTime=1 {bCanDealDamage=0}
      if moveTime>=10
      {
        direction=point_direction(x,y,1024,64)
        speed=8
        if point_distance(x,y,1024,64)<=8
        {
          x=1024; y=64
          speed=0
          bCanDealDamage=1
          for(i=0;i<5;i+=1) {atkTime[i]=-1}
          phase6_normalRes=5; resType[0]=phase6_normalRes
          moveTime=0; moveProg+=1
        }
      }
    }
    else if moveProg=2
    {
      //Bullet stream diagonal
      if atkTime[0] mod 6=0 and atkTime[0]<=42
      {
        var tAtk; tAtk=instance_create(736,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270
        var tAtk; tAtk=instance_create(832,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270
        var tAtk; tAtk=instance_create(960,-4,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=270

        var tAtk; tAtk=instance_create(858,118,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=170
      }
      if atkTime[0]>=72 {atkTime[0]=0}
      //Bullet stream horizontal
      if atkTime[1] mod 9=0
      {
        var tAtk; tAtk=instance_create(1104,264,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=170
        var tAtk; tAtk=instance_create(858,118,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=2; tAtk.direction=350
      }

      if atkTime[3]>=120 //Platforms
      {
        if atkTime[2]>=90 //Bottom blue bullet
        {
          var tAtk; tAtk=instance_create(1104,240,oExe_FireBlue); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=200
          atkTime[2]=0
        }

        //Bottom right platform
        if phase6_platA=0
        {
          if oPlayer1.x>xCenter and oPlayer1.y>176
          {
            nspPlatA=instance_create(1024,224,oExe_TempPlat)
            phase6_platA=1
          }
        }
        else if phase6_platA=1
        {
          if oPlayer1.x<xCenter or oPlayer1.y<176
          {
            if instance_exists(nspPlatA) {with nspPlatA {instance_destroy()}}
            phase6_platA=0
          }
        }
        //Bottom mid platform
        if phase6_platB=0
        {
          if oPlayer1.x>832 and oPlayer1.y<232
          {
            nspPlatB=instance_create(880,192,oExe_TempPlat)
            phase6_platB=1
          }
        }
        else if phase6_platB=1
        {
          if oPlayer1.x<832 or oPlayer1.y>232
          {
            if instance_exists(nspPlatB) {with nspPlatB {instance_destroy()}}
            phase6_platB=0
          }
        }
        //Bottom left platform
        if phase6_platC=0
        {
          if oPlayer1.x<912 and oPlayer1.y<208
          {
            nspPlatC=instance_create(760,172,oExe_TempPlat)
            phase6_platC=1
          }
        }
        else if phase6_platC=1
        {
          if oPlayer1.x>912 or oPlayer1.y>208
          {
            if instance_exists(nspPlatC) {with nspPlatC {instance_destroy()}}
            phase6_platC=0
          }
        }
        //Top mid platform
        if phase6_platD=0
        {
          if oPlayer1.y<176
          {
            nspPlatD=instance_create(920,112,oExe_TempPlat)
            phase6_platD=1
          }
        }
        else if phase6_platD=1
        {
          if oPlayer1.y>176
          {
            if instance_exists(nspPlatD) {with nspPlatD {instance_destroy()}}
            phase6_platD=0
          }
        }
      }
    }
  }
  else if phase6_phase=7 //========== PHASE 7 (FINAL PHASE) ==========
  {
    pepsiLogo+=1

    if moveProg=1 //Move to center
    {
      moveTime+=1
      if moveTime=1 {bCanDealDamage=0}
      if moveTime>=10
      {
        direction=point_direction(x,y,xCenter,176)
        speed=8
        if point_distance(x,y,xCenter,176)<=8
        {
          x=xCenter; y=176
          speed=0
          bCanDealDamage=1
          for(i=0;i<5;i+=1) {atkTime[i]=-1}
          phase6_normalRes=5; resType[0]=phase6_normalRes
          moveTime=0; moveProg+=1
        }
      }
    }
    else if moveProg=2
    {
      if atkTime[0]=40 //Ring 1
      {
        for(i=0;i<64;i+=1)
        {
          if (i>=0 and i<=51) or (i>=60) {var tAtk; tAtk=instance_create(x,y,oExe_FireRed)}
          else {var tAtk; tAtk=instance_create(x,y,oExe_FireBlue)}
          tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=5.625*i
        }
      }
      else if atkTime[0]=80 //Ring 2
      {
        for(i=0;i<64;i+=1)
        {
          if (i>=0 and i<=37) or (i>=46) {var tAtk; tAtk=instance_create(x,y,oExe_FireRed)}
          else {var tAtk; tAtk=instance_create(x,y,oExe_FireBlue)}
          tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=5.625*i
        }
      }
      else if atkTime[0]=120 //Ring 3
      {
        for(i=0;i<64;i+=1)
        {
          if (i>=0 and i<=44) or (i>=53) {var tAtk; tAtk=instance_create(x,y,oExe_FireRed)}
          else {var tAtk; tAtk=instance_create(x,y,oExe_FireBlue)}
          tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=5.625*i
        }
      }
      else if atkTime[0]>=130 //Scatter upward
      {
        for(i=0;i<8;i+=1)
        {
          var tAtk; tAtk=instance_create(x,y,oExe_FireRed); tAtk.type=0; tAtk.bulSpd=6; tAtk.direction=irandom_range(30,150)
        }
        if atkTime[0]>=160 {atkTime[0]=0}
      }
    }
  }
}
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///DROP HEARTS
heartGrab=60
var tChkSide;
if x<xCenter {tChkSide=10}
else {tChkSide=-10}
for(i=0;i<4;i+=1) {instance_create(x+tChkSide-12+(8*i),y,oHealthPickup)}

global.hudGame_WeaponEn[0]+=100
if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkPhase=6
{
  if phase6_normalRes=1
  {
    draw_set_color(newColorFinal)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_blue,image_alpha)
  }
  else
  {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

if pepsiLogo>=16 and pepsiLogo<=17
{
  draw_sprite_ext(sPepsiLogo,0,xCenter,yGround-128,1,1,0,c_white,1)
}
