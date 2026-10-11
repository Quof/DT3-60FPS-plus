/*
Warmaster II: a colour between two colours.
argument0, argument1: the colours
argument2: how far from the first to the second (0-1)
*/
var tT;
tT=median(0,argument2,1)
return make_color_rgb(color_get_red(argument0)+(color_get_red(argument1)-color_get_red(argument0))*tT,color_get_green(argument0)+(color_get_green(argument1)-color_get_green(argument0))*tT,color_get_blue(argument0)+(color_get_blue(argument1)-color_get_blue(argument0))*tT)
