/*
** This finds the center of the player based on the current sprite
** returns direction to player
** Variable created will be used in calling object for tracking
*/

var tMyDir;
tMyDir=point_direction(x,y,oPlayer1.x,oPlayer1.bbox_top+abs(oPlayer1.sprite_height/2)-abs(oPlayer1.sprite_height/4))

return tMyDir;
