//Randomizer: the hatch nearest where the player came into the room, if it's by them (within 128 px: Gate 5's ways in
//by a hatch's door are at most 120 from its hatch, the others 300 or more from any), opened as a shot opens one (gone,
//its holder no longer solid), whatever it takes (a sealed one too), so the player can go back out the way they came
var tDoor,tHolder;
tDoor=instance_nearest(x,y,oMetroidDoorColor)
if tDoor!=noone
{
  if point_distance(x,y,tDoor.x,tDoor.y)<=128
  {
    tHolder=tDoor.myHolder
    with (tDoor) {instance_destroy()}
    if instance_exists(tHolder) {tHolder.sprite_index=sNull}
  }
}
instance_destroy()
