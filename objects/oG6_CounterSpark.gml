#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
frameCount=0
maxFrame=image_number+1
//skeleton sparkle change (added): followID: an instance this follows, at followX (mirrored by followID's image_xscale),
//followY from it (End Step). Set by oPT_Skeleton with the Skeleton Sparkle dipswitch
followID=noone
followX=0
followY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=10*image_xscale*gDeltaTime
  image_index+=1*gDeltaTime
  frameCount+=1*gDeltaTime
  if frameCount>=maxFrame {instance_destroy()}
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//skeleton sparkle change (added): follows followID (see Create)
if followID!=noone
{
  if instance_exists(followID)
  {
    x=followID.x+followX*followID.image_xscale
    y=followID.y+followY
  }
}
