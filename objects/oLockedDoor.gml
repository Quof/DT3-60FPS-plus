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
indexCheck=string_char_at(global.lockedDoor,objectNum)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Locked Door script
objectNum relates to which flag to write to
*/

if distance_to_object(oPlayer1)<12
{
  if global.pKeys>0
  {
    awardAwesome(200)
    global.pKeys-=1
    playSound(global.snd_DoorUnlock,0,1,1)

    var tNewString;
    tNewString=string_delete(global.lockedDoor,objectNum,1)
    tNewString=string_insert("1",tNewString,objectNum)
    global.lockedDoor=tNewString
    indexCheck="1"
  }
}
if indexCheck="1"
  instance_destroy()
