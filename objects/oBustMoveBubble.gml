#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
decay=150
bounceAmt=1
alarm[0]=1
_direction = 0
hitProg=0

/*event_inherited()
setCollisionBounds(-11,-11,11,11)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitProg=0
hitWall=0*/
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 {sprite_index=sBustMoveBubbleRed}
else if type=2 {sprite_index=sBustMoveBubbleBlue}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if global.gamePaused=false
{
  //speed=moveSpd
  _speed=moveSpd

  decay-=1*gDeltaTime
  if decay<=0
    instance_destroy()
}
else
  {_speed=0}

correctSpeedDirection(self)*/


if global.gamePaused=false
{
  _speed=moveSpd
  decay-=1*gDeltaTime
  if decay<=0
    instance_destroy()
  var moveX, moveY, hitX, hitY;
  moveX = cos(degtorad(_direction)) * _speed * gDeltaTime;
  moveY = -sin(degtorad(_direction)) * _speed * gDeltaTime;
  hitX = place_meeting(x+moveX, y, oSolid);
  hitY = place_meeting(x, y+moveY, oSolid);

  if hitX and bounceAmt>0
  {
    _direction = 180-_direction;
    var pushX, safety;
    pushX = -sign(moveX);
    safety = 0;
    while place_meeting(x, y, oSolid) and safety<32
    {
        x += pushX;
        safety += 1;
    }
  }
  else if !hitX
  x += moveX;

  if hitY and bounceAmt>0
  {
    _direction = -_direction;
    var pushY, safety2;
    pushY = -sign(moveY);
    safety2 = 0;
        while place_meeting(x, y, oSolid) and safety2<32
        {
            y += pushY;
            safety2 += 1;
        }
  }
  else if !hitY
  y += moveY;

  if hitX or hitY
  {
    if bounceAmt>0 {bounceAmt-=1}
    else
    {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMbusterHitEffect
        tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        playSound(global.snd_MetroidBomb,0,0.9,1)
        instance_destroy()
    }
  }
}
else
  {_speed=0}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if bounceAmt>0
{
  move_bounce_all(0)
  bounceAmt-=1
}
else
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMbusterHitEffect
  tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  playSound(global.snd_MetroidBomb,0,0.9,1)
  instance_destroy()
}*/

/*if place_meeting(x+2, y, oSolid)
  {_direction = 180-_direction; if

//Y axis — hit a ceiling or floor
if place_meeting(x, y+2, oSolid)
    _direction = -_direction;*/
#define Collision_oSeekerVirusBasic
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if type=other.type
    life-=100
  playSound(global.snd_EnemyHit,0,0.92,1)
  if life<=0
  {
    awardAwesome(20)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusSMissileEffect
    tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    playSound(global.snd_EnemyDie,0,0.95,1)
    instance_destroy()
  }
}
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMbusterHitEffect; tEffect.image_speed=0.5
tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
