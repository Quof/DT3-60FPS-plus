if type=1 //Big Asteroid
{
  maxLife=100
  life=maxLife
}
else if type=2 //Medium Asteroid
{
  maxLife=60
  life=maxLife
  spinSpd=3
  moveSpd=5
  image_xscale=0.66; image_yscale=0.66
}
else if type=3 //Small Asteroid
{
  maxLife=30
  life=maxLife
  spinSpd=5
  moveSpd=7
  image_xscale=0.33; image_yscale=0.33
}
