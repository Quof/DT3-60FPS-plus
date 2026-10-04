#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(-20,28,20,37)

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

yCenter=ystart+24
y+=24
prevX=0
shiftSeq=0
atkSpeed=10
atkProg=0
atkTime=0
atkDistX=48
detectDistY=256
prevY=0
hangTime=0
deathCheck=0

spikeTFol=instance_create(x-19,y+30,oScaledTrapZone)
spikeTFol.atkPowerN=8
spikeTFol.drawType=0
spikeTFol.image_xscale=37
spikeTFol.image_yscale=9
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  spikeTFol.x=x-20
  spikeTFol.y=y+28

  //the attack logic runs on 30fps ticks and checks this tick's finished position (mstLY), so it behaves exactly as at 30fps;
  //gameStepEvent spreads the movement across frames
  if gDeltaDoTicks = 0 {exit;}

  if atkProg=0 //Check if player is close
  {
    if findTargetX<atkDistX and mstLY<oPlayer1.y and findTargetY<(maxDrop+40)*1.2
    {
      yVel=atkSpeed
      atkProg+=1
    }
  }
  else if atkProg=1 //Falling
  {
    //Reach chain end
    var fallDist;
    fallDist=mstLY-ystart
    if fallDist>=maxDrop
    {
      yVel=0
      atkProg+=1
      exit;
    }
    //Hit player
    if prevY=mstLY
    {
      hangTime+=1
      if hangTime>=5
      {
        yVel=0
        atkProg+=1
        exit;
      }
      else hangTime=0
    }
    prevY=mstLY
    //Hit solid (checked at this tick's finished position)
    var tHitSolid,tRealY;
    tRealY=y; y=mstLY
    tHitSolid=isCollisionBottom(1)
    y=tRealY
    if tHitSolid
    {
      yVel=0
      atkProg+=1
      exit;
    }
  }
  else if atkProg=2 //Wait - Down
  {
    atkTime+=1
    if atkTime=20
    {
      yVel=-atkSpeed/3.5
      atkTime=0
      y-=1
      mstLY-=1
      atkProg+=1
    }
  }
  else if atkProg=3 //Return
  {
    if mstLY<=yCenter
    {
      prevY=0
      hangTime=0
      y=yCenter
      mstYLeft=0 //snapped into place, so drop any of this tick's movement that hasn't happened yet
      mstLY=yCenter
      yVel=0
      atkProg+=1
    }
  }
  else if atkProg=4 //Wait - Up
  {
    atkTime+=1
    if atkTime=5
    {
      atkTime=0
      prevY=0
      hangTime=0
      atkProg=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if y>ystart+3
  {
    var downDist;
    downDist=round((y-ystart)/4)
    for(i=0;i<downDist;i+=1)
    {
      draw_sprite(sPlatformChainA,0,x,y-(4*i))
    }
  }
  draw_sprite(sprite_index,0,x,y)
}
