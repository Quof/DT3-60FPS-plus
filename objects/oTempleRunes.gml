#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck="0"
image_speed=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.gameDCS_Prog,objectNum)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if indexCheck="5" or indexCheck="9" {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Temple Rune script
objectNum relates to which flag to write to
*/
awardAwesome(200)
playSound(global.snd_SkillCapsule,0,1,1)

var tNewString;
tNewString=string_delete(global.gameDCS_Prog,objectNum,1)
if objectNum=4 {tNewString=string_insert("5",tNewString,objectNum)}
else {tNewString=string_insert("9",tNewString,objectNum)}
global.gameDCS_Prog=tNewString
instance_destroy()
