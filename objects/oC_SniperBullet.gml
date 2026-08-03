#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Bullet behavior
0:  [Start] Bullet is shot straight ahead without line of sight to player.
1:  [>>>>>] Bullet has found vertical line of sight with player. (Will find horizontal next)
2:  [Start] Bullet is shot with line of sight to player. (Will not use vertical/horizontal tracking behavior)
5:  [>>>>>] Bullet has bounced off wall at least once.
10: [>>>>>] Bullet has gone through at least 2 tracks or bounces.
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitWall=0
breakFix=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if seekProg=0 //First seek
  {
    if point_distance(x,0,oPlayer1.x,0)<bulletSpeed*1.25
    {
      if !collision_line(x,y,x,returnPlayerYCenter(),oSolid,1,1)
      {
        if y>returnPlayerYCenter() {_direction=90}
        else {_direction=270}
        bulletSpeed+=1
        seekProg=1
      }
    }
  }
  else if seekProg=1 //Second seek
  {
    _speed=bulletSpeed
    image_angle=_direction

    if point_distance(0,y,0,returnPlayerYCenter())<bulletSpeed*1.25
    {
      if !collision_line(x,y,oPlayer1.x,y,oSolid,1,1)
      {
        if x>oPlayer1.x {_direction=180}
        else {_direction=0}
        bulletSpeed+=1
        seekProg=10
      }
    }
  }

  _speed=bulletSpeed
  image_angle=_direction

  if breakFix=0
  {
    if isCollisionTop(1)
      hitWall=1
    if isCollisionBottom(1)
      hitWall=2
    if isCollisionLeft(1)
      hitWall=3
    if isCollisionRight(1)
      hitWall=4
  }
  else {breakFix-=1}

  if hitWall>=1
  {
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusCannonHit; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if seekProg<=9
    {
      _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      hitWall=0
      breakFix=1
      bulletSpeed+=1
      if seekProg=0 or seekProg=2 {seekProg=5}
      else {seekProg=10}
    }
    else {instance_destroy()}
  }
}
else {_speed=0}

correctSpeedDirection(self)

#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
