#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: drawType
event_inherited()
sprite_index=sScaledCollision

//Enemy base statistics
bCanTakeDamage=false
bShowHealthBar=false
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("atkPowerN")
  atkPower=atkPowerN
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkPower=1000
{
  if oPlayer1.bCanTakeHit=true and oPlayer1.dashInvulnerabilityTime=0
    oPlayer1.life-=oPlayer1.maxLife
}
else
  event_inherited()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=1 //Gate 2 - Water Dungeon Barrier
{
  for(i=0;i<4;i+=1)
  {
    for(ii=0;ii<8;ii+=1)
    {
      draw_sprite(sZapBarrier,image_index,x+(i*16),y+(ii*16))
    }
  }
}
