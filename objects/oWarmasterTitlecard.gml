#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayTime+=1*gDeltaTime
if type=0 //Main
{
  //if displayTime>=1 and displayTime<=50
  if displayTime>0 and displayTime<=50 //60fps change: covers every frame of ticks 1-50 (the card ended at scale 1.01/1.02 at 60/120fps)
  {
    image_xscale-=0.02*gDeltaTime; image_yscale-=0.02*gDeltaTime
    image_alpha+=0.02*gDeltaTime
    if displayTime mod 2=0
    {
      var tMyTitleCard;
      tMyTitleCard=instance_create(x,y,oWarmasterTitlecard); tMyTitleCard.type=1
      tMyTitleCard.image_xscale=image_xscale; tMyTitleCard.image_yscale=image_yscale; tMyTitleCard.image_alpha=0.2
    }
  }
  else if displayTime=51
  {
    var tMyTitleCard;
    tMyTitleCard=instance_create(x,y,oWarmasterTitlecard); tMyTitleCard.type=2
    tMyTitleCard.image_xscale=image_xscale; tMyTitleCard.image_yscale=image_yscale
    tMyTitleCard.image_blend=c_black
  }
  else if displayTime>=90
  {
    image_alpha-=0.1*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
else if type=1 //Sub
{
  //if displayTime>=1 and displayTime<=10
  if displayTime>0 and displayTime<=10 //60fps change: covers every frame of ticks 1-10 (the trail cards stopped at alpha 0.01/0.015 and stayed on screen at 60/120fps)
  {
    image_xscale+=0.025*gDeltaTime; image_yscale+=0.025*gDeltaTime
    image_alpha-=0.02*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
else if type=2 //Final
{
  image_alpha-=0.05*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
}
