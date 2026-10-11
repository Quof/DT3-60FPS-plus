#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II visual effect (scrWM2_Fx, scrWM2_Ghost). Everything below is per 30fps tick.
add=0         //1: additive
fade=0        //alpha lost per tick
grow=0        //scale gained per tick
vx=0          //movement per tick
vy=0
grav=0        //vy gained per tick
rot=0         //angle per tick
life=-1       //ticks till it goes; -1: when the animation ends
follow=noone  //stays at follow.x+fx, follow.y+fy
fx=0
fy=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x+=vx*gDeltaTime
y+=vy*gDeltaTime
if grav!=0 {vy+=grav*gDeltaTime}
if rot!=0 {image_angle+=rot*gDeltaTime}
if grow!=0
{
  image_xscale+=grow*sign(image_xscale)*gDeltaTime
  image_yscale+=grow*sign(image_yscale)*gDeltaTime
}
if follow!=noone
{
  if instance_exists(follow) {x=follow.x+fx; y=follow.y+fy}
}
if fade!=0
{
  image_alpha-=fade*gDeltaTime
  if image_alpha<=0 {instance_destroy(); exit}
}
if life>=0
{
  life-=1*gDeltaTime
  if life<=0 {instance_destroy()}
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life<0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if add=1 {draw_set_blend_mode(bm_add)}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if add=1 {draw_set_blend_mode(bm_normal)}
