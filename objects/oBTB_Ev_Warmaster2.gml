#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II's room (rBT_Warmaster2): the intro the first time in, the arena's lights (oWM2_EnvGlow reads them),
//screen shakes and flashes, the music fade before his X model, and the way out once he's beaten. On a retry
//(global.bossTrack=1) the fight starts straight away.
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=0
flash=0           //white over the whole screen, fading
shake=0           //screen shake in pixels, settling
lightMode=4       //the arena lights' colour: 0 white, 1 purple (Phantom), 2 blue (X), 3 all three in turn (Overdrive), 4 green (Saber)
lightLevel=0      //their brightness (0-1), easing toward lightTarget
lightTarget=1
lightCol=c_white
lightT=0
musFade=0         //1: the music fades out
musVol=0
musFile=0         //the music's handle (SuperSound handles are strings, so musGot says whether it's been got)
musGot=0
colP=make_color_rgb(190,80,255)
colX=make_color_rgb(70,170,255)
colZ=make_color_rgb(60,230,140)
//the room is one screen, so the view doesn't follow anyone (the shakes move it)
view_object[0]=noone
view_xview[0]=0; view_yview[0]=0

boss=instance_create(336,304,oWarmaster2)
if global.bossTrack=0 //the first time in: the intro
{
  global.gamePaused=true
  fadeAlpha=1
  lightTarget=0
  boss.visible=0
}
else //a retry
{
  boss.activateBoss=1
  lightLevel=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tempMplay,tF,i,tP;
//-------------------- Lights --------------------
lightT+=1*gDeltaTime
if lightLevel<lightTarget {lightLevel=min(lightTarget,lightLevel+0.02*gDeltaTime)}
else if lightLevel>lightTarget {lightLevel=max(lightTarget,lightLevel-0.02*gDeltaTime)}
if lightMode=1 {lightCol=colP}
else if lightMode=2 {lightCol=colX}
else if lightMode=4 {lightCol=colZ}
else if lightMode=3 //Overdrive: green, purple, blue, round and round
{
  tP=lightT*0.04
  tP-=3*floor(tP/3)
  if tP<1 {lightCol=scrWM2_Mix(colZ,colP,tP)}
  else if tP<2 {lightCol=scrWM2_Mix(colP,colX,tP-1)}
  else {lightCol=scrWM2_Mix(colX,colZ,tP-2)}
}
else {lightCol=c_white}
//the backdrop dims with the lights and takes on a little of their colour
background_blend[0]=scrWM2_Mix(make_color_rgb(70,70,90),scrWM2_Mix(c_white,lightCol,0.35),0.25+0.75*lightLevel)

//-------------------- Music fade (before his X model's theme) --------------------
if musFade=1
{
  if musGot=0
  {
    musGot=1
    musFile=findMusic(829)
    musVol=scrMusicVolume(global.currentMusicGain)
  }
  musVol-=250*gDeltaTime
  SS_SetSoundVol(musFile,max(0,musVol))
  if musVol<=1000 {musFade=2; tempMplay=findMusic(0)}
}

if room=rBT_Warmaster2
{
  if global.bossTrack=0
  {
    if sceneProgress=0 //fades in on a dark arena
    {
      sceneDelay+=1*gDeltaTime
      if sceneDelay>=20
      {
        fadeAlpha-=0.025*gDeltaTime
        if fadeAlpha<=0 {fadeAlpha=0; sceneDelay=0; sceneProgress=1}
      }
    }
    else if sceneProgress=1
    {
      tP=sceneDelay
      sceneDelay+=1*gDeltaTime
      if tP<20 and sceneDelay>=20 //the arena hums awake
      {
        lightTarget=0.3
        playSound(global.snd_LampOn,0,0.9,1)
      }
      else if tP<40 and sceneDelay>=40
      {
        msgCreate(0,0,"Warmaster","So. You found this door too.",6,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if tP<130 and sceneDelay>=130 //he beams in
      {
        tF=scrWM2_Fx(boss.x,boss.y,sWM2_Beam,0.6,colZ,1)
        playSound(global.snd_MMBeamDown,0,1,1)
      }
      else if tP<140 and sceneDelay>=140
      {
        boss.visible=1
        with boss {scrWM2_Pose(sWM2Z_Land,0)}
        for(i=0;i<3;i+=1)
        {
          tF=scrWM2_Fx(boss.x,boss.y-28,sWM2_RingHit,0.4,colZ,1)
          tF.image_xscale=1.2+i*0.6; tF.image_yscale=1.2+i*0.6; tF.grow=0.06
        }
      }
      else if tP<148 and sceneDelay>=148 {with boss {scrWM2_Anim(sWM2Z_Idle,0.2)}}
      else if tP<160 and sceneDelay>=160
      {
        msgCreate(0,0,"Warmaster","I rebuilt myself out of every model you broke. Three of them, this time. Let's see how you do.",6,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if tP<300 and sceneDelay>=300 //lights up, saber out
      {
        lightTarget=1
        flash=0.6
        with boss {scrWM2_Anim(sWM2Z_ChargeSaber,0.4); aura=4}
        tempMplay=findMusic(829)
        playMusic(tempMplay,0,0)
      }
      else if tP<312 and sceneDelay>=312
      {
        tF=instance_create(240,120,oWM2_Titlecard)
      }
      else if tP<330 and sceneDelay>=330 {with boss {scrWM2_Anim(sWM2Z_Idle,0.2); aura=0}}
      else if sceneDelay>=420 {sceneDelay=0; sceneProgress=2}
    }
    else if sceneProgress=2 //the fight
    {
      boss.visible=1
      boss.activateBoss=1
      global.currentBoss="Warmaster II"
      global.bossTrack=1
      storeStatus(0)
      global.gamePaused=false
      sceneDelay=0; sceneProgress=3
    }
  }
  if sceneProgress=50 //beaten: fades out and back to the hub, at his door
  {
    fadeColor=c_black
    fadeAlpha+=0.03*gDeltaTime
    if fadeAlpha>=1
    {
      fadeAlpha=1
      global.BTB_WM2Beat=1
      global.currentBoss=""; global.bossTrack=0
      global.gamePaused=false
      global.newMapX=1272; global.newMapY=448
      room_goto(rBT_HUB)
      sceneProgress=51
    }
  }
}

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //cutscene skip
{
  if !instance_exists(oPauseMenu) and global.bossTrack=0 and sceneProgress<2
  {
    with oMessagePerson {instance_destroy()}
    with oWM2_Titlecard {instance_destroy()}
    fadeAlpha=0
    lightTarget=1; lightLevel=1
    with boss {aura=0; scrWM2_Anim(sWM2Z_Idle,0.2)}
    tempMplay=findMusic(829)
    playMusic(tempMplay,0,0)
    sceneDelay=0; sceneProgress=2
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//screen shake: the view jumps around by up to `shake` pixels and settles
if shake>0
{
  view_xview[0]=round(random_range(-shake,shake))
  view_yview[0]=round(random_range(-shake,shake)*0.6)
  shake=max(0,shake-0.5*gDeltaTime)
}
else {view_xview[0]=0; view_yview[0]=0}
if flash>0 {flash=max(0,flash-0.06*gDeltaTime)}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
if flash>0
{
  draw_set_alpha(flash)
  draw_set_color(c_white)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
draw_set_alpha(1)
