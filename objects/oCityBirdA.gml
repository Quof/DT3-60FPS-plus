#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_xscale=choose(-1,1)

animToPlay=choose(0,1)
animTime=0
animDelay=150+irandom(300)
bSpotted=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animTime+=1
if animToPlay=0
{
  if animTime=animDelay {image_index=2}
  else if animTime>=animDelay+56 and animTime<=animDelay+84
  {
    if animTime mod 7=0
    {
      if image_index=2 {image_index=3}
      else {image_index=2}
    }
  }
  else if animTime=animDelay+116
  {
    image_index=0
    animToPlay=choose(0,1)
    animTime=0
    animDelay=150+irandom(300)
  }
}
else if animToPlay=1
{
  if animTime=animDelay {image_index=1}
  else if animTime>=animDelay+42 and animTime<=animDelay+63
  {
    if animTime mod 7=0
    {
      if image_index=0 {image_index=1}
      else {image_index=0}
    }
  }
  else if animTime=animDelay+64
  {
    animToPlay=choose(0,1)
    animTime=0
    animDelay=150+irandom(300)
  }
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
