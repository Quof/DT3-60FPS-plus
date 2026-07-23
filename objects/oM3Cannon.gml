#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: shotDir
bActive=0
detectDistX=264
detectDistY=196
inactiveDist=10000
shotTime=70
shotDelay=85
bReadyToFire=0
atkPower=12
warnFrm=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if findTargetX<=detectDistX
  {
    shotTime+=1
    if shotTime=shotDelay-10 {bReadyToFire=1}
    else if shotTime>=shotDelay
    {
      playSound(global.snd_MarioCannon,0,0.9,1)
      var bBill;
      bBill=instance_create(x+8,y+8,oM3Shot)
      bBill.sprite_index=sSFShotSmall; bBill.direction=shotDir
      bBill.atkPower=atkPower; bBill.bulletSpeed=4
      shotTime=0; bReadyToFire=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if shotTime>=shotDelay-10
{
  warnFrm+=1
  draw_sprite_ext(sMMcharging,warnFrm,x+8,y+8,1,1,0,c_white,1)
}
