#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
animTime=0
animDelay=60+irandom(330)
animToPlay=0
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
  if animTime=animDelay {animTime=0; animToPlay=1}
}
else if animToPlay=1
{
  if animTime=1 {image_index=1}
  else if animTime=25 {image_index=2}
  else if animTime=33 {image_index=1}
  else if animTime=41 {image_index=2}
  else if animTime=49 {image_index=1}
  else if animTime=57 {image_index=2}
  else if animTime=65 {image_index=1}
  else if animTime=77 {image_index=0}
  else if animTime>=85 {animTime=0; animToPlay=0}
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
