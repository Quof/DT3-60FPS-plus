#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Requires: type,enemySpawn,xSpawn,ySpawn,activate
Spawn enemies when the player collides with this object.
--type: Spawn position type
  --0: Manual set x/y position
  --1: Auto set x position based on x view (left side)
  --2: Auto set x position based on x view (right side)
  --3: Auto set y position based on y view (left side)
  --4: Auto set y position based on y view (right side)
--enemySpawn: Enemy object to spawn
--xSpawn: x position to spawn object
--ySpawn: y position to spawn object
--activate: Whether the object will be active when it spawns

--Enemy specific variables will be set based on enemySpawn
*/

if type=1 {xSpawn=view_xview[0]-40}
else if type=2 {xSpawn=view_xview[0]+view_wview[0]+40}

else if type=3 {ySpawn=view_yview[0]-40}
else if type=4 {ySpawn=view_yview[0]+view_hview[0]+40}

newSpawn=instance_create(xSpawn,ySpawn,enemySpawn)
newSpawn.bActive=activate

if global.location!=110
{
  var tEfCreate;
  tEfCreate=instance_create(newSpawn.bbox_left+(newSpawn.sprite_width/2),newSpawn.bbox_top+(newSpawn.sprite_height/2),oEffect)
  tEfCreate.sprite_index=sMMchargeComplete; tEfCreate.image_speed=0.5; tEfCreate.image_xscale=1.5; tEfCreate.image_yscale=1.5
  tEfCreate.newBlend=-1; tEfCreate.followID=-1; tEfCreate.decay=-100; tEfCreate.xSpd=0; tEfCreate.ySpd=0
}

if global.location=58 or global.location=107 //Gate 6 enemy spawn
{
  newSpawn.rpgLv=irandom_range(lvlMin,lvlMax)
}
else if global.location=59 //Hidden Program Facilty Virus Type
{
  newSpawn.type=myType
}

instance_destroy()
