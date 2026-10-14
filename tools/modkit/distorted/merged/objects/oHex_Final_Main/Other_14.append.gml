///zap
//zap traps; can have one slowly go from top to bottom
//only spawn here; "move" code in step (along with destruction)
avoZapX=oPlayer1.x
var tZapTrap;
tZapTrap=instance_create(avoZapX,32,oZapTrap)
tZapTrap.image_angle=90; tZapTrap.image_xscale=8
