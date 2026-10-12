#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
image_xscale=2
if global.location=55 {image_alpha=0.55}
else {image_alpha=0.45}
combSurf=-1 //60fps change (added): see User Event 0
if gDeltaTime<1 {event_user(0)} //60fps change (added)
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(combSurf) {surface_free(combSurf)} //60fps change (added): see User Event 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02*gDeltaTime
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): the comb surface is built again if it was lost (e.g. the window was minimized) or the frame rate
//was raised from 30fps; built here, outside the Draw event, like the other surfaces in the game
if gDeltaTime<1 and !surface_exists(combSurf) {event_user(0)}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(combSurf) {surface_free(combSurf)} //60fps change (added): see User Event 0 (room end skips the Destroy event)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): the wave shifts each row of the sprite sideways by one of 12 amounts (it repeats every 12 rows), so
//rows 0,12,24.. always move together, rows 1,13,25.. together, and so on. Each of those 12 sets is copied once into its own
//256x256 cell of this surface (a "comb": the set's rows in place, black between them), in a 4x3 grid. The Draw event adds
//each comb at its row shift: 24 draws a frame instead of one for every row. It's added (bm_add), so the black between the
//rows adds nothing, and the sprite is fully opaque, so each row adds exactly what it did when drawn on its own
if surface_exists(combSurf) {surface_free(combSurf)}
combSurf=surface_create(1024,768)
if surface_exists(combSurf)
{
  var tW,tRow,tK;
  tW=sprite_get_width(sprite_index)
  surface_set_target(combSurf)
  draw_clear_alpha(c_black,1)
  for(tRow=0;tRow<sprite_get_height(sprite_index);tRow+=1)
  {
    tK=tRow mod 12
    draw_sprite_part(sprite_index,image_index,0,tRow,tW,1,(tK mod 4)*256,(tK div 4)*256+tRow)
  }
  surface_reset_target()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
//draw_sprite_wave(sprite_index,image_index,view_xview[0]-16,view_yview[0]-64,1,12,2,phase)
//draw_sprite_wave(sprite_index,image_index,view_xview[0]-16,view_yview[0]+192,1,12,2,phase)
var tW,tPX,tPY,tShift,tS,tRow,tLast;
tPX=view_xview[0]-16
//60fps change: above 30fps, each copy is the 12 combs (see User Event 0) at their wave shifts: the same rows in the same places
if gDeltaTime<1 and surface_exists(combSurf)
{
  for(tRow=0;tRow<12;tRow+=1)
  {
    tS=2*sin(2*pi*((tRow/12)+phase))
    draw_surface_part_ext(combSurf,(tRow mod 4)*256,(tRow div 4)*256,256,256,tPX+tS,view_yview[0]-64,image_xscale,image_yscale,image_blend,image_alpha)
    draw_surface_part_ext(combSurf,(tRow mod 4)*256,(tRow div 4)*256,256,256,tPX+tS,view_yview[0]+192,image_xscale,image_yscale,image_blend,image_alpha)
  }
  draw_set_blend_mode(bm_normal)
  exit
}
//60fps change: otherwise draw_sprite_wave's rows drawn here, only the ones inside the view: the top copy's first 64 rows are
//always above it and the bottom copy's last 96 always below it (the wave only shifts rows sideways), so 352 of the 512 rows.
//The wave repeats every 12 rows (wavelength 12), so its 12 shifts are worked out once instead of a sine for every row
tW=sprite_get_width(sprite_index)
for(tRow=0;tRow<12;tRow+=1) {tShift[tRow]=2*sin(2*pi*((tRow/12)+phase))}
tPY=view_yview[0]-64 //top copy: rows 64-255 are inside the view
for(tRow=64;tRow<256;tRow+=1)
{
  draw_sprite_part_ext(sprite_index,image_index,0,tRow,tW,1,tPX+tShift[tRow mod 12],tPY+tRow,image_xscale,image_yscale,image_blend,image_alpha)
}
tPY=view_yview[0]+192 //bottom copy: rows from 0 down to the bottom of the view
tLast=min(256,view_hview[0]-192)
for(tRow=0;tRow<tLast;tRow+=1)
{
  draw_sprite_part_ext(sprite_index,image_index,0,tRow,tW,1,tPX+tShift[tRow mod 12],tPY+tRow,image_xscale,image_yscale,image_blend,image_alpha)
}
draw_set_blend_mode(bm_normal)
