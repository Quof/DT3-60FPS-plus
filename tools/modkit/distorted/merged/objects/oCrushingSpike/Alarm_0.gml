if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}
else if global.location=90 //spsp ns
{
    atkPower=12
    detectDistX=36*16
    detectDistY=32
    seekDelay=60
    if variable_local_exists("left")
    {
        spicy=1
        image_angle-=90
    }
    else if variable_local_exists("right")
    {
        spicy=2
        image_angle+=90
    }
}
