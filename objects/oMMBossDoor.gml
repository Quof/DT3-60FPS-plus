#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_yscale=2
bPlayerTouch=0
doorProg=0
doorOffsetY=0
bLocked=1
lockAngle=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bPlayerTouch=1
{
  doorProg+=1
  if doorProg>=1 and doorProg<=18
  {
    if doorProg=1 {playSound(global.snd_MMDoorOpen,0,1,1)}
    lockAngle+=20
  }
  else if doorProg=19 {bLocked=0}
  else if doorProg>=31 and doorProg<=36 {doorOffsetY+=4}
  else if doorProg>=51 and doorProg<=199
  {
    oPlayer1.x+=2
    if oPlayer1.x>=room_width+24 {oPlayer1.visible=0; doorProg=200}
  }
  else if doorProg=211 {playSound(global.snd_MMDoorClose,0,1,1)}
  else if doorProg>=221 and doorProg<=226 {doorOffsetY-=4}
  else if doorProg=227 {bLocked=1}
  else if doorProg=228 {stopAllMusic()}
  else if doorProg>=241 and doorProg<=258 {lockAngle+=20}
  else if doorProg=290
  {
    global.recAreaTrans+=1
    global.newMapX=newMapX
    global.newMapY=newMapY
    global.gamePaused=false
    writeToPlayerGlobals()
    if global.bNightmareMode=0 {global.difficulty=2}
    if global.rmDeaths>=7 {global.chaoRecognition=1}
    global.rmDeaths=0; global.hitsTaken=0
    transition_steps=10
    transition_kind=21
    room_goto(toRoom)
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bPlayerTouch=0
{
  global.gamePaused=true
  if global.activeCharacter=0 {oPlayer1.sprite_index=sJerryJump; oPlayer1.image_speed=0.2}
  else if global.activeCharacter=1 {oPlayer1.sprite_index=sClaireJump; oPlayer1.image_speed=0.2}
  bPlayerTouch=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sMM_BossDoor,0,x+8,y+24-doorOffsetY,1,1,0,c_white,1)
draw_sprite_ext(sMM_BossDoor,0,x+8,y+24+doorOffsetY,1,-1,0,c_white,1)
if bLocked=1 {draw_sprite_ext(sMM_BossLock,0,x+8,y+24,1,1,lockAngle,c_white,1)}
