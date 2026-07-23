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
displayTime+=1
if type=0 //Main
{
  if displayTime>=1 and displayTime<=50
  {
    image_xscale-=0.02; image_yscale-=0.02
    image_alpha+=0.02
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
    image_alpha-=0.1
    if image_alpha<=0 {instance_destroy()}
  }
}
else if type=1 //Sub
{
  if displayTime>=1 and displayTime<=10
  {
    image_xscale+=0.025; image_yscale+=0.025
    image_alpha-=0.02
    if image_alpha<=0 {instance_destroy()}
  }
}
else if type=2 //Final
{
  image_alpha-=0.05
  if image_alpha<=0 {instance_destroy()}
}
