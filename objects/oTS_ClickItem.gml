#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bFollow=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFollow=1
{
  x=mouse_x
  y=mouse_y
}

if x<16 {x=16}
else if x>room_width-16 {x=room_width-16}
if y<16 {y=16}
else if y>room_height-16 {y=room_height-16}

if x>maxDist {x=maxDist}

if point_distance(x,y,questSpotX,questSpotY)<24
{
  if questTag=1
  {
    (394948).bStartMe=1; (394949).bStartMe=1;
    with (394928) {instance_destroy()}
  }
  else if questTag=2
  {
    var tClickItem;
    tClickItem=instance_create(2470,272,oTS_ClickItem)
    tClickItem.sprite_index=sTS_ItemA; tClickItem.maxDist=2560
    tClickItem.questTag=3; tClickItem.questSpotX=1963; tClickItem.questSpotY=301
    var tDrawing;
    for(i=0;i<3;i+=1)
    {
      tDrawing=instance_create(2336+(i*96),304,oTS_DrawingA)
      with tDrawing
      {
        activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
        lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
        image_blend=make_color_rgb(77,128,77)
      }
    }
  }
  else if questTag=3
  {
    (393801).bStartMe=1;
    with (394952) {instance_destroy()}
  }
  var tFlash;
  tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.5 tFlash.fadeSpeed=0.05
  instance_destroy()
}
#define Mouse_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bFollow=1
#define Mouse_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bFollow=0
