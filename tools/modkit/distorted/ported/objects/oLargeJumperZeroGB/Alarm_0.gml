if image_yscale=-1 {setCollisionBounds(2,abs(sprite_height)+1,sprite_width-2,-3)}

if global.location=103 //spsp ns Nightmare C, not sure about maxShadowDist
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=8; myShadow.maxShadowDist=192
}
