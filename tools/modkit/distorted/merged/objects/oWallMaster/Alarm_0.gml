if global.location=103
{
  for(i=0;i<3;i+=1) //spsp ns
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
    myShadow.spec=i //spsp ns
}
}
