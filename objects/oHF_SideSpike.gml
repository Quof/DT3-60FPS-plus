#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=11
bCanTakeDamage=false
bShowHealthBar=false

spikeProg=0
sizeUp=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if spikeProg=0 //Move into place
  {
    if image_xscale=1
    {
      x+=1
      if x>=oHex_Final_Main.xCenter-oHex_Final_Main.roomSpan
      {
        spikeProg=1
      }
    }
    else
    {
      x-=1
      if x<=oHex_Final_Main.xCenter+oHex_Final_Main.roomSpan
      {
        spikeProg=1
      }
    }
  }
  else if spikeProg=1 //Slowly scale up and down
  {
    if image_xscale>0
    {
      if sizeUp=1
      {
        image_xscale+=0.004; image_yscale+=0.004
        if image_xscale>=1.2 {sizeUp=0}
      }
      else
      {
        image_xscale-=0.004; image_yscale-=0.004
        if image_xscale<=1 {sizeUp=1}
      }
    }
    else
    {
      if sizeUp=1
      {
        image_xscale-=0.004; image_yscale+=0.004
        if image_xscale<=-1.2 {sizeUp=0}
      }
      else
      {
        image_xscale+=0.004; image_yscale-=0.004
        if image_xscale>=-1 {sizeUp=1}
      }
    }
  }
}
