#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
podTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=5*image_xscale
  podTime+=1
  if podTime>=4
  {
    var myPodobo;
    myPodobo=instance_create(x,y,oGB_Podobo)
    myPodobo.yGrav=yGrav
    podTime=0
  }

  if (image_xscale=1 and x>oGiantBlarg.rightSide) or (image_xscale=-1 and x<oGiantBlarg.leftSide)
  {
    instance_destroy()
  }
}
