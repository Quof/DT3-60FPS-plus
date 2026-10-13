//Randomizer: on the title screen, under the modes that are on (as they're drawn there)
draw_set_halign(fa_left)
if global.rndNextSeed>=0 {textDropShadow("*Randomizer: seed "+string(global.rndNextSeed)+"*",2,196,c_white,c_black,1)}
else {textDropShadow("*Randomizer*",2,196,c_white,c_black,1)}
