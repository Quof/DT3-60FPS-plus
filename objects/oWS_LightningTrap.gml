#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

sprite_index=sWS_LightningTrap
image_speed=random(0.2)+0.2

//Enemy base statistics
atkPower=12
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false

waveTime=irandom(120)
ballTime=0
ballAngle=0
ballX=0
ballY=0
bWave=0

lightFlash=irandom(30)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bWave=0
{
  waveTime+=1
  if waveTime>=210
  {
    bWave=1
    ballX=x; ballY=y
    ballTime=image_xscale*4
    waveTime=irandom(120)
  }
}

lightFlash+=1
if lightFlash=60
{
  image_blend=c_yellow
}
else if lightFlash>=63
{
  image_blend=c_white
  lightFlash=irandom(30)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_angle=0
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x+(i*16),y,1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=90
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x,y-(i*16),1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=180
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x-(i*16),y,1,1,image_angle,image_blend,image_alpha)
  }
}
else if image_angle=270
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x,y+(i*16),1,1,image_angle,image_blend,image_alpha)
  }
}

if bWave=1
{
  if image_angle=0 {ballX+=4}
  else if image_angle=90 {ballY-=4}
  else if image_angle=180 {ballX-=4}
  else if image_angle=270 {ballY+=4}
  ballAngle+=21
  draw_sprite_ext(sWS_LightBall,image_index,ballX,ballY,0.66,0.66,ballAngle,image_blend,image_alpha)
  ballTime-=1
  if ballTime<=0 {bWave=0}
}
