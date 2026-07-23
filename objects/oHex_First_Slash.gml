#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
timeToHit=0
lineWidth=1
lineColor=make_color_rgb(255,140,140)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  timeToHit+=1
  if timeToHit<10 {image_xscale+=67} //Grow

  if timeToHit=35 {lineColor=c_red}
  if timeToHit>=35 and timeToHit<=44 {lineWidth+=0.5} //Damage warn
  if timeToHit=45 //Damage check / Effect
  {
    bCanDealDamage=true
    currX=x; currY=y
    lastX=x+lengthdir_x(596,image_angle); lastY=y+lengthdir_y(596,image_angle)
    while(point_distance(currX,currY,lastX,lastY)>25)
    {
      var tEffect;
      for(i=0;i<2;i+=1)
      {
        tEffect=instance_create(currX,currY,oEffect)
        tEffect.sprite_index=sMMshotgunIceEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.2+random(0.2)
        tEffect.speed=0.75+random(1); tEffect.direction=image_angle+90+(i*180)
      }
      ranAmt=irandom_range(25,28)
      currX+=lengthdir_x(ranAmt,image_angle); currY+=lengthdir_y(ranAmt,image_angle)
    }
  }
  if timeToHit=47 {instance_destroy()} //Destroy
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if timeToHit<46
{
  draw_set_alpha(1)
  draw_set_color(lineColor)
  draw_line_width(x,y,x+lengthdir_x(image_xscale,image_angle),y+lengthdir_y(image_xscale,image_angle),lineWidth)
}
