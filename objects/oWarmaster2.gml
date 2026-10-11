#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
CHAOS Warmaster II: an imagined sequel fight (Bubble Tower B, rBT_Warmaster2). He has three new models:
  Saber (green): a three-cut combo, a charged giant crescent, spike lines, a buster feint, an aerial thrust
  Phantom (purple): vanishing slashes, shuriken, shadow echoes, a dark sphere
  X (blue): buster shots, charge shots, wall kicks, Nova Strike
Phase 1 is Saber, phase 2 (from 72% life) Phantom, phase 3 (from 47%) X, phase 4 (from 22%) Overdrive, where he
swaps models after every attack; at 8% he makes one last stand (Triple Overdrive) and then collapses. Each model has a
super attack once his charge pips fill. Every attack is telegraphed.

Everything is timed in 30fps ticks: an attack runs as states (st), each with its own timer (stT, see scrWM2_St and
scrWM2_At), and everything that moves goes by its speed times gDeltaTime.

USER DEFINED EVENTS
0: End of an attack
1: Phantom attacks
2: X attacks
3: Model change, Overdrive, Triple Overdrive, Overdrive's model swap
4: Form setup (resistances, HUD gem, scan text, arena lights)
5: Choose the next attack
6: Attack setup (its timings for the current difficulty)
7: Saber attacks
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-44,14,-1)
image_xscale=-1.25
image_yscale=1.25
image_speed=0
scaleForFacing=-1

//Enemy base statistics
eName="CHAOS Warmaster II"
eLevel=45
maxLife=17600
life=maxLife
atkPower=12
stunResist=200
affiliation=7
bIsBoss=true
bNoBonus=true
dieEffect=0
bCanDealDamage=false
bCanTakeDamage=false
bossProgress=0
activateBoss=0

//-- Forms and phases --
FORM=3           //1: Phantom, 2: X, 3: Saber
PHASE=1          //1: Saber, 2: Phantom, 3: X, 4: Overdrive
ATTACK_FORM=5    //the HUD's gem (oBossLifeDisplay type 2 draws sWM_Hud_FormIcon frame ATTACK_FORM-1): 5 Saber, 6 Phantom, 7 X, 8 Overdrive
DIFFICULTY=1
superCharge=0    //the HUD's charge pips: one per attack; when full, his model's super attack
superMax=5
desperationDone=0
nextForm=1       //the model a model change goes to
colP=make_color_rgb(190,80,255)
colX=make_color_rgb(70,170,255)
colZ=make_color_rgb(60,230,140)

//-- Attack Data --
currentAttack=0
previousAtk=0
nextAttack=0
st=0; stT=0; stPrev=0
waitTime=0
waitDelay=34
rep=0; repMax=1
shotN=0
fired=0
rushNo=0
echoTick=0
kicks=0; kickMax=2
novaN=0; novaMax=1
hops=0; hopMax=1
throwN=1
wallSide=1
tx=0; ty=0; tdir=0
jx=0; jy=0
clA=noone; clB=noone; clC=noone
//timings, set per attack by event_user(6)
teleT=12; windT=4; cresSpd=6.5
starSpd=6
readyT=9; rushSpd=13
crouchT=6; diveTeleT=6; diveSpd=11; cresSpd2=5.5
orbSpd=1.8; orbLife=100; orbN=8; orbBurst=3.5
crossTeleT=16; cloneSpd=12; cloneTeleT=10; cloneDive=13; colTrack=14; lockHold=6
runSpd=4.5; runGap=6; runShots=5; lemonSpd=8.5
chargeT1=20; semiSpd=8; chargeT2=14; fullSpd=10
clingT=6; ricSpd=5; ricBounce=1
novaAim=14; novaLock=6; novaSpd=15
hopT=6; stingSpread=25; stingDelay=6; stingSpd=7
gigaGap=28; gigaWarn=12; gigaSpd=11; gigaRest=24
triadT=6; hitGap=9; stepSpd=5
zChargeT=24
stabT=7; spikeGap=30; spikeStep=3
zShots=1; zDashSpd=12
airT=10; airSpd=13
novaZT=24
lastShotT=0

//-- Arena --
xCenter=240
xMin=50; xMax=430   //his x stays inside these
yGround=304
yCeil=96            //his feet can't go above this

//-- Movement --
bGravity=1
grav=0.6
onGround=1
landed=0            //1 for one frame when he lands
wallHit=0           //-1/1 while he's against the left/right wall

//-- Looks --
hidden=0            //vanished: not drawn, can't hurt or be hurt
aura=0              //0: none, 1: purple, 2: blue, 3: all three in turn, 4: green
auraT=0
deathAnim=0

event_user(4)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var dPrev,tF,i,tempMplay;
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=2
    bCanDealDamage=true; bCanTakeDamage=true
    activateBoss=2
    waitTime=waitDelay-16
    scrWM2_Anim(sWM2Z_Idle,0.2)
  }

  if bActive=true and life>0
  {
    //-------------------- Phase changes (only between attacks) --------------------
    if currentAttack=0
    {
      if PHASE=1 and lifePercent<=0.72 {nextForm=1; currentAttack=50; scrWM2_St(0)}
      else if PHASE=2 and lifePercent<=0.47 {nextForm=2; currentAttack=50; scrWM2_St(0)}
      else if PHASE=3 and lifePercent<=0.22 {currentAttack=51; scrWM2_St(0)}
      else if PHASE=4 and lifePercent<=0.08 and desperationDone=0 {currentAttack=52; scrWM2_St(0)}
    }

    //-------------------- Between attacks --------------------
    if currentAttack=0
    {
      xVel=0
      if onGround=1
      {
        scrWM2_Face()
        if FORM=1 {scrWM2_Anim(sWM2P_Idle,0.2)}
        else if FORM=2 {scrWM2_Anim(sWM2X_Idle,0.15)}
        else {scrWM2_Anim(sWM2Z_Idle,0.2)}
      }
      waitTime+=1*gDeltaTime
      if waitTime>=waitDelay and onGround=1 {event_user(5)}
    }

    //-------------------- Attacking --------------------
    if currentAttack!=0
    {
      stPrev=stT
      stT+=1*gDeltaTime
      if currentAttack>=50 {event_user(3)}
      else if FORM=1 {event_user(1)}
      else if FORM=2 {event_user(2)}
      else {event_user(7)}
    }

    //-------------------- Movement --------------------
    landed=0; wallHit=0
    if bGravity=1
    {
      yVel=scrGravAcc(yVel,grav,1)
      if yVel>12 {yVel=12}
    }
    x+=xVel*gDeltaTime
    y+=yVel*gDeltaTime
    if y>=yGround
    {
      if onGround=0 {landed=1}
      y=yGround
      if yVel>0 {yVel=0}
      onGround=1
    }
    else {onGround=0}
    if x<xMin {x=xMin; wallHit=-1}
    else if x>xMax {x=xMax; wallHit=1}
    if y<yCeil {y=yCeil; if yVel<0 {yVel=0}}
    //his slash boxes move with him
    with oWM2_HitBox {if owner=other.id {x=other.x+relX; y=other.y+relY}}
    auraT+=1*gDeltaTime

    //-------------------- Difficulty curve --------------------
    if PHASE=1
    {
      if lifePercent<=0.86 and bossProgress=0 {bossProgress=1; DIFFICULTY=2; waitDelay=26}
    }
    else if PHASE=2
    {
      if lifePercent<=0.58 and bossProgress<2 {bossProgress=2; DIFFICULTY=3; waitDelay=22}
    }
    else if PHASE=3
    {
      if lifePercent<=0.34 and bossProgress<3 {bossProgress=3; DIFFICULTY=3; waitDelay=20}
    }
  }
  enemyStepEvent()
}

if life<=0 //-------------------- Defeat --------------------
{
  dPrev=deathAnim
  deathAnim+=1*gDeltaTime
  if dPrev=0
  {
    global.gamePaused=true
    stopPlayer()
    bCanDealDamage=0; bCanTakeDamage=0; hidden=0; aura=0; image_angle=0; image_blend=c_white
    xVel=0; yVel=0
    with oEProjectileBase {instance_destroy()}
    with oWM2_Tele {instance_destroy()}
    if FORM=1 {scrWM2_Pose(sWM2P_Hurt,1)}
    else if FORM=2 {scrWM2_Pose(sWM2X_Hurt,1)}
    else {scrWM2_Pose(sWM2Z_Hurt,1)}
    tempMplay=findMusic(0)
    playSound(global.snd_HardHit1,0,1,1)
    playSound(global.snd_EnemyDieMM,0,1,1)
    scrWM2_Shake(5)
    if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=1; oBTB_Ev_Warmaster2.lightMode=0}
  }
  if y<yGround {y=min(yGround,y+5*gDeltaTime)}
  //explosions all over him
  if deathAnim<64 and floor(deathAnim/4)!=floor(dPrev/4)
  {
    tF=scrWM2_Fx(x+random_range(-24,24),y-random(54),sMMExplosion,0.5,c_white,0)
    tF.depth=depth-1
    if floor(deathAnim/4) mod 2=0 {playSound(global.snd_BombExplode,0,0.85,1)}
    else {playSound(global.snd_EnemyDieMM,0,0.85,1)}
    scrWM2_Shake(3)
  }
  if dPrev<64 and deathAnim>=64
  {
    if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=1}
    playSound(global.snd_HardHit3,0,0.9,17000)
    for(i=0;i<9;i+=1)
    {
      tF=scrWM2_Fx(x,y-28,sWM2_Disc,0,colZ,1)
      if i mod 3=1 {tF.image_blend=colP}
      else if i mod 3=2 {tF.image_blend=colX}
      tF.image_xscale=0.4; tF.image_yscale=0.4; tF.fade=0.03; tF.life=999
      tF.vx=lengthdir_x(3,i*40); tF.vy=lengthdir_y(3,i*40)
    }
    if FORM=1 {scrWM2_Pose(sWM2P_Down,0)}
    else if FORM=2 {scrWM2_Pose(sWM2X_Defeat,0)}
    else {scrWM2_Pose(sWM2Z_Defeat,0)}
  }
  if FORM=2 and deathAnim>=64 {image_index=min(7,floor((deathAnim-64)/4))}
  if FORM=3 and deathAnim>=64 {image_index=min(9,floor((deathAnim-64)/4))}
  if dPrev<110 and deathAnim>=110
  {
    msgCreate(0,0,"Warmaster","...Heh. Still standing after all that. Fine. This round is yours.",6,2,oMessagePerson,0)
    newMessage.fadingTime=125
  }
  if dPrev<250 and deathAnim>=250
  {
    if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.sceneProgress=50}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tCol;
