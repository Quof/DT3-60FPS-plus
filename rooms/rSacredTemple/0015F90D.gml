fallSpeed=-8
riseSpeed=-8
distMax=752
spriteChange=1
image_blend=make_color_rgb(100,100,255)

var instrCheck;
instrCheck=string_char_at(global.eGateProg,2)
if instrCheck!="8" and instrCheck!="9"
  instance_destroy()
