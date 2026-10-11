#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II: an attack warning (scrWM2_Tele). It brightens once it locks in place.
//type 0: column at x1 (half width x2), 1: band from y1 to y2 (arrows on side x2), 2: line, 3: target ring, 4: box
type=0
x1=0; y1=0; x2=0; y2=0
dur=10           //ticks it shows
col=c_white
t=0
trackPlayer=0    //1: follows the player (column: x1, line: x2,y2, ring: x1,y1) until lockT
lockT=0
owner=noone      //line: starts at owner.x+ox, owner.y+oy
ox=0; oy=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
t+=1*gDeltaTime
if trackPlayer=1 and t<lockT and instance_exists(oPlayer1)
{
  if type=0 {x1=oPlayer1.x}
  else if type=2 {x2=oPlayer1.x; y2=returnPlayerYCenter()}
  else if type=3 {x1=oPlayer1.x; y1=returnPlayerYCenter()}
}
if owner!=noone
{
  if instance_exists(owner) {x1=owner.x+ox; y1=owner.y+oy}
}
if t>=dur {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tA,tLock,tW;
tLock=(trackPlayer=0 or t>=lockT)
tA=0.25+0.2*abs(sin(t*0.9))
if tLock {tA+=0.25}
if t>dur-3 {tA*=(dur-t)/3} //fades out over its last 3 ticks
draw_set_blend_mode(bm_add)
draw_set_color(col)
if type=0 //column down to the floor
{
  draw_set_alpha(tA*0.45)
  draw_rectangle(x1-x2,48,x1+x2,303,false)
  draw_set_alpha(tA)
  draw_line_width(x1,48,x1,303,2)
  draw_rectangle(x1-x2,48,x1+x2,303,true)
}
else if type=1 //band across the arena
{
  draw_set_alpha(tA*0.4)
  draw_rectangle(32,y1,447,y2,false)
  draw_set_alpha(tA)
  draw_line_width(32,y1,447,y1,1)
  draw_line_width(32,y2,447,y2,1)
  //arrows on the side the shot comes from
  if x2!=0
  {
    var i,tX;
    for(i=0;i<3;i+=1)
    {
      tX=240+x2*(170-i*14)
      draw_triangle(tX,(y1+y2)/2-5,tX,(y1+y2)/2+5,tX-x2*8,(y1+y2)/2,false)
    }
  }
}
else if type=2 //aim line
{
  draw_set_alpha(tA)
  tW=1
  if tLock {tW=2}
  draw_line_width(x1,y1,x2,y2,tW)
  draw_circle(x2,y2,6,true)
}
else if type=3 //target ring
{
  draw_set_alpha(tA)
  draw_circle(x1,y1,8+6*abs(sin(t*0.5)),true)
  draw_line_width(x1-12,y1,x1+12,y1,1)
  draw_line_width(x1,y1-12,x1,y1+12,1)
}
else if type=4 //box (the area a big cut will cover)
{
  draw_set_alpha(tA*0.35)
  draw_rectangle(max(32,x1),y1,min(447,x2),y2,false)
  draw_set_alpha(tA)
  draw_rectangle(max(32,x1),y1,min(447,x2),y2,true)
}
draw_set_blend_mode(bm_normal)
draw_set_alpha(1)
