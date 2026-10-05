#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.7
image_blend=c_blue
alarm[0]=1
_speed=0
_direction=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alertRange=(128*image_xscale)*0.9
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !collision_line(x,y,oPlayer1.x,returnPlayerYCenter(),oSolid,1,1) //tColCheck=1 //Player spotted
{
  if ownerID.alertMode<3
  {
    if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<=alertRange
    {
      playSound(global.snd_Alert,0,1,1)
      oSeekerAlertDoor.sprite_index=sInvisibleSolidMask
      global.recSpottedSeeker+=1
      ownerID.alertNotice=1
      ownerID.alertNScale=0
      ownerID.alertMode=3
      ownerID.alertTime=135
      //ownerID.speed=0
      //ownerID.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      ownerID._speed=0 //60fps change: the seeker moves with _speed now, so "speed=0" no longer stopped it before the chase started
      ownerID._direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()); ownerID.direction=ownerID._direction //60fps change: the seeker faces with _direction now (direction too, in case it is already on a path)
    }
    else
    {
      if ownerID.alertMode=0
      {
        ownerID.movePause=10
        ownerID.alertNotice=1
        ownerID.alertNScale=0
        ownerID.alertMode=1
        //ownerID.speed=0
        ownerID._speed=0 //60fps change: the seeker moves with _speed now, so "speed=0" no longer stopped it during the warning pause
        ownerID.pointX=oPlayer1.x
        ownerID.pointY=returnPlayerYCenter()
      }
    }
  }
  else
  {
    if ownerID.alertTime<120 {ownerID.alertTime=120}
  }
}
