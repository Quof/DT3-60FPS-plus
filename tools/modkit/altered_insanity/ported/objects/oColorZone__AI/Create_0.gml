if room <> rC5_Arena13
{
//if zoneColor=1
//  image_blend=c_red
//else if zoneColor=2
//  image_blend=c_blue
//else if zoneColor=3
//  image_blend=c_green
//else if zoneColor=4
//  image_blend=c_yellow
//color zone change: the colors are an option now (Options > Graphics > Color Zone Colors; red, blue, green, yellow by default)
if zoneColor>=1 and zoneColor<=4 {image_blend=global.czColor[zoneColor]}
}
else
{
    alarm[0] = 1
}
flashTime=0
innerAlpha=0.5
sprite_index=sScaledCollision
moveTime=0
if !variable_local_exists("_direction") {_direction=0}
if !variable_local_exists("_speed") {_speed=0}
