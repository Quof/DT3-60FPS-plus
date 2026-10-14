/* Shoots out moving platforms at set intervals at set speed.
These values can be changed, but for walljumps, default values are chosen so that "lane change" is possible,
so changing them is perhaps ill-advised.
Needs (for now):
shotTime
shotDelay
platXSpeed
platYSpeed
platDepth
platDecay
platType
*/

if !variable_local_exists("shotTime")
    shotTime=0
if !variable_local_exists("shotDelay")
    shotDelay=60
if !variable_local_exists("platXSpeed")
    platXSpeed=0
if !variable_local_exists("platYSpeed")
    platYSpeed=2
if !variable_local_exists("platDepth")
    platDepth=501
if !variable_local_exists("platDecay")
    platDecay=180
if !variable_local_exists("platType")
    platType=0

if platType=0
{
    platSprite=sMM_MovingWallA
}
else
{
    platSprite=sMovingPlatform1
}
