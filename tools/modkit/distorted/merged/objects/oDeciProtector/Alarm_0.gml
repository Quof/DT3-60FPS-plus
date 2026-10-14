//spsp ns
resType[0]=spspres
resType[1]=spspres
resType[2]=spspres
resType[3]=spspres
resType[4]=2
resType[5]=spspres
if type=0 or type=4
{
  baseColor=c_fuchsia
  resType[1]=4
}
else if type=1 or type=5
{
  baseColor=c_orange
  resType[5]=4
}
else if type=2 or type=6
{
  baseColor=c_blue
  resType[3]=4
}
else if type=3 or type=7
{
  baseColor=c_green
  resType[2]=4
}
image_blend=baseColor
