#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
image_speed=0.5
efLightDelay=irandom(29)
bCanUse=1
gateH_HeartEffect=irandom_range(1,20)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rGame6_Gate and global.gameProgress<=3530
{
  talker="Claire"
  stringToShow="I'm not leaving till we can get Jerry back with us."
  boxSize=1; fadingTime=90
  bCanUse=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02*gDeltaTime

efLightDelay+=1*gDeltaTime
if efLightDelay=30
{
  var tEffect,tTempAmt,tTempDir,tTempDist;
  tTempAmt=irandom_range(1,2)
  for(i=0;i<tTempAmt;i+=1)
  {
    tTempDir=random(360)
    tTempDist=random(12)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMXTTLight
    tEffect.x=x+32+lengthdir_x(16+tTempDist,tTempDir); tEffect.y=y+30+lengthdir_y(16+tTempDist,tTempDir)
    tEffect.depth=101; tEffect.image_angle=tTempDir; tEffect.image_xscale=2.25
    tEffect.image_speed=0.5; tEffect.image_blend=image_blend; tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
  efLightDelay=irandom(29)
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Access Gate script.
This will move the player to another room.
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if bCanUse=1
  {
    if cutsceneCheck=global.gameProgress
    {
      playSound(global.snd_NewGateTransport,0,1,1)
      global.gameProgress+=10
    }
    else
    {
      global.recAreaTrans+=1
      global.rmDeaths=0
      global.newMapX=newMapX
      global.newMapY=newMapY
      writeToPlayerGlobals()
      if global.bNightmareMode=0 {global.difficulty=2}
      if global.rmDeaths>=7 {global.chaoRecognition=1}
      global.rmDeaths=0; global.hitsTaken=0
      transition_steps=20
      transition_kind=21
      if variable_local_exists("newStep") {transition_steps=newStep}
      if variable_local_exists("newTrans") {transition_kind=newTrans}
      room_goto(toRoom)
    }
  }
  else
  {
    msgCreate(0,0,talker,stringToShow,0,1,oMessagePerson,0)
    newMessage.fadingTime=fadingTime
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_wave(sprite_index,image_index,x,y,1,12,2,phase)

if image_blend!=c_white
{
  tDist=point_distance(x+32,y+32,oPlayer1.x,oPlayer1.y-26)
  if tDist<32
  {
    draw_set_alpha(1)
    var tRecBX,tRecBY,tRecColMain,tRecColShadow;
    tRecColMain=make_color_rgb(240,240,240)
    tRecColShadow=make_color_rgb(0,120,72)
    draw_set_color(tRecColMain)
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_left)
    textDropShadow("Recommended Hearts",x-25,y-6,tRecColMain,tRecColShadow,1)
    tRecBX=122; tRecBY=26
    draw_rectangle(x-30,y+5,x-30+tRecBX,y+5+tRecBY,1)

    if heartRec=100 //Gate H
    {
      if oGame.time mod 2=0 {gateH_HeartEffect=irandom_range(1,20)}
      for(i=0;i<gateH_HeartEffect;i+=1)
      {
        if i<10
          draw_sprite(sHUD_Heart,4,x-28+(i*12),y+7)
        else
          draw_sprite(sHUD_Heart,4,x-28+(i*12)-120,y+19)
      }
    }
    else //Gate A - G
    {
      for(i=0;i<heartRec;i+=1)
      {
        if i<10
          draw_sprite(sHUD_Heart,4,x-28+(i*12),y+7)
        else
          draw_sprite(sHUD_Heart,4,x-28+(i*12)-120,y+19)
      }
    }
  }
}
