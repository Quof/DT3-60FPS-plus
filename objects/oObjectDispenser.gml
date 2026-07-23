#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=0
effectDist=400
type=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newDist")
  effectDist=newDist
if variable_local_exists("bInstant")
  spawnTime=reSpawnTime
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
  if pDist<effectDist
  {
    spawnTime+=1
    if spawnTime>=reSpawnTime
    {
      newObject=instance_create(x+offsetX,y+54+offsetY,objCreate)
      if objCreate=oPlatformTouch
      {
        newObject.sprite_index=newSprite
        newObject.image_speed=frameSpeed
        newObject.moving=true
        newObject.xVel=newXspeed
        newObject.yVel=newYspeed
        newObject.image_xscale=image_xscale
        newObject.image_yscale=image_yscale
        if variable_local_exists("spriteChange")
          newObject.spriteChange=spriteChange
      }
      if variable_local_exists("spawnChange")
      {
        spawnTime=spawnChange+irandom_range(-spawnRan,spawnRan)
      }
      else
        spawnTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sObjDispenser,-1,x,y)
draw_sprite_ext(sObjDispenser,-1,x,y,-1,1,0,c_white,1)
