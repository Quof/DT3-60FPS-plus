#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bActive=0
image_speed=0
detectDistX=264
detectDistY=196
inactiveDist=10000
shotTime=5
shotDelay=50
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
    if shotTime=round(shotDelay/2)-10
    {
      playSound(global.snd_MarioCannon,0,0.86,1)
      var shotDir,bBill;
      if image_index=0 {shotDir=0}
      else {shotDir=45}
      for(i=0;i<4;i+=1)
      {
        bBill=instance_create(x+16,y+16,oM3Shot)
        bBill.x=x+16+lengthdir_x(14,shotDir); bBill.y=y+16+lengthdir_y(14,shotDir)
        bBill.sprite_index=sSFShotSmall; bBill.direction=shotDir
        bBill.atkPower=atkPower; bBill.bulletSpeed=4
        shotDir+=90
      }
    }
    else if shotTime=shotDelay
    {
      if image_index=0 {image_index=0.5}
      else {image_index=0}
      shotTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_index=0 {draw_background_part(tileSF_A,128,144,32,32,x,y)}
else {draw_background_part(tileSF_A,160,144,32,32,x,y)}

if shotTime>=shotDelay-10
{
  warnFrm+=1
  draw_sprite_ext(sMMcharging,warnFrm,x+16,y+16,1,1,0,c_white,1)
}
