#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck="0"
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.fullHeartContainer,objectNum)

if indexCheck="1"
  instance_destroy()
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Pickup script.
objectNum relates to which global flag to write to.
0 = has not been obtained.
1 = has been obtained.
*/
playSound(global.snd_HeartPiece,0,1,1)

msgCreate(170,100,"","Your Max Heart Capacity increased by 1!",6,1,oMessagePerson,0)
newMessage.fadingTime=70
awardAwesome(10000)
global.pMaxLife+=4
global.pLife=global.pMaxLife
oPlayer1.maxLife+=4
oPlayer1.life=oPlayer1.maxLife

var tNewString;
tNewString=string_delete(global.fullHeartContainer,objectNum,1)
tNewString=string_insert("1",tNewString,objectNum)
global.fullHeartContainer=tNewString
instance_destroy()
