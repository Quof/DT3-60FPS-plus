#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type
viscidTop=1
makeActive()
solidIsNearPlayers=0
myColor=0
image_alpha=0
image_blend=c_black

platProg=0
platTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //From bottom
  {
    if platProg=0
    {
      if image_alpha<1 {image_alpha+=0.04}

      myColor+=3
      image_blend=make_color_rgb(myColor,myColor,myColor)
      if myColor>=255
      {
        image_blend=c_white
        platProg+=1
      }
    }
    else if platProg=1
    {
      yVel=-2
      if y<=208
      {
        y=208
        yVel=0
        platProg+=1
      }
    }
  }
  else if type=1 //Top moving platform
  {
    if platProg=0
    {
      if image_alpha<1 {image_alpha+=0.04}

      myColor+=3
      image_blend=make_color_rgb(myColor,myColor,myColor)
      if myColor>=255
      {
        image_blend=c_white
        platProg+=1
      }
    }
    else if platProg=1
    {
      platTime+=1
      if platTime=30 {xVel=2}
      else if platTime>=31 and platTime<=199
      {
        if x>=544
        {
          xVel=0
          platTime=200
        }
      }
      else if platTime=230 {xVel=-2}
      else if platTime>=231 and platTime<=400
      {
        if x<=288
        {
          xVel=0
          platTime=0
        }
      }
    }
  }
}
