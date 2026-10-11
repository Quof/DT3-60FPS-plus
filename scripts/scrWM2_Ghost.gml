/*
Warmaster II (or a clone): an afterimage of the caller's current frame that fades out where it was made.
argument0: starting alpha
argument1: alpha lost per 30fps tick
argument2: colour blend
argument3: 1 = additive (glowing), 0 = normal
Returns the afterimage.
*/
var tF;
tF=instance_create(x,y,oWM2_Fx)
tF.sprite_index=sprite_index
tF.image_index=image_index
tF.image_speed=0
tF.image_xscale=image_xscale
tF.image_yscale=image_yscale
tF.image_angle=image_angle
tF.image_blend=argument2
tF.image_alpha=argument0
tF.fade=argument1
tF.add=argument3
tF.life=999
tF.depth=depth+1
return tF
