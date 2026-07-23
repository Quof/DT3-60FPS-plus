#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  spawnTime+=1
  if spawnTime mod spawnDelay=0
  {
    var tNewBubble;
    if oPlayer1.image_xscale=1
      tNewBubble=instance_create(view_xview[0]+160+random(view_wview[0]),view_yview[0]+view_hview[0],oZBubble)
    else
      tNewBubble=instance_create((view_xview[0]+view_wview[0])-160-random(view_wview[0]),view_yview[0]+view_hview[0],oZBubble)
  }
}