if hidden=1 {exit}
if aura>0
{
  tCol=colP
  if aura=2 {tCol=colX}
  else if aura=4 {tCol=colZ}
  else if aura=3
  {
    if (floor(auraT/5) mod 3)=0 {tCol=colZ}
    else if (floor(auraT/5) mod 3)=1 {tCol=colP}
    else {tCol=colX}
  }
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.1,image_yscale*1.05,image_angle,tCol,0.45+0.2*sin(auraT*0.5))
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.22,image_yscale*1.1,image_angle,tCol,0.2)
  draw_set_blend_mode(bm_normal)
}
else if PHASE=4 and life>0 //Overdrive: a faint flicker of all three colours
{
  if (floor(auraT/5) mod 3)=0 {tCol=colZ}
  else if (floor(auraT/5) mod 3)=1 {tCol=colP}
  else {tCol=colX}
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.08,image_yscale*1.04,image_angle,tCol,0.3)
  draw_set_blend_mode(bm_normal)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///END ATTACK
with oWM2_HitBox {if owner=other.id {instance_destroy()}}
image_angle=0; aura=0; hidden=0; bGravity=1
bCanDealDamage=1; bCanTakeDamage=1
if currentAttack<9 {superCharge=min(superMax,superCharge+1)}
previousAtk=currentAttack
currentAttack=0
st=0; stT=0; stPrev=0
waitTime=0
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///PHANTOM FORM
var tC,tS,tA,tAng,tN,tE,tO,tK,tT,tF,i;
if currentAttack=1 //==================== FLASH STEP CRESCENT ====================
{
  if st=0 //crouches and vanishes into smoke
  {
    if stPrev=0
    {
      scrWM2_Pose(sWM2P_DashStart,0)
      playSound(global.snd_KnightSwordSwing,0,0.9,40000)
    }
    if stT>=3
    {
      scrWM2_Smoke(x,y,colP)
      scrWM2_Ghost(0.7,0.1,colP,1)
      hidden=1; bCanDealDamage=0; bCanTakeDamage=0
      //he comes back on the far side of the player (the near side if there's no room)
      tdir=sign(oPlayer1.x-x)
      if tdir=0 {tdir=1}
      tx=oPlayer1.x+tdir*58
      if tx<xMin+6 or tx>xMax-6 {tx=oPlayer1.x-tdir*58}
      tx=median(xMin+6,tx,xMax-6)
      scrWM2_Tele(0,tx,0,14,0,teleT+2,colP)
      scrWM2_St(1)
    }
  }
  else if st=1 //gone; the warning shows where
  {
    if stT>=teleT
    {
      hidden=0; bCanDealDamage=1; bCanTakeDamage=1
      x=tx; y=yGround; yVel=0
      scrWM2_Face()
      scrWM2_Pose(sWM2P_Slash,0)
      scrWM2_Smoke(x,y,colP)
      playSound(global.snd_Teleport,0,0.85,1)
      scrWM2_St(2)
    }
  }
  else if st=2 //wind-up
  {
    if stT>=windT {scrWM2_St(3)}
  }
  else if st=3 //the slash, and a crescent along the floor
  {
    if stPrev=0
    {
      playSound(global.snd_DeathSlash,0,1,28500)
      scrWM2_Hit(2,-46,46,44,6,1)
      tC=instance_create(x+scaleForFacing*22,yGround-19,oWM2_Crescent)
      tC.dir=scaleForFacing; tC.spd=cresSpd; tC.atkPower=atkPower
      if rep=repMax-1 and DIFFICULTY>=3 //the last one also cuts behind him
      {
        tC=instance_create(x-scaleForFacing*22,yGround-19,oWM2_Crescent)
        tC.dir=-scaleForFacing; tC.spd=cresSpd; tC.atkPower=atkPower
      }
    }
    image_index=1+min(2,floor(stT/2))
    if stT>=6 {scrWM2_St(4)}
  }
  else if st=4 //recovers, or flash-steps again
  {
    image_index=4+min(2,floor(stT/3))
    if rep<repMax-1 and stT>=4 {rep+=1; scrWM2_St(0)}
    else if stT>=10 {event_user(0)}
  }
}
else if currentAttack=2 //==================== SHURIKEN FAN ====================
{
  if st=0 //crouches
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2P_DashEnd,1)
      playSound(global.snd_DashWarn,0,0.9,1)
    }
    if stT>=5
    {
      scrWM2_Anim(sWM2P_Jump,0.4)
      y-=2; yVel=-11.5; onGround=0
      xVel=sign(xCenter-x)*min(2.5,abs(xCenter-x)/20)
      scrWM2_St(1)
    }
  }
  else if st=1 //leaps up
  {
    if image_index>=5 {image_index=5; image_speed=0}
    if yVel>=-1 or stT>=18
    {
      bGravity=0; yVel=0; xVel=0
      scrWM2_Face()
      scrWM2_Pose(sWM2P_AirThrow,0)
      shotN=0
      scrWM2_St(2)
    }
  }
  else if st=2 //hangs in the air and throws fans of shuriken
  {
    if (shotN<throwN) and scrWM2_At(3+shotN*12)
    {
      scrWM2_Face()
      playSound(global.snd_KnightSwordSwing,0,0.95,20500)
      tA=point_direction(x+scaleForFacing*14,y-30,oPlayer1.x,returnPlayerYCenter())
      tN=3+shotN
      for(i=0;i<tN;i+=1)
      {
        tAng=tA+(i-(tN-1)/2)*(22-shotN*3)
        tS=instance_create(x+scaleForFacing*14,y-30,oWM2_Star)
        tS.type=0; tS.atkPower=atkPower
        tS.vx=lengthdir_x(starSpd,tAng); tS.vy=lengthdir_y(starSpd,tAng)
      }
      shotN+=1
    }
    if stT>=3+12*throwN
    {
      bGravity=1
      scrWM2_Anim(sWM2P_Fall,0.3)
      scrWM2_St(3)
    }
  }
  else if st=3 //falls
  {
    if image_index>=4 {image_index=4; image_speed=0}
    if onGround=1
    {
      scrWM2_Pose(sWM2P_Fall,5)
      scrWM2_St(4)
    }
  }
  else if st=4 //lands
  {
    if stT>=3 {image_index=6}
    if stT>=7 {event_user(0)}
  }
}
else if currentAttack=3 //==================== PHANTOM RUSH ====================
{
  if st=0 //sets himself
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2P_Ready,0)
      playSound(global.snd_DashWarn,0,1,1)
      tF=scrWM2_Fx(x+scaleForFacing*8,y-42,sWM2_Impact,0.6,c_white,1)
      tF.image_xscale=0.45; tF.image_yscale=0.45
      rushNo+=1
      echoTick=0
    }
    if stT>=readyT
    {
      scrWM2_Pose(sWM2P_DashSlash,1)
      xVel=rushSpd*scaleForFacing
      playSound(global.snd_ChargeStrike,0,0.92,19000)
      scrWM2_Hit(-6,-40,46,38,60,1)
      scrWM2_St(1)
    }
  }
  else if st=1 //dashes, leaving shadows behind
  {
    image_index=1+(floor(stT*0.5) mod 3)
    if gDeltaDoTicks
    {
      scrWM2_Ghost(0.5,0.12,colP,1)
      echoTick+=1
      if echoTick mod 3=0
      {
        tE=instance_create(x,y,oWM2_Echo)
        tE.group=rushNo; tE.atkPower=atkPower
        tE.image_xscale=image_xscale; tE.image_yscale=image_yscale
      }
    }
    if wallHit!=0 or stT>=40
    {
      xVel=0
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      scrWM2_Pose(sWM2P_DashEnd,0)
      with oWM2_Echo {if group=other.rushNo {fireT=10}}
      scrWM2_St(2)
    }
  }
  else if st=2 //stops: the shadows flash, then all cut at once
  {
    image_index=min(2,floor(stT/3))
    if scrWM2_At(10)
    {
      playSound(global.snd_DeathSlash,0,1,30500)
      playSound(global.snd_BladeStrike,0,0.9,22000)
    }
    if rep<repMax-1 and stT>=18 {rep+=1; scrWM2_St(0)}
    else if stT>=24 {event_user(0)}
  }
}
else if currentAttack=4 //==================== MOON CRESCENT (anti-air) ====================
{
  if st=0 //crouches
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2P_DashEnd,1)
      playSound(global.snd_ChargeStrike,0,0.95,14000)
      tF=scrWM2_Fx(x+scaleForFacing*8,y-34,sWM2_Impact,0.6,colP,1)
      tF.image_xscale=0.5; tF.image_yscale=0.5
    }
    if stT>=crouchT
    {
      scrWM2_Pose(sWM2P_AirSlash,1)
      y-=2; yVel=-12.5; onGround=0
      xVel=median(-4,(oPlayer1.x-x)/14,4)
      playSound(global.snd_DeathSlash,0,1,30500)
      scrWM2_Hit(-26,-58,52,58,40,1)
      scrWM2_St(1)
    }
  }
  else if st=1 //spins upward
  {
    image_index=1+(floor(stT*0.5) mod 3)
    if gDeltaDoTicks {scrWM2_Ghost(0.45,0.1,colP,1)}
    if yVel>=0 or stT>=18
    {
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      bGravity=0; yVel=0; xVel=0
      scrWM2_Face()
      scrWM2_Pose(sWM2P_AirSlash,4)
      //aims a steep dive at the player
      tdir=point_direction(x,y-20,oPlayer1.x,oPlayer1.y-10)
      if tdir<200 or tdir>340
      {
        if oPlayer1.x>=x {tdir=340} else {tdir=200}
        if abs(oPlayer1.x-x)<40 {tdir=270}
      }
      scrWM2_Tele(2,x,y-20,x+lengthdir_x(320,tdir),y-20+lengthdir_y(320,tdir),diveTeleT+1,colP)
      scrWM2_St(2)
    }
  }
  else if st=2 //takes aim
  {
    if stT>=diveTeleT
    {
      scrWM2_Anim(sWM2P_RollSlash,0.5)
      xVel=lengthdir_x(diveSpd,tdir); yVel=lengthdir_y(diveSpd,tdir)
      scrWM2_Hit(-24,-50,48,50,60,1)
      playSound(global.snd_KnightSwordSwing,0,0.9,11025)
      scrWM2_St(3)
    }
  }
  else if st=3 //dives
  {
    if gDeltaDoTicks {scrWM2_Ghost(0.5,0.12,colP,1)}
    if onGround=1 or stT>=40
    {
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      xVel=0; yVel=0; bGravity=1
      scrWM2_Pose(sWM2P_DashEnd,1)
      playSound(global.snd_HardHit1,0,0.95,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(3)
      scrWM2_Smoke(x,y,colP)
      for(i=-1;i<=1;i+=2)
      {
        tC=instance_create(x+i*16,yGround-13,oWM2_Crescent)
        tC.dir=i; tC.spd=cresSpd2; tC.scl=0.45; tC.atkPower=atkPower
      }
      scrWM2_St(4)
    }
  }
  else if st=4 //lands
  {
    if stT>=12 {image_index=2}
    if stT>=16 {event_user(0)}
  }
}
else if currentAttack=5 //==================== DARK SPHERE ====================
{
  if st=0 //raises a hand; the sphere forms over it
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2P_Cast,0)
      playSound(global.snd_Charge,0,0.9,24000)
      tO=instance_create(x+scaleForFacing*6,y-74,oWM2_Orb)
      tO.owner=id; tO.atkPower=atkPower
      tO.spd=orbSpd; tO.lifeT=orbLife; tO.burstN=orbN; tO.burstSpd=orbBurst
      aura=1
    }
    if stT>=6 {image_index=1}
    if stT>=20
    {
      aura=0
      scrWM2_Pose(sWM2P_Throw,0)
      scrWM2_St(1)
    }
  }
  else if st=1 //sends it off
  {
    if stT>=10 {event_user(0)}
  }
}
else if currentAttack=9 //==================== PHANTOM CROSS (super) ====================
{
  if st=0 //vanishes
  {
    if stPrev=0
    {
      superCharge=0
      scrWM2_Pose(sWM2P_DashStart,0)
      playSound(global.snd_KnightSwordSwing,0,0.9,40000)
    }
    if stT>=3
    {
      scrWM2_Smoke(x,y,colP)
      scrWM2_Ghost(0.7,0.1,colP,1)
      hidden=1; bCanDealDamage=0; bCanTakeDamage=0
      scrWM2_St(1)
    }
  }
  else if st=1 //reappears high in the middle; two shadows wait on the floor at either end
  {
    if stT>=8
    {
      hidden=0; bCanDealDamage=1; bCanTakeDamage=1
      x=xCenter; y=150; bGravity=0; xVel=0; yVel=0; onGround=0
      scrWM2_Face()
      scrWM2_Pose(sWM2P_Charge,1)
      aura=1
      playSound(global.snd_Charge,0,0.9,24000)
      playSound(global.snd_Teleport,0,0.85,1)
      scrWM2_Smoke(x,y,colP)
      clA=instance_create(xMin+6,yGround,oWM2_Clone)
      clA.form=1; clA.image_xscale=1.25; clA.atkPower=atkPower; clA.sprite_index=sWM2P_Ready
      clB=instance_create(xMax-6,yGround,oWM2_Clone)
      clB.form=1; clB.image_xscale=-1.25; clB.atkPower=atkPower; clB.sprite_index=sWM2P_Ready
      scrWM2_Smoke(xMin+6,yGround,colP)
      scrWM2_Smoke(xMax-6,yGround,colP)
      scrWM2_St(2)
    }
  }
  else if st=2 //charges; then the shadows dash at each other
  {
    image_index=1+(floor(stT*0.5) mod 4)
    if stT>=crossTeleT
    {
      playSound(global.snd_ChargeStrike,0,0.92,19000)
      with clA {mode=1; dir=1; dashSpd=other.cloneSpd; stopX=other.xMax-6; scaleForFacing=1; scrWM2_Hit(-6,-40,46,38,60,1)}
      with clB {mode=1; dir=-1; dashSpd=other.cloneSpd; stopX=other.xMin+6; scaleForFacing=-1; scrWM2_Hit(-6,-40,46,38,60,1)}
      scrWM2_St(3)
    }
  }
  else if st=3 //they cross; once they stop they leap up
  {
    image_index=1+(floor(stT*0.5) mod 4)
    tN=1
    if instance_exists(clA) {if clA.mode!=0 {tN=0}}
    if instance_exists(clB) {if clB.mode!=0 {tN=0}}
    if tN=1 or stT>=44
    {
      with clA {mode=2; vy=-11; hoverY=150; t=0; scrWM2_Face()}
      with clB {mode=2; vy=-11; hoverY=150; t=0; scrWM2_Face()}
      scrWM2_St(4)
    }
  }
  else if st=4 //they lock onto where the player is, then dive
  {
    image_index=1+(floor(stT*0.5) mod 4)
    if scrWM2_At(10)
    {
      tx=oPlayer1.x; ty=yGround
      if instance_exists(clA) {tT=scrWM2_Tele(2,clA.x,clA.y-20,tx,ty-10,cloneTeleT+1,colP); tT.owner=clA; tT.oy=-20}
      if instance_exists(clB) {tT=scrWM2_Tele(2,clB.x,clB.y-20,tx,ty-10,cloneTeleT+1,colP); tT.owner=clB; tT.oy=-20}
    }
    if stT>=10+cloneTeleT
    {
      with clA {mode=3; t=0; diveDir=point_direction(x,y-20,other.tx,other.ty); diveSpd=other.cloneDive; scaleForFacing=sign(image_xscale); scrWM2_Hit(-24,-50,48,50,60,1)}
      with clB {mode=3; t=0; diveDir=point_direction(x,y-20,other.tx,other.ty); diveSpd=other.cloneDive; scaleForFacing=sign(image_xscale); scrWM2_Hit(-24,-50,48,50,60,1)}
      playSound(global.snd_KnightSwordSwing,0,0.9,11025)
      scrWM2_St(5)
    }
  }
  else if st=5 //his turn: a column follows the player, then locks
  {
    image_index=1+(floor(stT*0.5) mod 4)
    if stPrev=0
    {
      tT=scrWM2_Tele(0,oPlayer1.x,0,16,0,colTrack+lockHold+1,colP)
      tT.trackPlayer=1; tT.lockT=colTrack
    }
    if scrWM2_At(colTrack) {tx=oPlayer1.x}
    if stT>=colTrack+lockHold
    {
      scrWM2_Anim(sWM2P_RollSlash,0.5)
      tdir=point_direction(x,y,tx,yGround)
      xVel=lengthdir_x(14,tdir); yVel=lengthdir_y(14,tdir)
      if tx>=x {image_xscale=1.25} else {image_xscale=-1.25}
      scaleForFacing=sign(image_xscale)
      scrWM2_Hit(-24,-50,48,50,60,1)
      aura=0
      playSound(global.snd_KnightSwordSwing,0,0.9,11025)
      scrWM2_St(6)
    }
  }
  else if st=6 //dives
  {
    if gDeltaDoTicks {scrWM2_Ghost(0.5,0.12,colP,1)}
    if onGround=1 or stT>=40
    {
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      with oWM2_Clone {mode=9}
      xVel=0; yVel=0; bGravity=1
      scrWM2_Pose(sWM2P_DashEnd,1)
      playSound(global.snd_HardHit1,0,1,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(5)
      scrWM2_Smoke(x,y,colP)
      for(i=-1;i<=1;i+=2)
      {
        tC=instance_create(x+i*16,yGround-19,oWM2_Crescent)
        tC.dir=i; tC.spd=7.5; tC.scl=0.6; tC.atkPower=atkPower
      }
      scrWM2_St(7)
    }
  }
  else if st=7 //winded
  {
    if stT>=24 {image_index=2}
    if stT>=30 {event_user(0)}
  }
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///X FORM
var tS,tA,tT,tF,tP,i;
if currentAttack=1 //==================== BUSTER (a run-and-gun barrage, or a standing burst up close) ====================
{
  if st=0
  {
    scrWM2_Face()
    shotN=0
    if abs(oPlayer1.x-x)>170
    {
      scrWM2_Anim(sWM2X_RunShoot,0.3)
      xVel=runSpd*scaleForFacing
      scrWM2_St(1)
    }
    else
    {
      scrWM2_Pose(sWM2X_Shoot,0)
      scrWM2_St(3)
    }
  }
  else if st=1 //runs at the player, firing
  {
    if shotN<runShots and stT>=2 and (stPrev<2 or floor((stT-2)/runGap)!=floor((stPrev-2)/runGap))
    {
      tS=instance_create(x+scaleForFacing*26,y-27,oWM2_Shot)
      tS.type=0; tS.vx=lemonSpd*scaleForFacing; tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,15000)
      shotN+=1
    }
    if (shotN>=runShots and stT>=2+runGap*runShots) or abs(oPlayer1.x-x)<48 or wallHit!=0
    {
      xVel=0
      scrWM2_Pose(sWM2X_DashEnd,0)
      scrWM2_St(2)
    }
  }
  else if st=2 //skids to a stop
  {
    xVel=0
    image_index=min(2,floor(stT/3))
    if stT>=9 {event_user(0)}
  }
  else if st=3 //standing burst: three straight, then (higher levels) two aimed
  {
    if scrWM2_At(5) or scrWM2_At(9) or scrWM2_At(13)
    {
      tS=instance_create(x+scaleForFacing*26,y-27,oWM2_Shot)
      tS.type=0; tS.vx=lemonSpd*scaleForFacing; tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,15000)
    }
    if DIFFICULTY>=2 and (scrWM2_At(19) or scrWM2_At(23))
    {
      scrWM2_Face()
      tA=point_direction(x+scaleForFacing*26,y-27,oPlayer1.x,returnPlayerYCenter())
      tS=instance_create(x+scaleForFacing*26,y-27,oWM2_Shot)
      tS.type=0; tS.vx=lengthdir_x(lemonSpd,tA); tS.vy=lengthdir_y(lemonSpd,tA); tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,17000)
    }
    if stT>=5 and stT<26 {image_index=1+(floor(stT/2) mod 2)} else {image_index=0}
    if stT>=30 or (DIFFICULTY<2 and stT>=22) {event_user(0)}
  }
}
else if currentAttack=2 //==================== CHARGE SHOT (green, then blue) ====================
{
  if st=0 //charges
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2X_Charge,0)
      playSound(global.snd_WepCharge,0,0.94,13000)
      aura=2
    }
    if stT>=6 {image_index=2+(floor(stT*0.5) mod 3)}
    if gDeltaDoTicks {tF=scrWM2_Fx(x+scaleForFacing*24+random_range(-26,26),y-27+random_range(-26,26),sWM2_Disc,0,make_color_rgb(80,255,120),1); tF.image_xscale=0.15; tF.image_yscale=0.15; tF.life=6; tF.vx=(x+scaleForFacing*24-tF.x)/6; tF.vy=(y-27-tF.y)/6}
    if stT>=chargeT1
    {
      scrWM2_Pose(sWM2X_ChargeShoot,1)
      tS=instance_create(x+scaleForFacing*30,y-26,oWM2_Shot)
      tS.type=1; tS.vx=semiSpd*scaleForFacing; tS.atkPower=atkPower
      playSound(global.snd_CShotB,0,0.95,37000)
      scrWM2_St(1)
    }
  }
  else if st=1 //recoil
  {
    if stT>=2 {image_index=2}
    if stT>=6
    {
      scrWM2_Pose(sWM2X_Charge,2)
      playSound(global.snd_WepChargeComplete,0,1,1)
      scrWM2_St(2)
    }
  }
  else if st=2 //charges again, all the way
  {
    image_index=2+(floor(stT*0.5) mod 3)
    if gDeltaDoTicks {tF=scrWM2_Fx(x+scaleForFacing*24+random_range(-30,30),y-27+random_range(-30,30),sWM2_Disc,0,colX,1); tF.image_xscale=0.18; tF.image_yscale=0.18; tF.life=6; tF.vx=(x+scaleForFacing*24-tF.x)/6; tF.vy=(y-27-tF.y)/6}
    if stT>=chargeT2
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2X_ChargeShoot,1)
      tS=instance_create(x+scaleForFacing*30,y-22,oWM2_Shot)
      tS.type=2; tS.vx=fullSpd*scaleForFacing; tS.atkPower=atkPower+2
      if DIFFICULTY>=2 {tS.split=1}
      playSound(global.snd_Beam,0,1,18000)
      scrWM2_Shake(2)
      aura=0
      scrWM2_St(3)
    }
  }
  else if st=3 //recovers
  {
    if stT>=2 {image_index=2}
    if stT>=6 {scrWM2_Pose(sWM2X_Idle,0)}
    if stT>=14 {event_user(0)}
  }
}
else if currentAttack=3 //==================== WALL-KICK RICOCHET ====================
{
  if st=0 //dashes to the nearer wall
  {
    if stPrev=0
    {
      if x<xCenter {wallSide=-1} else {wallSide=1}
      image_xscale=1.25*wallSide; scaleForFacing=wallSide
      scrWM2_Anim(sWM2X_Dash,0.25)
      xVel=10*wallSide
      playSound(global.snd_MMSlide,0,0.98,1)
      kicks=0
    }
    if gDeltaDoTicks {scrWM2_Ghost(0.4,0.12,colX,1)}
    if wallHit=wallSide or stT>=30
    {
      xVel=0; yVel=0; bGravity=0
      image_xscale=-1.25*wallSide; scaleForFacing=-wallSide
      scrWM2_Pose(sWM2X_WallCling,0)
      playSound(global.snd_HardHit3,0,0.8,26000)
      scrWM2_St(1)
    }
  }
  else if st=1 //clings
  {
    if stT>=clingT
    {
      if kicks>=kickMax
      {
        bGravity=1
        scrWM2_Anim(sWM2X_Fall,0.2)
        xVel=-wallSide*2
        scrWM2_St(3)
      }
      else
      {
        //kicks off across the arena
        image_xscale=-1.25*wallSide; scaleForFacing=-wallSide
        xVel=-wallSide*9; y-=2; yVel=-12.5; bGravity=1; onGround=0
        scrWM2_Anim(sWM2X_WallKick,0.3)
        playSound(global.snd_HardHit3,0,0.7,30000)
        kicks+=1; fired=0
        scrWM2_St(2)
      }
    }
  }
  else if st=2 //flies across, firing a ricochet at the top of the arc
  {
    if image_index>=3 {image_index=3; image_speed=0}
    if fired=0 and yVel>=0
    {
      fired=1
      scrWM2_Face()
      scrWM2_Pose(sWM2X_JumpShoot,1)
      tA=point_direction(x+scaleForFacing*20,y-26,oPlayer1.x,returnPlayerYCenter())
      tS=instance_create(x+scaleForFacing*20,y-26,oWM2_Shot)
      tS.type=3; tS.vx=lengthdir_x(ricSpd,tA); tS.vy=lengthdir_y(ricSpd,tA); tS.bounces=ricBounce; tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,15000)
    }
    if gDeltaDoTicks {scrWM2_Ghost(0.35,0.12,colX,1)}
    if onGround=1 and stT>3 {scrWM2_Anim(sWM2X_Dash,0.25)} //came down short: slides the rest of the way
    if wallHit!=0 and wallHit=sign(xVel)
    {
      wallSide=wallHit
      xVel=0; yVel=0; bGravity=0
      image_xscale=-1.25*wallSide; scaleForFacing=-wallSide
      scrWM2_Pose(sWM2X_WallCling,0)
      playSound(global.snd_HardHit3,0,0.8,26000)
      scrWM2_St(1)
    }
  }
  else if st=3 //drops down
  {
    if onGround=1
    {
      xVel=0
      scrWM2_Pose(sWM2X_Land,0)
      scrWM2_St(4)
    }
  }
  else if st=4 //lands
  {
    if stT>=4 {image_index=1}
    if stT>=12 {event_user(0)}
  }
}
else if currentAttack=4 //==================== NOVA STRIKE ====================
{
  if st=0 //leaps to a high corner on the far side from the player
  {
    if stPrev=0
    {
      if oPlayer1.x<xCenter {wallSide=1} else {wallSide=-1}
      tx=xCenter+wallSide*(xMax-xCenter); ty=132
      jx=x; jy=y
      bGravity=0; xVel=0; yVel=0; onGround=0
      image_xscale=1.25*wallSide; scaleForFacing=wallSide
      scrWM2_Anim(sWM2X_Jump,0.3)
      playSound(global.snd_MMSlide,0,0.98,1)
    }
    tP=min(1,stT/16)
    x=jx+(tx-jx)*tP
    y=jy+(ty-jy)*tP-sin(tP*pi)*30
    if image_index>=2 {image_index=2; image_speed=0}
    if gDeltaDoTicks {scrWM2_Ghost(0.35,0.12,colX,1)}
    if stT>=16
    {
      x=tx; y=ty
      image_xscale=-1.25*wallSide; scaleForFacing=-wallSide
      scrWM2_Pose(sWM2X_WallCling,0)
      aura=2
      playSound(global.snd_Charge,0,0.9,24000)
      tT=scrWM2_Tele(2,x,y-20,oPlayer1.x,returnPlayerYCenter(),novaAim+novaLock+1,colX)
      tT.trackPlayer=1; tT.lockT=novaAim; tT.owner=id; tT.ox=0; tT.oy=-20
      scrWM2_St(1)
    }
  }
  else if st=1 //locks on
  {
    if scrWM2_At(novaAim)
    {
      tdir=point_direction(x,y-20,oPlayer1.x,returnPlayerYCenter())
      if tdir<190 or tdir>350 //only ever downward
      {
        if oPlayer1.x>=x {tdir=350} else {tdir=190}
      }
      playSound(global.snd_WepChargeComplete,0,1,1)
    }
    if stT>=novaAim+novaLock
    {
      scrWM2_Pose(sWM2X_Dash,1)
      if lengthdir_x(1,tdir)>=0 {image_xscale=1.25; image_angle=tdir}
      else {image_xscale=-1.25; image_angle=tdir-180}
      scaleForFacing=sign(image_xscale)
      xVel=lengthdir_x(novaSpd,tdir); yVel=lengthdir_y(novaSpd,tdir)
      scrWM2_Hit(-22,-44,44,44,60,1)
      playSound(global.snd_ChargeStrike,0,0.92,19000)
      scrWM2_St(2)
    }
  }
  else if st=2 //Nova Strike
  {
    if gDeltaDoTicks
    {
      scrWM2_Ghost(0.6,0.1,colX,1)
      tF=scrWM2_Fx(x,y-20,sWM2_ShotB,0.5,colX,1)
      tF.image_angle=point_direction(0,0,xVel,yVel); tF.image_xscale=1.4; tF.image_yscale=1.4; tF.fade=0.15; tF.life=999
    }
    if onGround=1 or wallHit!=0 or stT>=40
    {
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      image_angle=0; aura=0; bGravity=1
      playSound(global.snd_HardHit1,0,0.95,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(4)
      if onGround=1
      {
        xVel=0; yVel=0
        for(i=-1;i<=1;i+=2)
        {
          tS=instance_create(x+i*10,yGround-7,oWM2_Shot)
          tS.type=0; tS.vx=i*6.5; tS.atkPower=atkPower
        }
        if DIFFICULTY>=2
        {
          for(i=0;i<4;i+=1)
          {
            tA=60+i*20
            tS=instance_create(x,yGround-10,oWM2_Shot)
            tS.type=0; tS.vx=lengthdir_x(6.5,tA); tS.vy=lengthdir_y(6.5,tA); tS.grav=0.35; tS.atkPower=atkPower
          }
        }
      }
      else {xVel=0; yVel=0}
      scrWM2_St(3)
    }
  }
  else if st=3 //lands
  {
    if onGround=0 {scrWM2_Anim(sWM2X_Fall,0.2); stT=0}
    else
    {
      if sprite_index!=sWM2X_Land {scrWM2_Pose(sWM2X_Land,0)}
      if stT>=4 {image_index=1}
      if stT>=14
      {
        if novaN<novaMax-1 {novaN+=1; scrWM2_St(0)}
        else {event_user(0)}
      }
    }
  }
}
else if currentAttack=5 //==================== HOP STING ====================
{
  if st=0 //crouches
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2X_Land,0)
    }
    if stT>=hopT
    {
      //hops so he's over the player at the top of the arc
      y-=2; yVel=-12; onGround=0
      xVel=median(-9,(oPlayer1.x-x)/20,9)
      scrWM2_Anim(sWM2X_Jump,0.3)
      playSound(global.snd_MMSlide,0,0.9,1)
      fired=0
      scrWM2_St(1)
    }
  }
  else if st=1 //up and over
  {
    if image_index>=2 {image_index=2; image_speed=0}
    if yVel>=-0.5
    {
      bGravity=0; yVel=0; xVel=0
      scrWM2_Pose(sWM2X_Charge,2)
      aura=2
      scrWM2_St(2)
    }
  }
  else if st=2 //sprays three shots down
  {
    image_index=2+(floor(stT*0.5) mod 3)
    if scrWM2_At(stingDelay) or (DIFFICULTY>=3 and scrWM2_At(stingDelay+8))
    {
      tA=0
      if stT>=stingDelay+8 {tA=stingSpread/2}
      for(i=-1;i<=1;i+=1)
      {
        tS=instance_create(x,y-20,oWM2_Shot)
        tS.type=3; tS.bounces=0; tS.atkPower=atkPower
        tS.vx=lengthdir_x(stingSpd,270+i*stingSpread+tA); tS.vy=lengthdir_y(stingSpd,270+i*stingSpread+tA)
      }
      playSound(global.snd_CShotB,0,0.95,37000)
    }
    if (DIFFICULTY<3 and stT>=stingDelay+10) or stT>=stingDelay+18
    {
      bGravity=1; aura=0
      scrWM2_Anim(sWM2X_Fall,0.2)
      xVel=scaleForFacing*2
      scrWM2_St(3)
    }
  }
  else if st=3 //falls
  {
    if onGround=1
    {
      xVel=0
      scrWM2_Face()
      scrWM2_Pose(sWM2X_Shoot,0)
      scrWM2_St(4)
    }
  }
  else if st=4 //lands and snaps a shot back
  {
    if scrWM2_At(4)
    {
      scrWM2_Face()
      tA=point_direction(x+scaleForFacing*26,y-27,oPlayer1.x,returnPlayerYCenter())
      tS=instance_create(x+scaleForFacing*26,y-27,oWM2_Shot)
      tS.type=0; tS.vx=lengthdir_x(lemonSpd,tA); tS.vy=lengthdir_y(lemonSpd,tA); tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,15000)
      image_index=1
    }
    if stT>=12
    {
      if hops<hopMax-1 {hops+=1; scrWM2_St(0)}
      else {event_user(0)}
    }
  }
}
else if currentAttack=9 //==================== GIGA BARRAGE (super) ====================
{
  if st=0 //beams out
  {
    if stPrev=0
    {
      superCharge=0
      bCanTakeDamage=0; bCanDealDamage=0
      scrWM2_Pose(sWM2X_Warp,4)
      playSound(global.snd_MMBeamUp,0,1,1)
    }
    image_index=max(0,4-floor(stT/2))
    if stT>=10
    {
      tF=scrWM2_Fx(x,y,sWM2_Beam,0,colX,1)
      tF.image_index=3; tF.vy=-14; tF.fade=0.08; tF.life=999
      hidden=1
      scrWM2_St(1)
    }
  }
  else if st=1 //beams in at the far wall
  {
    if stPrev=0
    {
      if oPlayer1.x<xCenter {x=xMax-4} else {x=xMin+4}
      y=yGround; yVel=0; bGravity=1
      scrWM2_Face()
      tF=scrWM2_Fx(x,y,sWM2_Beam,0.6,colX,1)
      playSound(global.snd_MMBeamDown,0,1,1)
    }
    if stT>=6 and hidden=1 {hidden=0; scrWM2_Pose(sWM2X_Warp,0)}
    if hidden=0 {image_index=min(4,floor((stT-6)/2))}
    if stT>=16
    {
      bCanTakeDamage=1; bCanDealDamage=1
      scrWM2_Pose(sWM2X_Charge,2)
      aura=2
      playSound(global.snd_Charge,0,0.9,24000)
      scrWM2_St(2)
    }
  }
  else if st=2 //charges up
  {
    image_index=2+(floor(stT*0.5) mod 3)
    if floor(stT/6)!=floor(stPrev/6)
    {
      tF=scrWM2_Fx(x+scaleForFacing*20,y-27,sWM2_RingHit,0.4,colX,1)
      tF.image_xscale=1.5; tF.image_yscale=1.5; tF.grow=0.1
    }
    if stT>=18 {scrWM2_St(3)}
  }
  else if st=3 //five shots: low, high, low, high, then a giant one
  {
    for(i=0;i<5;i+=1)
    {
      tP=i*gigaGap
      if scrWM2_At(tP+1) //the warning for this shot
      {
        if i=4 {scrWM2_Tele(1,0,yGround-72,scaleForFacing*-1,yGround-1,gigaWarn+4,make_color_rgb(140,200,255))}
        else if (i mod 2)=0 {scrWM2_Tele(1,0,yGround-34,scaleForFacing*-1,yGround-1,gigaWarn+4,colX)}
        else {scrWM2_Tele(1,0,yGround-82,scaleForFacing*-1,yGround-50,gigaWarn+4,colX)}
        scrWM2_Pose(sWM2X_Charge,2)
      }
      if scrWM2_At(tP+1+gigaWarn) //and the shot
      {
        scrWM2_Pose(sWM2X_ChargeShoot,1)
        lastShotT=stT
        tS=instance_create(x+scaleForFacing*30,yGround-17,oWM2_Shot)
        tS.atkPower=atkPower+2; tS.vx=gigaSpd*scaleForFacing; tS.type=2
        if (i mod 2)=1 {tS.y=yGround-66}
        if i=4 {tS.type=4; tS.y=yGround-34; tS.atkPower=atkPower+4; scrWM2_Shake(5)}
        else {scrWM2_Shake(2)}
        playSound(global.snd_Beam,0,1,18000)
      }
    }
    if sprite_index=sWM2X_ChargeShoot
    {
      image_index=1+min(1,floor((stT-lastShotT)/3))
      if stT-lastShotT>=8 {scrWM2_Pose(sWM2X_Charge,2)}
    }
    else {image_index=2+(floor(stT*0.5) mod 3)}
    if stT>=4*gigaGap+1+gigaWarn+16 {scrWM2_St(4)}
  }
  else if st=4 //spent
  {
    if stPrev=0 {scrWM2_Pose(sWM2X_Land,1); aura=0}
    if stT>=gigaRest {event_user(0)}
  }
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///SABER FORM
var tS,tC,tF,tP,tD,tK,tX,i,ii;
if currentAttack=1 //==================== SABER TRIAD (three cuts, stepping in) ====================
{
  if st=0 //sets his stance
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_Crouch,0)
      playSound(global.snd_DashWarn,0,0.9,1)
      tF=scrWM2_Fx(x+scaleForFacing*14,y-30,sWM2_Impact,0.6,colZ,1)
      tF.image_xscale=0.45; tF.image_yscale=0.45
    }
    if stT>=triadT
    {
      scrWM2_Pose(sWM2Z_Slash,0)
      xVel=stepSpd*scaleForFacing
      playSound(global.snd_KnightSwordSwing,0,0.9,40000)
      scrWM2_Hit(4,-40,54,38,6,1)
      scrWM2_St(1)
    }
  }
  else if st=1 //1: a low cut
  {
    image_index=min(2,floor(stT/2))
    if stT>=4 {xVel=0}
    if stT>=hitGap
    {
      scrWM2_Pose(sWM2Z_Thrust,3)
      xVel=(stepSpd+2)*scaleForFacing
      playSound(global.snd_ChargeStrike,0,0.95,19000)
      scrWM2_Hit(8,-36,62,22,5,1)
      if DIFFICULTY>=3 //the thrust also sends a streak of energy
      {
        tS=instance_create(x+scaleForFacing*30,y-25,oWM2_Shot)
        tS.type=5; tS.vx=9*scaleForFacing; tS.atkPower=atkPower
      }
      scrWM2_St(2)
    }
  }
  else if st=2 //2: a thrust
  {
    image_index=3+min(2,floor(stT/2))
    if stT>=4 {xVel=0}
    if stT>=hitGap
    {
      scrWM2_Pose(sWM2Z_Rise,0)
      y-=2; yVel=-9; onGround=0
      xVel=2*scaleForFacing
      playSound(global.snd_DeathSlash,0,1,30500)
      scrWM2_Hit(-22,-82,60,78,10,1)
      scrWM2_St(3)
    }
  }
  else if st=3 //3: a rising cut
  {
    image_index=min(3,floor(stT/2))
    if gDeltaDoTicks {scrWM2_Ghost(0.4,0.12,colZ,1)}
    if onGround=1 and stT>3
    {
      xVel=0
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      scrWM2_Pose(sWM2Z_Land,1)
      scrWM2_St(4)
    }
  }
  else if st=4 //lands, open
  {
    if stT>=6 {image_index=2}
    if stT>=12 {event_user(0)}
  }
}
else if currentAttack=2 //==================== CRESCENT CHARGE (one huge cut) ====================
{
  if st=0 //charges the saber
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_ChargeSaber,0)
      playSound(global.snd_WepCharge,0,0.94,11000)
      aura=4
    }
    if stT>=2 {image_index=2+(floor(stT*0.4) mod 8)}
    if gDeltaDoTicks
    {
      tF=scrWM2_Fx(x-scaleForFacing*20+random_range(-30,30),y-40+random_range(-24,24),sWM2_Disc,0,colZ,1)
      tF.image_xscale=0.15; tF.image_yscale=0.15; tF.life=6
      tF.vx=(x-scaleForFacing*20-tF.x)/6; tF.vy=(y-40-tF.y)/6
    }
    if stT>=zChargeT
    {
      scrWM2_Pose(sWM2Z_BigSlash,0)
      playSound(global.snd_DeathSlash,0,1,26000)
      playSound(global.snd_Beam,0,0.9,14000)
      scrWM2_Shake(3)
      scrWM2_Hit(-10,-88,122,88,6,1)
      if DIFFICULTY>=2 //and a crescent runs on along the floor
      {
        tC=instance_create(x+scaleForFacing*70,yGround-19,oWM2_Crescent)
        tC.sprite_index=sWM2_CrescentZ; tC.glow=colZ; tC.sparkCol=colZ
        tC.dir=scaleForFacing; tC.spd=7; tC.atkPower=atkPower
      }
      aura=0
      scrWM2_St(1)
    }
  }
  else if st=1 //the cut
  {
    image_index=min(2,floor(stT/2))
    if stT>=8
    {
      scrWM2_Pose(sWM2Z_DashEnd,0)
      scrWM2_St(2)
    }
  }
  else if st=2 //recovers
  {
    image_index=min(2,floor(stT/4))
    if stT>=12 {event_user(0)}
  }
}
else if currentAttack=3 //==================== SPIKE LINE ====================
{
  if st=0 //raises the saber point-down
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_Stab,0)
      playSound(global.snd_ChargeStrike,0,0.95,14000)
    }
    if stT>=stabT
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      scrWM2_Shake(2)
      scrWM2_Hit(-24,-50,48,50,6,1)
      //a line of spikes erupts away from him, one after another (both ways at higher levels)
      for(ii=0;ii<2;ii+=1)
      {
        if ii=0 {tD=scaleForFacing} else {tD=-scaleForFacing}
        if ii=1 and DIFFICULTY<2 {break}
        for(i=0;i<14;i+=1)
        {
          tX=x+tD*(44+i*spikeGap)
          if tX<xMin-10 or tX>xMax+10 {break}
          tK=instance_create(tX,yGround,oWM2_Spike)
          tK.delay=8+i*spikeStep; tK.atkPower=atkPower; tK.loud=(i mod 4=0)
          if DIFFICULTY>=3 //and a second line between the first's spikes
          {
            tK=instance_create(tX+tD*spikeGap/2,yGround,oWM2_Spike)
            tK.delay=22+i*spikeStep; tK.atkPower=atkPower
          }
        }
      }
      scrWM2_St(1)
    }
  }
  else if st=1 //pillars burst up around him
  {
    image_index=1+min(3,floor(stT/2))
    if stT>=10 {scrWM2_St(2)}
  }
  else if st=2 //pulls the saber out
  {
    image_index=5+min(4,floor(stT/2))
    if stT>=12 {event_user(0)}
  }
}
else if currentAttack=4 //==================== BUSTER FEINT, DASH CUT ====================
{
  if st=0 //aims
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_Shoot,0)
    }
    if stT>=6
    {
      scrWM2_Pose(sWM2Z_Shoot,1)
      tS=instance_create(x+scaleForFacing*20,y-24,oWM2_Shot)
      tS.type=5; tS.vx=10*scaleForFacing; tS.atkPower=atkPower
      playSound(global.snd_CShotA,0,0.97,15000)
      shotN+=1
      scrWM2_St(1)
    }
  }
  else if st=1 //recoil; another shot, or the dash
  {
    if stT>=3 {image_index=2}
    if stT>=6
    {
      if shotN<zShots {scrWM2_St(0)}
      else
      {
        scrWM2_Face()
        scrWM2_Pose(sWM2Z_DashSlash,0)
        xVel=zDashSpd*scaleForFacing
        tx=median(xMin,oPlayer1.x+scaleForFacing*50,xMax)
        scrWM2_Hit(-6,-34,66,34,60,1)
        playSound(global.snd_ChargeStrike,0,0.92,19000)
        scrWM2_St(2)
      }
    }
  }
  else if st=2 //dashes through with the saber out
  {
    image_index=floor(stT*0.5) mod 2
    if gDeltaDoTicks {scrWM2_Ghost(0.45,0.12,colZ,1)}
    if (scaleForFacing=1 and x>=tx) or (scaleForFacing=-1 and x<=tx) or wallHit!=0 or stT>=30
    {
      xVel=0
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      scrWM2_Pose(sWM2Z_DashSlash,2)
      scrWM2_St(3)
    }
  }
  else if st=3 //the trail fades
  {
    image_index=2+min(6,floor(stT/2))
    if stT>=14 {event_user(0)}
  }
}
else if currentAttack=5 //==================== AIR THRUST (stay on the ground) ====================
{
  if st=0 //crouches
  {
    if stPrev=0
    {
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_Crouch,0)
    }
    if stT>=5
    {
      y-=2; yVel=-9; onGround=0
      scrWM2_Anim(sWM2Z_Jump,0.3)
      playSound(global.snd_KnightSwordSwing,0,0.85,20500)
      scrWM2_St(1)
    }
  }
  else if st=1 //rises to just over head height
  {
    if image_index>=3 {image_index=3; image_speed=0}
    if yVel>=0 or stT>=16
    {
      bGravity=0; yVel=0; xVel=0
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_AirThrust,0)
      scrWM2_Tele(1,0,y-46,-scaleForFacing,y-4,airT+2,colZ)
      scrWM2_St(2)
    }
  }
  else if st=2 //winds up
  {
    if stT>=airT/2 {image_index=1}
    if stT>=airT
    {
      scrWM2_Pose(sWM2Z_AirThrust,2)
      xVel=airSpd*scaleForFacing
      scrWM2_Hit(-6,-44,58,40,60,1)
      playSound(global.snd_ChargeStrike,0,0.92,19000)
      scrWM2_St(3)
    }
  }
  else if st=3 //flies across the arena
  {
    image_index=2+(floor(stT*0.5) mod 2)
    if gDeltaDoTicks {scrWM2_Ghost(0.45,0.12,colZ,1)}
    if wallHit!=0 or stT>=40
    {
      xVel=0
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      if rep<repMax-1 //turns and goes again
      {
        rep+=1
        image_xscale=-image_xscale; scaleForFacing=sign(image_xscale)
        scrWM2_Pose(sWM2Z_AirThrust,0)
        scrWM2_Tele(1,0,y-46,-scaleForFacing,y-4,airT+2,colZ)
        scrWM2_St(2)
      }
      else
      {
        bGravity=1
        scrWM2_Anim(sWM2Z_Fall,0.25)
        scrWM2_St(4)
      }
    }
  }
  else if st=4 //drops
  {
    if image_index>=4 {image_index=4; image_speed=0}
    if onGround=1
    {
      scrWM2_Pose(sWM2Z_Land,0)
      scrWM2_St(5)
    }
  }
  else if st=5 //lands
  {
    image_index=min(2,floor(stT/3))
    if stT>=10 {event_user(0)}
  }
}
else if currentAttack=9 //==================== SABER NOVA (super) ====================
{
  if st=0 //leaps to the middle
  {
    if stPrev=0
    {
      superCharge=0
      jx=x; jy=y; tx=xCenter
      bGravity=0; xVel=0; yVel=0; onGround=0
      scrWM2_Anim(sWM2Z_Jump,0.3)
      playSound(global.snd_KnightSwordSwing,0,0.85,20500)
    }
    if image_index>=3 {image_index=3; image_speed=0}
    tP=min(1,stT/16)
    x=jx+(tx-jx)*tP
    y=jy+(yGround-jy)*tP-sin(tP*pi)*70
    if stT>=16
    {
      x=tx; y=yGround; bGravity=1
      scrWM2_Face()
      scrWM2_Pose(sWM2Z_Smash,0)
      aura=4
      playSound(global.snd_Charge,0,0.9,24000)
      scrWM2_St(1)
    }
  }
  else if st=1 //raises the saber
  {
    image_index=min(3,floor(stT/5))
    if gDeltaDoTicks
    {
      tF=scrWM2_Fx(x+random_range(-60,60),y-random_range(0,90),sWM2_Disc,0,colZ,1)
      tF.image_xscale=0.2; tF.image_yscale=0.2; tF.life=7
      tF.vx=(x-tF.x)/7; tF.vy=(y-50-tF.y)/7
    }
    if stT>=novaZT
    {
      image_index=4
      playSound(global.snd_HardHit1,0,1,1)
      scrWM2_Shake(6)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=0.5}
      scrWM2_Hit(-10,-92,124,92,6,0)
      //spikes behind him at once, then lines running out both ways to the walls
      for(i=0;i<4;i+=1)
      {
        tK=instance_create(x-scaleForFacing*(24+i*30),yGround,oWM2_Spike)
        tK.delay=i; tK.scl=0.75; tK.atkPower=atkPower; tK.loud=(i=0)
      }
      for(ii=-1;ii<=1;ii+=2)
      {
        for(i=0;i<10;i+=1)
        {
          tX=x+ii*(150+i*spikeGap)
          if tX<xMin-10 or tX>xMax+10 {break}
          tK=instance_create(tX,yGround,oWM2_Spike)
          tK.delay=8+i*spikeStep; tK.atkPower=atkPower; tK.loud=(i mod 4=0)
        }
      }
      aura=0
      scrWM2_St(2)
    }
  }
  else if st=2 //the burst
  {
    image_index=4+min(3,floor(stT/2))
    if stT>=12
    {
      scrWM2_Pose(sWM2Z_SmashEnd,0)
      scrWM2_St(3)
    }
  }
  else if st=3 //spent
  {
    image_index=min(3,floor(stT/5))
    if stT>=22 {event_user(0)}
  }
}
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///MODEL CHANGE, OVERDRIVE, TRIPLE OVERDRIVE, MODEL SWAP
var tF,tC,tK,tS,tT,tP,tX,tMsg,tCol,tempMplay,i;
if currentAttack=50 //==================== MODEL CHANGE (to nextForm) ====================
{
  if st=0 //knocked back
  {
    if stPrev=0
    {
      bCanTakeDamage=0; bCanDealDamage=0
      with oEProjectileBase {instance_destroy()}
      with oWM2_Tele {instance_destroy()}
      aura=0; hidden=0; image_angle=0
      if FORM=1 {scrWM2_Pose(sWM2P_Hurt,1)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Hurt,1)}
      else {scrWM2_Pose(sWM2Z_Hurt,1)}
      xVel=-scaleForFacing*3; y-=2; yVel=-5; bGravity=1; onGround=0
      playSound(global.snd_HardHit1,0,0.95,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(4)
      if instance_exists(oBTB_Ev_Warmaster2)
      {
        oBTB_Ev_Warmaster2.flash=0.8
        if nextForm=2 {oBTB_Ev_Warmaster2.musFade=1} //his X model has its own theme
      }
    }
    if onGround=1 and stT>4
    {
      xVel=0
      if FORM=1 {scrWM2_Pose(sWM2P_GetUp,0)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Defeat,3)}
      else {scrWM2_Pose(sWM2Z_Defeat,4)}
      scrWM2_St(1)
    }
  }
  else if st=1 //kneels; the old model falls apart
  {
    if stPrev=0
    {
      tMsg="Saber model... spent."
      if FORM=1 {tMsg="Phantom model... discarded."}
      msgCreate(0,0,"Warmaster",tMsg,6,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    if gDeltaDoTicks
    {
      tCol=colZ
      if FORM=1 {tCol=colP}
      tF=scrWM2_Fx(x+random_range(-14,14),y-random(40),sWM2_Disc,0,tCol,1)
      tF.image_xscale=0.2; tF.image_yscale=0.2; tF.fade=0.05; tF.life=999; tF.vy=-1.2
    }
    if stT>=26
    {
      tx=xCenter; jx=x; jy=y
      bGravity=0; onGround=0
      if FORM=1 {scrWM2_Pose(sWM2P_Jump,3)}
      else {scrWM2_Pose(sWM2Z_Jump,2)}
      scrWM2_St(2)
    }
  }
  else if st=2 //hops to the middle
  {
    tP=min(1,stT/14)
    x=jx+(tx-jx)*tP
    y=jy+(yGround-jy)*tP-sin(tP*pi)*40
    if stT>=14
    {
      x=tx; y=yGround; bGravity=1
      scrWM2_Face()
      if FORM=1 {scrWM2_Pose(sWM2P_Warp,5)}
      else {scrWM2_Pose(sWM2Z_Idle,0)}
      scrWM2_St(3)
    }
  }
  else if st=3 //breaks apart in light...
  {
    if stPrev=0
    {
      playSound(global.snd_Transition,0,1,18000)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.lightMode=0}
    }
    if FORM=1 {image_index=max(0,5-floor(stT/2))}
    else if FORM=3 and stT>=4 and hidden=0 //the Saber model beams out
    {
      hidden=1
      tF=scrWM2_Fx(x,y,sWM2_Beam,0,colZ,1)
      tF.image_index=3; tF.vy=-14; tF.fade=0.08; tF.life=999
      playSound(global.snd_MMBeamUp,0,1,1)
    }
    if floor(stT/4)!=floor(stPrev/4)
    {
      tCol=colZ
      if FORM=1 {tCol=colP}
      tF=scrWM2_Fx(x,y-28,sWM2_RingHit,0.4,tCol,1)
      tF.image_xscale=1.6; tF.image_yscale=1.6; tF.grow=0.08
    }
    if stT>=12
    {
      FORM=nextForm
      event_user(4)
      hidden=0
      if FORM=1 {scrWM2_Pose(sWM2P_Warp,0)}
      else {scrWM2_Pose(sWM2X_Warp,0)}
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=1}
      playSound(global.snd_MMBeamDown,0,1,1)
      scrWM2_St(4)
    }
  }
  else if st=4 //...and the new one forms
  {
    if FORM=1 {image_index=min(5,floor(stT/3))}
    else {image_index=min(4,floor(stT/3))}
    if floor(stT/4)!=floor(stPrev/4) and stT<12
    {
      tCol=colP
      if FORM=2 {tCol=colX}
      tF=scrWM2_Fx(x,y-28,sWM2_RingHit,0.4,tCol,1)
      tF.image_xscale=2.4-stT*0.12; tF.image_yscale=2.4-stT*0.12; tF.grow=-0.05
    }
    if stT>=16
    {
      if FORM=1
      {
        scrWM2_Anim(sWM2P_Idle,0.2)
        msgCreate(0,0,"Warmaster","Phantom model. Try to keep your eyes on me.",6,1,oMessagePerson,0)
      }
      else
      {
        scrWM2_Anim(sWM2X_Idle,0.15)
        msgCreate(0,0,"Warmaster","Model X. Keep up.",6,1,oMessagePerson,0)
        tempMplay=findMusic(835)
        playMusic(tempMplay,0,0)
        if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.musFade=0}
      }
      newMessage.fadingTime=80
      scrWM2_St(5)
    }
  }
  else if st=5
  {
    if stT>=18
    {
      PHASE+=1
      DIFFICULTY=2
      if PHASE=2 {waitDelay=26}
      else {waitDelay=24}
      superCharge=0
      currentAttack=60 //a model change doesn't add a charge pip (event_user(0))
      event_user(0)
    }
  }
}
else if currentAttack=51 //==================== OVERDRIVE ====================
{
  if st=0 //knocked back
  {
    if stPrev=0
    {
      bCanTakeDamage=0; bCanDealDamage=0
      with oEProjectileBase {instance_destroy()}
      with oWM2_Tele {instance_destroy()}
      aura=0; hidden=0; image_angle=0
      scrWM2_Pose(sWM2X_Hurt,1)
      xVel=-scaleForFacing*3; y-=2; yVel=-5; bGravity=1; onGround=0
      playSound(global.snd_HardHit1,0,0.95,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(4)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=0.8}
    }
    if onGround=1 and stT>4
    {
      xVel=0
      scrWM2_Pose(sWM2X_Defeat,3)
      scrWM2_St(1)
    }
  }
  else if st=1 //on one knee
  {
    if stPrev=0
    {
      msgCreate(0,0,"Warmaster","...Not yet.",6,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    if gDeltaDoTicks
    {
      tCol=colZ
      if irandom(2)=1 {tCol=colP} else if irandom(1)=1 {tCol=colX}
      tF=scrWM2_Fx(x+random_range(-16,16),y-random(40),sWM2_Disc,0,tCol,1)
      tF.image_xscale=0.2; tF.image_yscale=0.2; tF.fade=0.05; tF.life=999; tF.vy=-1.4
    }
    if stT>=24
    {
      playSound(global.snd_Transition,0,1,18000)
      playSound(global.snd_Charge,0,0.9,24000)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.lightMode=3}
      aura=3
      scrWM2_St(2)
    }
  }
  else if st=2 //all three models flicker through him
  {
    i=floor(stT/3) mod 3
    if i=0 {scrWM2_Pose(sWM2Z_Idle,0)}
    else if i=1 {scrWM2_Pose(sWM2P_Idle,0)}
    else {scrWM2_Pose(sWM2X_Idle,0)}
    if floor(stT/4)!=floor(stPrev/4)
    {
      tCol=colZ
      if i=1 {tCol=colP} else if i=2 {tCol=colX}
      tF=scrWM2_Fx(x,y-28,sWM2_RingHit,0.4,tCol,1)
      tF.image_xscale=1.8; tF.image_yscale=1.8; tF.grow=0.1
    }
    if stT>=24
    {
      msgCreate(0,0,"Warmaster","OVERDRIVE!",6,1,oMessagePerson,0)
      newMessage.fadingTime=60
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=1}
      scrWM2_Shake(4)
      PHASE=4; DIFFICULTY=3; waitDelay=16
      superMax=4; superCharge=2
      FORM=2
      event_user(4)
      scrWM2_Anim(sWM2X_Idle,0.15)
      aura=0
      scrWM2_St(3)
    }
  }
  else if st=3
  {
    if stT>=16
    {
      currentAttack=60
      event_user(0)
    }
  }
}
else if currentAttack=52 //==================== TRIPLE OVERDRIVE (last stand) ====================
{
  if st=0 //vanishes
  {
    if stPrev=0
    {
      desperationDone=1
      bCanTakeDamage=0; bCanDealDamage=0
      with oEProjectileBase {instance_destroy()}
      with oWM2_Tele {instance_destroy()}
      scrWM2_Smoke(x,y,colP)
      hidden=1
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=0.6}
      playSound(global.snd_Transition,0,1,18000)
    }
    if stT>=8
    {
      //high in the middle, charging; a shadow Phantom waits at the left end
      hidden=0
      x=xCenter; y=140; bGravity=0; xVel=0; yVel=0; onGround=0
      scrWM2_Face()
      if FORM=1 {scrWM2_Pose(sWM2P_Charge,1)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Charge,2)}
      else {scrWM2_Pose(sWM2Z_ChargeSaber,2)}
      aura=3
      playSound(global.snd_Charge,0,0.9,24000)
      clA=instance_create(xMin+6,yGround,oWM2_Clone)
      clA.form=1; clA.image_xscale=1.25; clA.atkPower=atkPower; clA.sprite_index=sWM2P_Ready
      scrWM2_Smoke(xMin+6,yGround,colP)
      scrWM2_St(1)
    }
  }
  else if st=1 //beat 1: the Phantom shadow dashes the length of the floor, leaving echoes
  {
    if stT>=14
    {
      playSound(global.snd_ChargeStrike,0,0.92,19000)
      with clA {mode=1; dir=1; dashSpd=13; stopX=other.xMax-6; echoGroup=99; scaleForFacing=1; scrWM2_Hit(-6,-40,46,38,60,1)}
      scrWM2_St(2)
    }
  }
  else if st=2 //beat 2: its echoes cut
  {
    tK=1
    if instance_exists(clA) {if clA.mode!=0 {tK=0}}
    if tK=1 or stT>=40
    {
      with clA {mode=9}
      with oWM2_Echo {if group=99 {fireT=10}}
      scrWM2_St(3)
    }
  }
  else if st=3 //beat 3: a Saber shadow on the right sets off a spike line
  {
    if scrWM2_At(10) {playSound(global.snd_DeathSlash,0,1,30500)}
    if stPrev=0
    {
      clB=instance_create(xMax-6,yGround,oWM2_Clone)
      clB.form=3; clB.image_xscale=-1.25; clB.atkPower=atkPower; clB.sprite_index=sWM2Z_Stab
      scrWM2_Smoke(xMax-6,yGround,colZ)
    }
    if stT>=18
    {
      with clB {image_index=2}
      playSound(global.snd_HardHit1,0,0.9,1)
      for(i=0;i<14;i+=1)
      {
        tX=xMax-6-(44+i*spikeGap)
        if tX<xMin-10 {break}
        tK=instance_create(tX,yGround,oWM2_Spike)
        tK.delay=8+i*spikeStep; tK.atkPower=atkPower; tK.loud=(i mod 4=0)
      }
      scrWM2_St(4)
    }
  }
  else if st=4 //beat 4: then an X shadow fires high...
  {
    if stT>=24 and instance_exists(clB) {with clB {mode=9}}
    if scrWM2_At(26)
    {
      clC=instance_create(xMax-6,yGround,oWM2_Clone)
      clC.form=2; clC.image_xscale=-1.25; clC.atkPower=atkPower; clC.sprite_index=sWM2X_Charge; clC.image_index=2
      scrWM2_Smoke(xMax-6,yGround,colX)
      scrWM2_Tele(1,0,yGround-82,1,yGround-50,16,colX)
    }
    if scrWM2_At(40)
    {
      if instance_exists(clC) {with clC {sprite_index=sWM2X_ChargeShoot; image_index=1}}
      tS=instance_create(xMax-36,yGround-66,oWM2_Shot)
      tS.type=2; tS.vx=-11; tS.atkPower=atkPower+2
      playSound(global.snd_Beam,0,1,18000)
      scrWM2_Shake(2)
    }
    if stT>=44 {scrWM2_St(5)}
  }
  else if st=5 //...and low
  {
    if scrWM2_At(10)
    {
      if instance_exists(clC) {with clC {sprite_index=sWM2X_Charge; image_index=2}}
      scrWM2_Tele(1,0,yGround-34,1,yGround-1,16,colX)
    }
    if scrWM2_At(24)
    {
      if instance_exists(clC) {with clC {sprite_index=sWM2X_ChargeShoot; image_index=1}}
      tS=instance_create(xMax-36,yGround-17,oWM2_Shot)
      tS.type=2; tS.vx=-11; tS.atkPower=atkPower+2
      playSound(global.snd_Beam,0,1,18000)
      scrWM2_Shake(2)
    }
    if stT>=50
    {
      with clC {mode=9}
      tT=scrWM2_Tele(0,oPlayer1.x,0,16,0,19,make_color_rgb(255,255,255))
      tT.trackPlayer=1; tT.lockT=12
      scrWM2_St(6)
    }
  }
  else if st=6 //beat 5: he comes down on the player
  {
    if scrWM2_At(12) {tx=oPlayer1.x}
    if stT>=18
    {
      if FORM=1 {scrWM2_Anim(sWM2P_RollSlash,0.5)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Dash,1)}
      else {scrWM2_Anim(sWM2Z_Dive,0.4)}
      tdir=point_direction(x,y,tx,yGround)
      xVel=lengthdir_x(15,tdir); yVel=lengthdir_y(15,tdir)
      if tx>=x {image_xscale=1.25} else {image_xscale=-1.25}
      scaleForFacing=sign(image_xscale)
      bCanDealDamage=1
      scrWM2_Hit(-24,-50,48,50,60,1)
      playSound(global.snd_KnightSwordSwing,0,0.9,11025)
      scrWM2_St(7)
    }
  }
  else if st=7 //the dive
  {
    if gDeltaDoTicks {scrWM2_Ghost(0.55,0.1,c_white,1)}
    if onGround=1 or stT>=40
    {
      with oWM2_HitBox {if owner=other.id {instance_destroy()}}
      xVel=0; yVel=0; bGravity=1; aura=0
      playSound(global.snd_HardHit1,0,1,1)
      playSound(global.snd_HardHit3,0,0.9,17000)
      scrWM2_Shake(6)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=0.6}
      for(i=-1;i<=1;i+=2)
      {
        tC=instance_create(x+i*16,yGround-19,oWM2_Crescent)
        tC.dir=i; tC.spd=8; tC.scl=0.6; tC.atkPower=atkPower
        tS=instance_create(x,yGround-10,oWM2_Shot)
        tS.type=0; tS.vx=lengthdir_x(6.5,90+i*25); tS.vy=lengthdir_y(6.5,90+i*25); tS.grav=0.35; tS.atkPower=atkPower
      }
      //and he's spent
      bCanDealDamage=0; bCanTakeDamage=1
      if FORM=1 {scrWM2_Pose(sWM2P_GetUp,0)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Defeat,3)}
      else {scrWM2_Pose(sWM2Z_Defeat,4)}
      scrWM2_St(8)
    }
  }
  else if st=8 //collapsed: wide open
  {
    if gDeltaDoTicks and irandom(3)=0
    {
      tF=scrWM2_Fx(x+random_range(-14,14),y-random(36),sWM2_Smoke,0.4,c_gray,0)
      tF.image_xscale=0.5; tF.image_yscale=0.5; tF.vy=-0.6
    }
    if stT>=66
    {
      if FORM=1 {scrWM2_Anim(sWM2P_GetUp,0.4)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Land,0)}
      else {scrWM2_Pose(sWM2Z_Land,0)}
      scrWM2_St(9)
    }
  }
  else if st=9 //back up
  {
    if FORM=1 and image_index>=6 {image_index=6; image_speed=0}
    if stT>=14
    {
      currentAttack=60
      event_user(0)
    }
  }
}
else if currentAttack=53 //==================== MODEL SWAP (Overdrive) ====================
{
  if st=0 //flashes out of the old model...
  {
    if stPrev=0
    {
      playSound(global.snd_MMSlide,0,0.8,1)
      if instance_exists(oBTB_Ev_Warmaster2) {oBTB_Ev_Warmaster2.flash=0.3}
      tCol=colZ
      if nextForm=1 {tCol=colP} else if nextForm=2 {tCol=colX}
      tF=scrWM2_Fx(x,y-28,sWM2_RingHit,0.5,tCol,1)
      tF.image_xscale=1.8; tF.image_yscale=1.8; tF.grow=0.08
      aura=3
      if FORM=1 {scrWM2_Pose(sWM2P_Warp,2)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Warp,2)}
    }
    if stT>=4
    {
      FORM=nextForm
      event_user(4)
      scrWM2_Face()
      if FORM=1 {scrWM2_Pose(sWM2P_Warp,3)}
      else if FORM=2 {scrWM2_Pose(sWM2X_Warp,3)}
      else
      {
        scrWM2_Pose(sWM2Z_Idle,0)
        tF=scrWM2_Fx(x,y,sWM2_Beam,0.9,colZ,1)
      }
      scrWM2_St(1)
    }
  }
  else if st=1 //...into the new one
  {
    if FORM=1 {image_index=min(5,3+floor(stT/2))}
    else if FORM=2 {image_index=min(4,3+floor(stT/2))}
    if stT>=5
    {
      aura=0
      currentAttack=nextAttack
      scrWM2_St(0)
      event_user(6)
    }
  }
}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///FORM SETUP
var i;
for(i=0;i<6;i+=1) {resType[i]=3}
if PHASE<4
{
  if FORM=1 {resType[3]=2}      //Phantom: shots only do half (he cuts them out of the air)
  else if FORM=2 {resType[0]=2} //X: blades only do half (armour)
  else {resType[4]=2}           //Saber: explosions only do half (he cuts through the blast)
}
if PHASE=4 {ATTACK_FORM=8}
else if FORM=3 {ATTACK_FORM=5}
else if FORM=1 {ATTACK_FORM=6}
else {ATTACK_FORM=7}

