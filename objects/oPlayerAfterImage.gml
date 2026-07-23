#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
imageColor=make_color_rgb(64,128,88)
/*if global.p1CurrentElement=1
  imageColor=make_color_rgb(246,54,54)
else if global.p1CurrentElement=2
  imageColor=make_color_rgb(51,117,201)
else if global.p1CurrentElement=3
    imageColor=make_color_rgb(0,214,0)
else if global.p1CurrentElement=4
    imageColor=make_color_rgb(175,76,33)*/

sprite_index=oPlayer1.sprite_index
image_index=oPlayer1.image_index
image_xscale=oPlayer1.image_xscale
image_alpha=1
image_speed=0
bCanGiveAwesome=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  image_alpha-=0.1
if image_alpha<=0
  instance_destroy()
#define Collision_oDamagableBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanGiveAwesome=1
{
  awardAwesome(20)
  bCanGiveAwesome=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,1,0,imageColor,image_alpha)
