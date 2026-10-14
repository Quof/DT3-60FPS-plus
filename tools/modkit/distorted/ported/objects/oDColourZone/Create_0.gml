//moveSpd, moveDelay, direction, zoneColor, zoneType, zoneRadius
/*if zoneColor=1
  image_blend=c_red
else if zoneColor=2
  image_blend=c_blue
else if zoneColor=3
  image_blend=c_green
else if zoneColor=4
  image_blend=c_yellow*/
flashTime=0
innerAlpha=0.5
sprite_index=sScaledCollision
moveTime=0
bFollow=0

image_alpha=0   //invisible

if !variable_local_exists("zoneType")   //default to circle
    zoneType=0
if !variable_local_exists("zoneRadius")     //inside a hex ring of standard size
    zoneRadius=78
    
if !variable_local_exists("moveSpd")
    moveSpd=0
if !variable_local_exists("moveDelay")
    moveDelay=0
    
alarm[0]=1
