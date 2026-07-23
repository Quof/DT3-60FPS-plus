#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=5
atkProg=0
atkTime=0
myDist=0
spinSpd=3
stabDelay=390
blendPhase=0
blendCol=255
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    myDist+=1
    if myDist=62 {atkProg+=1}
  }
  else if atkProg=1
  {
    direction+=spinSpd

    stabTime+=1
    if stabTime>=stabDelay
    {
      stabTime=0
      atkProg+=1
    }
  }
  else if atkProg=2
  {
    atkTime+=1
    if atkTime>=45 and atkTime<=54 {myDist+=5}
    else if atkTime>=85 and atkTime<=94 {myDist-=5}
    else if atkTime>=95 {atkTime=0;atkProg=1}
  }

  if blendPhase=0
  {
    blendCol-=3
    if blendCol=120 {blendPhase=1}
  }
  else if blendPhase=1
  {
    blendCol+=3
    if blendCol=255 {blendPhase=0}
  }

  image_blend=make_color_rgb(blendCol,255,blendCol)
  x=oLegion.x+lengthdir_x(myDist*oLegion.image_xscale,baseDir+direction)
  y=oLegion.y+lengthdir_y(myDist*oLegion.image_yscale,baseDir+direction)
  image_angle=baseDir+direction
}
