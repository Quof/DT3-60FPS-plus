#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_alpha=0.33
bJumpedOut=0
veloAdd=0
animTop=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animTop-=1
if animTop=0 {animTop=16}

if bJumpedOut=1
{
  x+=12
  veloAdd+=1
  if veloAdd<8 {oPlayer1.xVel=10}

  if x>=room_width+32
  {
    playSound(global.snd_BombExplode,0,0.95,1)
    tEffect=instance_create(x,y-8,oEffect)
    tEffect.sprite_index=sBombExplosion; tEffect.image_alpha=0.75
    tEffect.image_xscale=2; tEffect.image_yscale=2
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.attackState=oPlayer1.ACT_IN_BIKE and bJumpedOut=0
{
  with oPlayer1
  {
    setCollisionBounds(-8,-40,8,-1)
    attackState=0
    yVel=-8; yAcc=-8
    maxSlope=4; maxDownSlope=8
  }
  oBikeViewFollow.viewProg=1
  x=oPlayer1.x; y=oPlayer1.y
  image_yscale=1
  sprite_index=sJerryBike
  bJumpedOut=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bJumpedOut=0
{
  for(i=0;i<image_yscale*2;i+=1)
  {
    draw_sprite_part_ext(sprite_index,0,0,animTop,16,16,x,y+(i*16),1,1,image_blend,image_alpha)
  }
}
else if bJumpedOut=1
{
  draw_sprite(sJerryBike,0,x,y)
}
