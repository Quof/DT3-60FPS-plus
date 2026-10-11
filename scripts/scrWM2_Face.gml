/*
Warmaster II (or one of his clones): turns to face the player.
*/
if oPlayer1.x>=x {image_xscale=abs(image_xscale)}
else {image_xscale=-abs(image_xscale)}
scaleForFacing=sign(image_xscale)
