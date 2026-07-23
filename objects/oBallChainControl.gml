#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnChainMid=oChainMid
spawnChainEnd=oChainEnd
if variable_local_exists("newMid")
  spawnChainMid=newMid
if variable_local_exists("newEnd")
  spawnChainEnd=newEnd

var sprChangeMid,sprChangeEnd;
sprChangeMid=0; sprChangeEnd=0
if variable_local_exists("newSpriteMid")
  sprChangeMid=newSpriteMid
if variable_local_exists("newSpriteEnd")
  sprChangeEnd=newSpriteEnd

for(i=1;i<=maxChain;i+=1)
{
  chain[i]=instance_create(x,y+4+i*8,spawnChainMid)
  chain[i].image_blend=image_blend
  if sprChangeMid!=0
    chain[i].sprite_index=sprChangeMid
  if spawnChainMid=oMarioSwingSpike
  {
    if myInc=0
    {
      chain[i].image_angle=irandom(360)
      chain[i].swingSpeed=random_range(-mySpeed,mySpeed)
    }
    else
    {
      chain[i].image_angle=myInc*i
      chain[i].swingSpeed=mySpeed
    }
  }
}
ball=instance_create(x,y+4+i*8,spawnChainEnd)
ball.image_blend=image_blend
if sprChangeEnd!=0
  ball.sprite_index=sprChangeEnd
if spawnChainEnd=oMarioSwingSpike
{
  ball.image_angle=myInc*i
  ball.swingSpeed=mySpeed
}
else if spawnChainEnd=oStrikeChainPoint {spawnChainEnd.depth=28}

dir=0
e=0
g=0
bFollow=false
if variable_local_exists("newE")
  e=newE
if variable_local_exists("idFollow")
  bFollow=true

midNoRotate=0
endNoRotate=0
if !variable_local_exists("midNoRotateN")
  midNoRotate=1
if !variable_local_exists("endNoRotateN")
  endNoRotate=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  followInstance()
  for(i=1;i<=maxChain;i+=1)
  {
    chain[i].x=x+lengthdir_x(4+i*8,-90+dir+i*g)
    chain[i].y=y+lengthdir_y(4+i*8,-90+dir+i*g)
    if midNoRotate=0
      chain[i].image_angle=dir*1.5
  }
  ball.x=x+lengthdir_x(4+i*8,-90+dir+i*g)
  ball.y=y+lengthdir_y(4+i*8,-90+dir+i*g)
  if endNoRotate=0
    ball.image_angle=(dir+(i*g))*1.5

  e+=swingSpeed
  dir=lengthdir_x(maxSwing,e)
  g=lengthdir_x(1,e)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sChainMid,0,x,y)
