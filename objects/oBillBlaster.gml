#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bDestroyOnDeactivate=false
detectDistX=240
detectDistY=208
inactiveDist=detectDistX*3
if global.location=91 {shotTime=90}
else {shotTime=60}
shotDelay=95
bVert=0
warnFrm=0
bActive=false
if variable_local_exists("newDDX")
  detectDistX=newDDX
if variable_local_exists("newDDY")
  detectDistY=newDDY
if variable_local_exists("vertical")
  bVert=vertical
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and findTargetX<=detectDistX and findTargetY<=detectDistY
  {
    makeEnemyActive(1)
    if bVert=0 //Horizontal shot
    {
      findTargetX=point_distance(oPlayer1.x,0,x,0)
      if findTargetX>=56
      {
        shotTime+=1*gDeltaTime
        if shotTime=shotDelay-10
        {
          var tEffect;
          for(i=0;i<2;i+=1)
          {
            tEffect=instance_create(x,y+8,oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.ySpd=-1-(i*0.5)
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
          }
        }
        if shotTime>=shotDelay
        {
          var tSndVol;
          if global.location=91 {tSndVol=0.9}
          else {tSndVol=1}
          playSound(global.snd_MarioCannon,0,tSndVol,1)
          var bBill,xOffset;
          if x>=oPlayer1.x {xOffset=-8}
          else {xOffset=8}
          bBill=instance_create(x+xOffset,y+8,oBulletBill)
          bBill.bActive=true
          bBill.bVert=bVert
          if xOffset<0
          {
            bBill.bulletSpeed=-7.5
            bBill.image_xscale=-1
          }
          else {bBill.bulletSpeed=7.5}
          shotTime=0
        }
      }
    }
    else //Vertical shot
    {
      findTargetY=point_distance(0,oPlayer1.y-26,0,y)
      if findTargetY>=56
      {
        shotTime+=1*gDeltaTime
        if shotTime=shotDelay-10
        {
          var tEffect;
          for(i=0;i<2;i+=1)
          {
            tEffect=instance_create(x,y+8,oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.ySpd=-1-(i*0.5)
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
          }
        }
        if shotTime>=shotDelay
        {
          playSound(global.snd_MarioCannon,0,1,1)
          var bBill,yOffset;
          if y>=oPlayer1.y {yOffset=-8}
          else {yOffset=8}
          bBill=instance_create(x,y+yOffset+8,oBulletBill)
          bBill.bActive=true
          bBill.bVert=bVert
          bBill.image_angle=90
          if yOffset<0 {bBill.bulletSpeed=-7.5}
          else
          {
            bBill.bulletSpeed=7.5
            bBill.image_xscale=-1
          }
          shotTime=0
        }
      }
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
  draw_sprite_ext(sMMcharging,warnFrm,x,y+8,1,1,0,c_white,1)
}
