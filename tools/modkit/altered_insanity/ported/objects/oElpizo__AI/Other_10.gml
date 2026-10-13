if instance_exists(oElpizoPortal)
{
  if portalAction=1 //Turn to other side if one portal is close
  {
    var tNextPortal;
    tNextPortal=instance_nearest(x,y-22,oElpizoPortal)
    if point_distance(x,y-22,tNextPortal.x,tNextPortal.y)<=80
    {
      if x>=tNextPortal.x and image_xscale=-1 {image_xscale=1}
      else if x<=tNextPortal.x and image_xscale=1 {image_xscale=-1}
    }
  }
  else if portalAction=2 //Checks if a portal is close
  {
    var tNextPortal;
    tNextPortal=instance_nearest(x,y-22,oElpizoPortal)
    if point_distance(x,y-22,tNextPortal.x,tNextPortal.y)<=80 {portalAction=100}
  }
}
