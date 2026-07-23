/*
This script creates an enemy with the specified values at a delayed rate.
use: delaySpawn(x,y,obj,quest,effect,active,anim_speed)

argument0: x position
argument1: y position
argument2: object to create
argument3: quest type
argument4: spawn effect
argument5: activate object on spawn
argument6: target animation speed
*/

var tNewSpawn,tEnX,tEnY,tEnObject,tEnQuest,tEnEffect,tEnActive,tAnimSpd;

tEnX=argument0
tEnY=argument1
tEnObject=argument2
tEnQuest=argument3
tEnEffect=argument4
tEnActive=argument5
tAnimSpd=argument6

tNewSpawn=instance_create(tEnX,tEnY,oCreateEnemy)
tNewSpawn.ceObject=tEnObject
tNewSpawn.ceQuest=tEnQuest
tNewSpawn.ceEffect=tEnEffect
tNewSpawn.ceActive=tEnActive
tNewSpawn.image_speed=tAnimSpd
