/*
This script is called in the enemy draw event.
*/
if global.modOvr[enemyDrawEvent]>=0 {var __n; __n=0; repeat (argument_count) {global.modArg[__n]=argument[__n]; __n+=1}; return scrModOverride(enemyDrawEvent,argument_count)} //mods change (added): a mod's own version of this script runs instead (scrModOverride)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
