/*
This script creates an enemy with the specified values.
use: createEnemy(x,y,obj,quest,effect,active)

argument0: x position
argument1: y position
argument2: object to create
argument3: quest type
argument4: spawn effect
argument5: activate object on spawn
*/

var tEnX,tEnY,tEnObject,tEnQuest,tEnEffect,tEnActive;

tEnX=argument0
tEnY=argument1
tEnObject=argument2
tEnQuest=argument3
tEnEffect=argument4
tEnActive=argument5

newEnemy=instance_create(tEnX,tEnY,tEnObject)
newEnemy.bActive=tEnActive
newEnemy.questType=tEnQuest
if global.location=58 or global.location=107 //Gate 6
{
  newEnemy.rpgLv=global.tempAction[0] //Set enemy level
  if newEnemy.object_index=1074 {newEnemy.image_index=global.tempAction[1]} //Use for 'Test Enemy' image index
}

if tEnEffect=1
{
  var tEfCreate;
  tEfCreate=instance_create(newEnemy.bbox_left+(newEnemy.sprite_width/2),newEnemy.bbox_top+(newEnemy.sprite_height/2),oEffect)
  tEfCreate.sprite_index=sMMchargeComplete
  tEfCreate.image_speed=0.5; tEfCreate.image_xscale=2; tEfCreate.image_yscale=2
  tEfCreate.newBlend=-1; tEfCreate.followID=-1; tEfCreate.decay=-100; tEfCreate.xSpd=0; tEfCreate.ySpd=0
}