devText="An imagined sequel fight, made for the remaster: the Warmaster rebuilt with three new models."
if PHASE=4
{
  jeremyText="Overdrive! He swaps models after every attack now, and the flash before each one shows which: green is the saber, purple the phantom, blue the buster. He takes full damage from everything."
  chaoText="Almost there. Right at the end he throws all three models at you, one beat at a time. Get through it and he'll be wide open."
}
else if FORM=3
{
  jeremyText="The Warmaster's back, rebuilt with new models. This first one is all saber: a three-cut combo that walks him forward, a huge charged cut (the area in front of him lights up where it'll land), lines of spikes that burst out of the floor one after another, and a quick buster shot he follows with a dash cut. Explosions only do half damage to him in this form."
  chaoText="When he jumps to just over head height and a band lights up across the arena, stay on the ground: his thrust goes right over you. When the floor glows in a line, the spikes come up in that order, so jump as they reach you."
}
else if FORM=1
{
  jeremyText="Phantom model. He vanishes and comes back behind you (the shimmer shows where), throws fans of shuriken that stick in the floor and burst, and his dash leaves shadows that all cut at once when they flash. Shots only do half damage to him in this form; blades are your best bet."
  chaoText="That dark sphere follows you until it collapses into a ring of kunai, so keep moving and don't fight under it. When his pips fill up he splits into shadows for his big move: watch the band on the floor, then the lines, then the column."
}
else
{
  jeremyText="Model X. Blades only do half damage, so shoot him. Low shots: jump. High shots skim over your head: stay down. He also bounces between the walls firing ricochets, and his Nova Strike locks onto you from a corner, so keep moving once the line goes solid."
  chaoText="The green shot comes first, then the blue one, and later on the blue one splits on the wall. When he beams over to a wall and starts charging, that's his Giga Barrage: count the bands."
}

