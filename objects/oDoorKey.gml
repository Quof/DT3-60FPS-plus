#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-6,-9,6,9)
indexCheck="0"
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.doorKey,objectNum)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.3
  moveTo(xVel,yVel)

  if isCollisionSolid()
    y-=2
  if indexCheck="1"
    instance_destroy()
  if y>room_height+24
    instance_destroy()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Key script
objectNum relates to which flag to write to
*/
awardAwesome(200)
playSound(global.snd_SkillCapsule,0,1,1)
global.pKeys+=1

var tNewString;
tNewString=string_delete(global.doorKey,objectNum,1)
tNewString=string_insert("1",tNewString,objectNum)
global.doorKey=tNewString
indexCheck="1"
instance_destroy()
