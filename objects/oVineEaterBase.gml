#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: maxChain,maxBend,seekSpd,bFollow
event_inherited()
bActive=1
bCanTakeDamage=false
hoverAlpha=-1
bSetParts=0

//Enemy base statistics
eName="Vine Eater"
eLevel=34
atkPower=9

maxSwing=50
dir=0
e=90
g=0
destroyCheck=0

if global.gameProgress=4940 {instance_destroy()}
else {alarm[0]=1}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=1;i<=maxChain;i+=1)
{
  chain[i]=instance_create(x,y+4+i*8,oVineEaterMid)
}
ball=instance_create(x,y+4+i*8,oVineEaterMain)
ball.ownerID=id

bSetParts=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and bSetParts=1
{
  followInstance()
  for(i=1;i<=maxChain;i+=1)
  {
    chain[i].x=x+lengthdir_x(4+i*8,-90+dir+i*g)
    chain[i].y=y+lengthdir_y(4+i*8,-90+dir+i*g)
  }
  ball.x=x+lengthdir_x(4+i*8,-90+dir+i*g)
  ball.y=y+lengthdir_y(4+i*8,-90+dir+i*g)

  if ball.bActive=1 //Bend toward player
  {
    distToPlayer=point_distance(x,0,oPlayer1.x,0)
    if distToPlayer>seekSpd*1.25
    {
      if oPlayer1.x<ball.x //Player on left
      {
        if e<90+maxBend {e+=seekSpd}
      }
      else //Player on right
      {
        if e>90-maxBend {e-=seekSpd}
      }
    }
  }

  dir=lengthdir_x(maxSwing,e)
  g=lengthdir_x(1,e)

  if ball.myGrapplePoint.bGrappled=0
  {
    baseColor=c_white
    bCanDealDamage=true
    if image_blend=c_fuchsia {image_blend=baseColor}
    for(i=1;i<=maxChain;i+=1)
    {
      chain[i].baseColor=c_white
      chain[i].bCanDealDamage=true
      if chain[i].image_blend=c_fuchsia {chain[i].image_blend=baseColor}
    }
    ball.baseColor=c_white
    ball.bCanDealDamage=true
    if ball.image_blend=c_fuchsia {ball.image_blend=baseColor}
  }
  else
  {
    baseColor=c_fuchsia
    image_blend=baseColor
    bCanDealDamage=false
    for(i=1;i<=maxChain;i+=1)
    {
      chain[i].baseColor=c_fuchsia
      chain[i].image_blend=chain[i].baseColor
      chain[i].bCanDealDamage=false
    }
    ball.baseColor=c_fuchsia
    ball.image_blend=ball.baseColor
    ball.bCanDealDamage=false
  }

  if destroyCheck=1
  {
    var tEffect;
    for(i=1;i<=maxChain;i+=1)
    {
      with chain[i]
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
    }
    with ball
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
