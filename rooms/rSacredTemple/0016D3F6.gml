progCheck=9000000
image_angle=90

var instrCheck;
instrCheck=string_char_at(global.eGateProg,3)
if instrCheck="8" or instrCheck="9"
  instance_destroy()
