if variable_local_exists("hori")
{
    spcheck=1
    if hori=1 {image_yscale=-1}
    image_angle=90
if variable_local_exists("halfStart")
    {
      atkProg=38
      x+=16
    }
}
else if variable_local_exists("halfStart")
{
  atkProg=38
  y+=16
}

if image_yscale=-1 {image_index=1-image_index} //spsp ns
