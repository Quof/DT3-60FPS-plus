/*
**  Usage:
**      draw_surface_wave(surface,x,y,axis,wavelength,amplitude,phase,left,top,width,height)
**
**  Arguments:
**      surface         surface id
**      x,y             position in room to draw surface
**      axis            0 = horizontal wave, 1 = vertical wave
**      wavelength      length of wave in pixels, crest to crest
**      amplitude       half the height of wave in pixels, crest to trough
**      phase           wave position offset, vary to animate wave
**      left            left position to start drawing the surface
**      top             top position to start drawing the surface
**      width           width of the surface to draw
**      height          height of the surface to draw
**
**  Returns:
**      nothing
**
**  Notes:
**      Draws a surface with wave-like distortion.
**      The fractional part of the phase argument controls the cycle
**      of the wave, a full cycle covers the [0..1] interval.
**
**  GMLscripts.com
*/
var surface,image,posx,posy,axis,wavelength,amplitude,phase,width,height;
surface    = argument0;
posx       = argument1;
posy       = argument2;
axis       = argument3;
wavelength = argument4;
amplitude  = argument5;
phase      = argument6;
left       = argument7;
top        = argument8;
width      = argument9;
height     = argument10;

var xoff,yoff,size,i,shift,sx,sy;
//width  = surface_get_width(surface);
//height = surface_get_height(surface);
xoff   = 0 //sprite_get_xoffset(surface);
yoff   = 0 //sprite_get_yoffset(surface);
if (axis) size = height else size = width;

for (i=0; i<size; i+=1) {
  shift = amplitude*sin(2*pi*((i/wavelength)+phase));
  if (axis) {
    sx = shift-xoff+posx;
    sy = i-yoff+posy;
    draw_surface_part_ext(surface,left,top+i,width,1,sx,sy,image_xscale,image_yscale,image_blend,image_alpha);
  }else{
    sx = i-xoff+posx;
    sy = shift-yoff+posy;
    draw_surface_part_ext(surface,left+i,top,1,height,sx,sy,image_xscale,image_yscale,image_blend,image_alpha);
  }
}
