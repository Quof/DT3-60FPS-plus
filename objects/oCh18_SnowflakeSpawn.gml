#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
snowSpawn=0
snowDelay=11

var i,tSnow;
for(i=0;i<16;i+=1)
{
  tSnow=instance_create(view_xview[0]+240+random_range(-304,304),view_yview[0]+random(352),oSnowflake)
  tSnow.type=1; tSnow.image_index=irandom_range(0,2)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
snowSpawn+=1
if snowSpawn>=snowDelay
{
  var tSnow;
  tSnow=instance_create(view_xview[0]+240+random_range(-304,304),view_yview[0]-16,oSnowflake)
  tSnow.type=1; tSnow.image_index=irandom_range(0,2)
  if oPlayer1.image_xscale=1
  {
    tSnow=instance_create(view_xview[0]+480+random_range(16,480),view_yview[0]-16,oSnowflake)
  }
  else
  {
    tSnow=instance_create(view_xview[0]-random_range(16,480),view_yview[0]-16,oSnowflake)
  }
  tSnow.type=1; tSnow.image_index=irandom_range(0,2)
  snowSpawn=0
}