if instance_exists(oBTB_Ev_Warmaster2)
{
  if PHASE=4 {oBTB_Ev_Warmaster2.lightMode=3}
  else if FORM=1 {oBTB_Ev_Warmaster2.lightMode=1}
  else if FORM=2 {oBTB_Ev_Warmaster2.lightMode=2}
  else {oBTB_Ev_Warmaster2.lightMode=4}
}
#define Other_15
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///CHOOSE AN ATTACK
var tA,tDist,tAir,tForm;
tDist=abs(oPlayer1.x-x)
tAir=(oPlayer1.y<yGround-24)
tForm=FORM
if PHASE=4 //Overdrive: the next model in turn (Saber, Phantom, X)
{
  if FORM=3 {tForm=1}
  else if FORM=1 {tForm=2}
  else {tForm=3}
}
if superCharge>=superMax {tA=9}
else if tForm=3 //Saber
{
  tA=choose(1,1,2,3,4,5)
  if tA=previousAtk {tA=choose(1,2,3,4,5)}
  if tDist>200 and tA=1 {tA=choose(3,4,5)} //too far for the combo
  if tDist<60 and tA=4 {tA=1}              //too close for the buster
}
else if tForm=1 //Phantom
{
  if tAir and tDist<130 and previousAtk!=4 {tA=4}
  else
  {
    tA=choose(1,1,2,3,3,5)
    if tA=5 and instance_exists(oWM2_Orb) {tA=choose(1,2,3)}
    if tA=previousAtk {tA=choose(1,2,3,4)}
    if tDist>230 and tA=2 {tA=choose(1,3)}
  }
}
else //X
{
  tA=choose(1,2,3,4,5)
  if tA=previousAtk {tA=choose(1,2,3,4,5)}
  if tDist<70 and tA=2 {tA=5} //too close to charge: hops over instead
}
nextAttack=tA
st=0; stT=0; stPrev=0
if tForm!=FORM
{
  nextForm=tForm
  currentAttack=53
}
else
{
  currentAttack=tA
  event_user(6)
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///ATTACK SETUP (timings for the current difficulty; od: Overdrive)
var d,od;
d=DIFFICULTY
od=(PHASE=4)
rep=0; repMax=1; shotN=0; kicks=0; novaN=0; hops=0; fired=0
if FORM=3 //==================== SABER ====================
{
  triadT=6; hitGap=9; stepSpd=5
  zChargeT=24; stabT=7; spikeGap=30; spikeStep=3
  zShots=1; zDashSpd=12; airT=10; airSpd=13; novaZT=24
  if d>=2 {triadT=5; hitGap=8; stepSpd=5.5; zChargeT=20; stabT=6; zShots=2; zDashSpd=13; airT=9; airSpd=14; novaZT=22}
  if d>=3 {triadT=4; hitGap=7; stepSpd=6; zChargeT=18; stabT=5; zDashSpd=14; airT=8; airSpd=15; novaZT=20}
  if od {hitGap=6; zChargeT=16; zShots=3}
  if currentAttack=5
  {
    if d>=2 {repMax=2}
  }
}
else if FORM=1 //==================== PHANTOM ====================
{
  if currentAttack=1
  {
    teleT=12; windT=4; cresSpd=6.5
    if d>=2 {teleT=10; windT=3; cresSpd=7.5; repMax=2}
    if d>=3 {teleT=9; cresSpd=8.5}
    if od {teleT=8; windT=2; cresSpd=9; repMax=3}
  }
  else if currentAttack=2
  {
    throwN=1; starSpd=6
    if d>=2 {throwN=2; starSpd=6.5}
    if d>=3 {starSpd=7}
    if od {throwN=3}
  }
  else if currentAttack=3
  {
    readyT=9; rushSpd=13
    if d>=2 {readyT=7; repMax=2}
    if d>=3 {readyT=6; rushSpd=14}
    if od {readyT=5; rushSpd=15; repMax=3}
  }
  else if currentAttack=4
  {
    crouchT=6; diveTeleT=6; diveSpd=11; cresSpd2=5.5
    if d>=2 {crouchT=5; diveTeleT=5; diveSpd=12; cresSpd2=6.5}
    if d>=3 {crouchT=4; diveTeleT=4; diveSpd=13; cresSpd2=7.5}
    if od {cresSpd2=8}
  }
  else if currentAttack=5
  {
    orbSpd=1.8; orbLife=100; orbN=8; orbBurst=3.5
    if d>=2 {orbSpd=2; orbLife=115; orbN=10; orbBurst=4}
    if d>=3 {orbSpd=2.3; orbLife=125; orbN=12; orbBurst=4.5}
    if od {orbSpd=2.4}
  }
  else if currentAttack=9
  {
    crossTeleT=16; cloneSpd=12; cloneTeleT=10; cloneDive=13; colTrack=14; lockHold=6
    if d>=2 {crossTeleT=14; cloneSpd=13; cloneTeleT=9; cloneDive=14; colTrack=12; lockHold=5}
    if d>=3 {crossTeleT=12; cloneSpd=14; cloneTeleT=8; cloneDive=15; colTrack=10; lockHold=4}
  }
}
else //==================== X ====================
{
  if currentAttack=1
  {
    runSpd=4.5; runGap=6; runShots=5; lemonSpd=8.5
    if d>=2 {runSpd=5; runGap=5; runShots=6; lemonSpd=9}
    if d>=3 {runSpd=5.5; runGap=4; runShots=7; lemonSpd=9.5}
  }
  else if currentAttack=2
  {
    chargeT1=20; semiSpd=8; chargeT2=14; fullSpd=10
    if d>=2 {chargeT1=18; semiSpd=8.5; chargeT2=12; fullSpd=10.5}
    if d>=3 {chargeT1=14; semiSpd=9; chargeT2=10; fullSpd=11}
    if od {chargeT1=12; chargeT2=9}
  }
  else if currentAttack=3
  {
    clingT=6; kickMax=2; ricSpd=5; ricBounce=1
    if d>=2 {clingT=5; kickMax=3; ricSpd=5.5; ricBounce=2}
    if d>=3 {clingT=4; ricSpd=6}
    if od {kickMax=4}
  }
  else if currentAttack=4
  {
    novaAim=14; novaLock=6; novaSpd=15; novaMax=1
    if d>=2 {novaAim=12; novaLock=5; novaSpd=16}
    if d>=3 {novaAim=10; novaLock=4; novaSpd=17; novaMax=2}
  }
  else if currentAttack=5
  {
    hopT=6; stingSpread=25; stingDelay=6; hopMax=1; stingSpd=7
    if d>=2 {hopT=5; stingSpread=22; stingDelay=5; hopMax=2; stingSpd=7.5}
    if d>=3 {hopT=4; stingSpread=20; stingDelay=4; stingSpd=8}
  }
  else if currentAttack=9
  {
    gigaGap=28; gigaWarn=12; gigaSpd=11; gigaRest=24
    if d>=2 {gigaWarn=11}
    if d>=3 {gigaWarn=10}
    if od {gigaGap=26; gigaRest=18}
  }
}