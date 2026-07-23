#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
bShift=0
shiftSeq=0
gearAngle=0
initObj=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
collObj[0]=instance_create(x-(32*image_xscale),y-(48*image_xscale),oInvisibleSolid)
collObj[0].image_xscale=4*image_xscale; collObj[0].image_yscale=image_yscale
collObj[1]=instance_create(x-(32*image_xscale),y+(32*image_xscale),oInvisibleSolid)
collObj[1].image_xscale=4*image_xscale; collObj[1].image_yscale=image_yscale

if variable_local_exists("angleChange") {gearAngle=angleChange}
if gearAngle=90
{
  collObj[0].x=x-(48*image_xscale); collObj[0].y=y-(32*image_xscale)
  collObj[0].image_xscale=image_xscale; collObj[0].image_yscale=4*image_yscale
  collObj[1].x=x+(32*image_xscale); collObj[1].y=y-(32*image_xscale)
  collObj[1].image_xscale=image_xscale; collObj[1].image_yscale=4*image_yscale
}
initObj=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bShift=1
  {
    gearAngle+=10
    shiftSeq+=1
    if shiftSeq=9
    {
      if gearAngle=180 {gearAngle=0}

      if gearAngle=0
      {
        collObj[0].x=x-(32*image_xscale); collObj[0].y=y-(48*image_xscale)
        collObj[0].image_xscale=4*image_xscale; collObj[0].image_yscale=image_yscale
        collObj[1].x=x-(32*image_xscale); collObj[1].y=y+(32*image_xscale)
        collObj[1].image_xscale=4*image_xscale; collObj[1].image_yscale=image_yscale
      }
      else if gearAngle=90
      {
        collObj[0].x=x-(48*image_xscale); collObj[0].y=y-(32*image_xscale)
        collObj[0].image_xscale=image_xscale; collObj[0].image_yscale=4*image_yscale
        collObj[1].x=x+(32*image_xscale); collObj[1].y=y-(32*image_xscale)
        collObj[1].image_xscale=image_xscale; collObj[1].image_yscale=4*image_yscale
      }

      shiftSeq=0
      bShift=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,gearAngle,image_blend,image_alpha)

/*
draw_set_alpha(1)
draw_set_color(c_black)
draw_text(x,y+8,gearAngle)
draw_circle(x,y,2,0)
