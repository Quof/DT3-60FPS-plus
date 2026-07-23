#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type - 0: top-left === 1: top-right
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
      var xAdj,yAdj,shotDir,bBill;
      if oPlayer1.y-26<y //Player below
      {
        if type=0
        {
          xAdj=-8
          shotDir=135
        }
        else
        {
          xAdj=8
          shotDir=45
        }
        yAdj=-8
      }
      else //Player above
      {
        if type=0
        {
          xAdj=8
          shotDir=315
        }
        else
        {
          xAdj=-8
          shotDir=225
        }
        yAdj=8
      }
      bBill=instance_create(x+xAdj,y+yAdj,oM3Shot)
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
  draw_sprite_ext(sMMcharging,warnFrm,x,y,1,1,0,c_white,1)
}
