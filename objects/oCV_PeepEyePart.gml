#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
hoverAlpha=-1
bActive=true

//Enemy base statistics
eName="Peeping Eye Tail"
eLevel=14
maxLife=380
life=maxLife
pointWorth=20
atkPower=5

jeremyText="It's just the tail of the Peeping Eye. It sends energy to the end of it and when it builds up enough, it fires the energy toward you. Said energy will break apart after awhile."
chaoText="Eww, so gross! The way it just... ugh."
devText="Continuing on from the eye text...#What truly made the harder settings in DT1 harsh were the extra traps and more specifically, the sped up boss encounters. I didn't want the other settings to just be basic stat changes, I feel that's not truly making things harder, it's just using artificial methods. In a game about skill, it shouldn't be about numbers."
extraInfo="Completely immune to damage."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ownerID.image_blend,image_alpha)
