if y<=0
{
  image_yscale+=16
  y-=256
}

var yLimit;
yLimit=y+(image_yscale*16)
if yLimit>=room_height
{
  image_yscale+=8
}
