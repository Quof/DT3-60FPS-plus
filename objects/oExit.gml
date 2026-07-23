#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
arrowX=x+8
arrowY=y-24
pointTime=0
init=0
arrowColor=0
animPlayerExit=0
drawType=0

if point_distance(x,y+24,global.newMapX,global.newMapY-26)<48 {lockFrm=5}
else {lockFrm=0}

if variable_local_exists("colorChange") {arrowColor=colorChange}
if variable_local_exists("newDraw") {drawType=newDraw}

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newArrowPosX") {arrowX+=newArrowPosX}
if variable_local_exists("newArrowPosY") {arrowY+=newArrowPosY}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if animPlayerExit>0 //Going down pipe
{
  animPlayerExit+=1
  oPlayer1.bCanTakeDamage=true
  oPlayer1.x=x+(sprite_width/2)
  oPlayer1.y+=2
  if animPlayerExit=30
  {
    global.gamePaused=false
    global.recAreaTrans+=1
    global.newMapX=newMapX; global.newMapY=newMapY
    writeToPlayerGlobals()
    if global.bNightmareMode=0 {global.difficulty=2}
    if global.rmDeaths>=7 {global.chaoRecognition=1}
    global.rmDeaths=0; global.hitsTaken=0
    SS_StopSound(global.msc_Starman)
    transition_steps=10
    transition_kind=21
    if variable_local_exists("newStep") {transition_steps=newStep}
    if variable_local_exists("newTrans") {transition_kind=newTrans}
    room_goto_fixed(toRoom)
  }
}

if sprite_index=sPillarOfLight
{
  if oGame.time mod 2=0
  {
    if image_alpha=0.75 {image_alpha=0.5}
    else {image_alpha=0.75}
  }
}

if sprite_index=sWS_MetalDoor
{
  if point_distance(x,y+24,oPlayer1.x,oPlayer1.y-26)<96
  {
    if lockFrm<5 {lockFrm+=0.5}
  }
  else
  {
    if lockFrm>0 {lockFrm-=0.5}
  }
}

if drawType=1 //Extra gate early exit
{
  var tFFScl,tEffect;
  tFFScl=random(0.1)
  tEffect=instance_create(x+8+lengthdir_x(random(16),random(360)),y+16+lengthdir_y(random(16),random(360)),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.6
  tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl; tEffect.direction=random(360)
  tEffect.speed=random(0.1)+0.1; tEffect.friction=random(0.001)+0.001
  tEffect.fadeSpd=0.01; tEffect.image_blend=image_blend
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Exit script.
This will move the player to another room.
exitType relates to whether the player has to press a key to activate the event. (Set in creation code.)
0: Player must press up. Use for doors.
1: Player must walk into the exit.
2: Player must press down. Use for pipes.
*/
if exitType=0 //Press Up
{
  if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
  {
    if room=rMain_45 and global.gameProgress=2600 //Barrens - Twin Rocks puzzle
    {
      if global.tempAction[0]=0 and desertDir=1 {global.tempAction[0]+=1}
      else if global.tempAction[0]=1 and desertDir=1 {global.tempAction[0]+=1}
      else if global.tempAction[0]=2 and desertDir=2 {global.tempAction[0]+=1}
      else if global.tempAction[0]=3 and desertDir=2 {global.tempAction[0]+=1}
      else if global.tempAction[0]=4 and desertDir=3 {global.tempAction[0]+=1}
      else if global.tempAction[0]=5 and desertDir=4 {global.tempAction[0]+=1}
      else if global.tempAction[0]=6 and desertDir=3 {global.tempAction[0]+=1}
      else if global.tempAction[0]=7 and desertDir=4
      {
        newMapX=3280; newMapY=288
        toRoom=rMain_46
      }
      else
      {
        global.tempAction[0]=0
        if desertDir=1 {global.tempAction[0]+=1}
      }
    }

    global.wpWaterLEntry=global.wpWaterLevel
    global.recAreaTrans+=1
    global.newMapX=newMapX; global.newMapY=newMapY
    global.gamePaused=false
    writeToPlayerGlobals()
    if global.bNightmareMode=0 {global.difficulty=2}
    if global.rmDeaths>=5 {global.chaoRecognition=1}
    global.rmDeaths=0; global.hitsTaken=0
    SS_StopSound(global.msc_Starman)
    transition_steps=10
    transition_kind=21
    if variable_local_exists("newStep") {transition_steps=newStep}
    if variable_local_exists("newTrans") {transition_kind=newTrans}
    room_goto_fixed(toRoom)
  }
}
else if exitType=1 //No key (Player Touch)
{
  global.wpWaterLEntry=global.wpWaterLevel
  global.recAreaTrans+=1
  global.newMapX=newMapX; global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  if toRoom=rLink2_Overworld or toRoom=rLink2_Overworld2 {playSound(global.snd_ZeldaToMap,0,1,1)}
  if global.bNightmareMode=0 {global.difficulty=2}
  if global.rmDeaths>=5 {global.chaoRecognition=1}
  global.rmDeaths=0; global.hitsTaken=0
  SS_StopSound(global.msc_Starman)
  transition_steps=10
  transition_kind=21
  if variable_local_exists("newStep") {transition_steps=newStep}
  if variable_local_exists("newTrans") {transition_kind=newTrans}
  room_goto_fixed(toRoom)
}
else if exitType=2 //Press Down
{
  if oKeyCodes.kCodePressed[4]=1 and global.gamePaused=false
  {
    global.gamePaused=true
    playSound(global.snd_MarioPipe,0,1,1)
    if global.activeCharacter=0 oPlayer1.sprite_index=sJerryIdle
    else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireIdle
    oPlayer1.image_speed=0.1
    oPlayer1.depth=1100000
    oPlayer1.bCanTakeDamage=false
    oPlayer1.bCanTakeHit=false
    animPlayerExit=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowArrow=true
{
  pointTime+=1
  if pointTime=20 {arrowY+=1}
  else if pointTime=40
  {
    arrowY-=1
    pointTime=0
  }
  draw_sprite(sExitArrow,arrowColor,arrowX,arrowY)
}

if sprite_index=sKirbyDoorway
{
  draw_sprite(sprite_index,image_index,x,y)
  if init=0
  {
    starFrame=0
    starTime=0
    for (i=0;i<=3;i+=1)
    {
      starY[i]=(y-12)+(i*12)
    }
    init=1
  }
  starTime+=1
  if starTime=5 {starFrame=1}
  else if starTime=10 {starFrame=2}
  else if starTime=15 {starFrame=3}
  else if starTime=20 {starFrame=0; starTime=0}
  for (i=0;i<=3;i+=1)
  {
    draw_sprite(sKirbyDoorStarSmall,starFrame,x+20,starY[i])
    draw_sprite(sKirbyDoorStarSmall,starFrame,x-4,starY[i])
    starY[i]+=2
    if starY[i]>=y+34 {starY[i]=y-12}
  }
  draw_sprite(sKirbyDoorStarBig,starFrame,x+8,y-12)
}
else if sprite_index=sExit {image_alpha=0}
else if sprite_index=sWarpGateStand
{
  draw_sprite_ext(sWarpGatePortal,image_index,x,y-35,image_xscale,image_yscale,oGame.time*10,image_blend,0.33)
  draw_sprite_ext(sWarpGatePortal,image_index,x,y-35,image_xscale,image_yscale,-oGame.time*8,image_blend,0.33)
  draw_sprite(sprite_index,image_index,x,y)
}
else if sprite_index=sWS_MetalDoor
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sWS_DoorLock,lockFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
else {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
