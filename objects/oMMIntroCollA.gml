#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
moveSeq=0
detectDist=72
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
image_xscale=4
image_yscale=ySize+2
y-=(16*ySize)+(moveTime*8)

for(i=0;i<4;i+=1)
{
  newSpike=instance_create(x,y,oStaticSpike)
  newSpike.sprite_index=sMMSpikeA
  newSpike.depth=depth
  newSpike.idFollow=id
  newSpike.xFollow=i*16
  newSpike.yFollow=32+(ySize*16)
}

if variable_local_exists("newDetect") {detectDist=newDetect}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if moveSeq=0
  {
    if point_distance(oPlayer1.x,0,x+32,0)<=detectDist
    {
      yVel=8
      moveSeq=1
    }
  }
  else if moveSeq=1
  {
    moveTime-=1
    if moveTime=0
    {
      yVel=0
      moveSeq=2
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<ySize;i+=1)
{
  draw_sprite_part(sMMIntroCollA,0,0,0,64,16,x,y+(i*16))
}
draw_sprite(sMMIntroCollA,0,x,y+(ySize*16))
