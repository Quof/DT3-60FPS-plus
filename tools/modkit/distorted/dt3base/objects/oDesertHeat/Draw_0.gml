myX=view_xview[0]+280
myY=view_yview[0]+24

draw_set_alpha(1)
draw_sprite(sDesertWaterMeter,0,myX,myY)
hydroTrack=(global.desertHeat/1500)*16
draw_circle_color(myX,myY,hydroTrack,innerColor,outerColor,0)

draw_set_color(c_black)
draw_circle(myX,myY,16,1)
