/*
**  Usage:
**      intercept_course_player(x,y,speed)
**
**  Given:
**      x,y         position (x,y)
**      speed       speed of the projectile
**
**  Returns:
**      course direction required to intercept
**      a moving target at a given speed,
**      or (-1) if no solution found
**
**  GMLscripts.com
*/

var xx,yy,pspeed,tDir,alpha,phi,beta,tarDir;
xx=argument0
yy=argument1
pspeed=argument2
tDir=point_direction(xx,yy,oPlayer1.x,oPlayer1.y-26)
alpha=abs(oPlayer1.xVel)/pspeed
if oPlayer1.image_xscale=1 {tarDir=0}
else {tarDir=180}
phi=degtorad(tarDir-tDir)
beta=alpha*sin(phi)
if (abs(beta)>=1)
{
  return point_direction(xx,yy,oPlayer1.x,oPlayer1.y-26);
}
tDir+=radtodeg(arcsin(beta))
return tDir;
