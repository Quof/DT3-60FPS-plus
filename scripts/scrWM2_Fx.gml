/*
Warmaster II: a visual effect (oWM2_Fx) that plays a sprite's animation once.
argument0, argument1: position
argument2: the sprite
argument3: the animation speed (frames per 30fps tick)
argument4: colour blend
argument5: 1 = additive (glowing), 0 = normal
Returns the effect; set its fade, grow, vx, vy, rot, life, follow, image_xscale etc. after this if needed.
*/
var tF;
tF=instance_create(argument0,argument1,oWM2_Fx)
tF.sprite_index=argument2
tF.image_speed=argument3
tF.image_blend=argument4
tF.add=argument5
return tF
