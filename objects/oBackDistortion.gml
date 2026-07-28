#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0
alphaPulse=0
scalePulse=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Veins
{
  x-=0.5*gDeltaTime; y-=0.5*gDeltaTime

  alphaPulse+=1*gDeltaTime
  if alphaPulse>=21 and alphaPulse<=120 {image_alpha+=0.001*gDeltaTime}
  else if alphaPulse>=131 and alphaPulse<=230 {image_alpha-=0.001*gDeltaTime}
  else if alphaPulse>=260 {alphaPulse=0}

  scalePulse+=1*gDeltaTime
  if scalePulse>=1 and scalePulse<=80 {image_xscale+=0.0005*gDeltaTime; image_yscale+=0.0005*gDeltaTime}
  else if scalePulse>=81
  {
    image_xscale-=0.0005*gDeltaTime; image_yscale-=0.0005*gDeltaTime
    if scalePulse>=160 {scalePulse=0}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Veins
{
  draw_background_tiled_ext(backDistortionA,x,y,image_xscale,image_yscale,c_white,image_alpha)
}
