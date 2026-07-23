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
  chain[i]=instance_create(x,y-4-i*8,spawnChainMid)
  chain[i].image_blend=image_blend
  if sprChangeMid!=0
    chain[i].sprite_index=sprChangeMid
}
ball=instance_create(x,y-4-i*8,spawnChainEnd)
ball.image_blend=image_blend
if sprChangeEnd!=0
  ball.sprite_index=sprChangeEnd

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
if variable_local_exists("midNoRotate")
  midNoRotate=1
if variable_local_exists("endNoRotate")
  endNoRotate=1
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
    chain[i].y=y+lengthdir_y(4-i*8,-90+dir+i*g)
    if midNoRotate=0
      chain[i].image_angle=dir*1.5
  }
  ball.x=x+lengthdir_x(4+i*8,-90+dir+i*g)
  ball.y=y+lengthdir_y(4-i*8,-90+dir+i*g)
  if endNoRotate=0
    ball.image_angle=dir*1.5

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
