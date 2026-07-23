/*
Increments the value till it reaches the target value.
use: intercept_target_arc(myTarget,bulletHspeed,gravity)

argument0: the target
argument1: bullet horizontal speed
argument2: bullet gravity

returns: yVel needed to reach target
*/

var travTime,tLimitYVel,tDir;

if x>argument0.x {tDir=-1}
else {tDir=1}

if ((argument1*tDir)-argument0.xVel)!=0 {travTime=(argument0.x-x)/((argument1*tDir)-argument0.xVel)}
else {travTime=20}

if travTime!=0 {tLimitYVel=(-0.5*argument2*travTime)+argument0.yVel+(argument0.y-y)/travTime}
else {tLimitYVel=6}

return tLimitYVel;
