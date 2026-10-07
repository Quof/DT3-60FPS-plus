#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if zoneColor=1
//  image_blend=c_red
//else if zoneColor=2
//  image_blend=c_blue
//else if zoneColor=3
//  image_blend=c_green
//else if zoneColor=4
//  image_blend=c_yellow
//color zone change: the colors are an option now (Options > Graphics > Color Zone Colors; red, blue, green, yellow by default)
if zoneColor>=1 and zoneColor<=4 {image_blend=global.czColor[zoneColor]}
flashTime=0
innerAlpha=0.5
sprite_index=sScaledCollision
moveTime=0
if !variable_local_exists("_direction") {_direction=0}
if !variable_local_exists("_speed") {_speed=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x,y,x+image_xscale,y+image_yscale,oPlayer1,0,1)
  {
    if instance_exists(oColorIndControl)
    {
      oColorIndControl.bColorActive[zoneColor-1]=1
      if zoneColor=oColorIndControl.currentColor
        oColorIndControl.bWillDamagePlayer=2
    }

    if flashTime=0
    {
      if innerAlpha=0.5
        innerAlpha=0.6
      else
        innerAlpha=0.5
      flashTime=3
    }
    else
      flashTime-=1*gDeltaTime
  }
  else
  {
    flashTime=0
    innerAlpha=0.5
  }

  if moveSpd>0
  {
    _speed=moveSpd
    if gDeltaDoTicks != 0 //on 30fps ticks, like the moving platforms these zones travel with
    {
      moveTime+=1
      if moveTime>=moveDelay
      {
        moveTime=0
        _direction+=180
      }
    }
  }
}
else {_speed=0}

if gDeltaTime==1 {correctSpeedDirection(self)}
else if global.gamePaused=false
{
  //above 30fps, move in exactly the same per-tick pattern as moving solids (see gameStepEvent),
  //so zones that ride along with moving platforms stay locked to them instead of drifting by sub-pixels
  if !variable_local_exists("zcFrames") {zcLeftX=0; zcLeftY=0; zcFrames=0}
  if gDeltaDoTicks != 0
  {
    zcLeftX=cos(degtorad(_direction))*_speed
    zcLeftY=-sin(degtorad(_direction))*_speed
    if approximatelyZero(zcLeftX) {zcLeftX=0}
    if approximatelyZero(zcLeftY) {zcLeftY=0}
    zcFrames=round(1/gDeltaTime)
  }
  if zcFrames>0
  {
    var tStepX,tStepY;
    tStepX=sign(zcLeftX)*min(abs(zcLeftX),ceil(abs(zcLeftX)/zcFrames))
    tStepY=sign(zcLeftY)*min(abs(zcLeftY),ceil(abs(zcLeftY)/zcFrames))
    x+=tStepX
    y+=tStepY
    zcLeftX-=tStepX
    zcLeftY-=tStepY
    zcFrames-=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,240)=1
{
  if zoneColor>=1 and zoneColor<=4 {image_blend=global.czColor[zoneColor]} //color zone change (added): follows the option right away (it can be changed from the pause menu)
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,1)
}
