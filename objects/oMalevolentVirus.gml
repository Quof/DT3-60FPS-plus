#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_speed=0.3
bCanDealDamage=false

//Enemy base statistics
eName="Malevolent Virus"
eLevel=15
maxLife=4200
life=maxLife
pointWorth=40

xDist=800
yDist=400

jeremyText="It's spiraling about, getting closer and closer to X. It has no attacks in this state, since it seems to need a host. Contact doesn't seem to harm you either."
chaoText="If you don't stop this thing from getting to X, it's all over. It seems to be defenseless on its own, but it brought those two Wasp Bots to assist."
devText="I realized the bottomless pits are probably this fights worst element, and intended to make use of that. I hope to have more encounters like this in the future which break things up a bit."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if xDist>=400
  {
    xDist-=0.125
    yDist-=0.0625
  }
  else if xDist>=250 and xDist<=399.999
  {
    xDist-=0.25
    yDist-=0.125
  }
  else if xDist>=96 and xDist<=249.999
  {
    xDist-=0.5
    yDist-=0.25
  }
  else if xDist<=95.999
  {
    xDist-=1
    yDist-=0.5
  }
  direction+=0.33
  x=1248+lengthdir_x(xDist,direction)
  y=288+lengthdir_y(yDist,direction)
  if xDist<=12
  {
    oPlayer1.life-=oPlayer1.maxLife
  }

  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

distToPlayer=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
if distToPlayer>160
{
  var arrowDir;
  arrowDir=point_direction(oPlayer1.x,oPlayer1.y-26,x,y)
  draw_sprite_ext(sPauseM_Cursor,0,oPlayer1.x+lengthdir_x(72,arrowDir),oPlayer1.y-26+lengthdir_y(72,arrowDir),1,1,arrowDir,c_white,1)
}
