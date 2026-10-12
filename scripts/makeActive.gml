/*
Makes the object "active." An "active" object is one that has the variables
xVel, yVel, xAcc, and yAcc.
*/
xVel=0
yVel=0
xAcc=0
yAcc=0
//moving solid state (set by gameStepEvent, read by scrPlatformCrush and platform shift timers)
mstXLeft=0
mstYLeft=0
mstFramesLeft=0
mstXBlocked=0
mstYBlocked=0
mstXV=0
mstYV=0
mstLX=x
mstLY=y
mstEndX=x
mstEndY=y
if !variable_local_exists("deathCheck") {deathCheck=0} //60fps change (added): the platforms' crush counter (scrPlatformCrush), read by gameStepEvent's
//moving solids to tell whether a standing solid's "near a player" flag still matters (only set if missing: it's also called from Steps)
