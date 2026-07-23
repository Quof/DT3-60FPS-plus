#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
decayTime=270
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decayTime-=1
  if decayTime mod 25=0 {playSound(global.snd_Cucco1,0,1,16000+random(12000))}
  if decayTime mod 6=0
  {
    var tChicken,tSpawnSide;
    tChicken=instance_create(x,y,oZChicken)
    tSpawnSide=choose(0,1)
    if tSpawnSide=0
    {
      tChicken.x=choose(view_xview[0]-9,view_xview[0]+view_wview[0]+9)
      tChicken.y=view_yview[0]-1+random(view_hview[0]+2)
    }
    else
    {
      tChicken.x=view_xview[0]-1+random(view_wview[0]+2)
      tChicken.y=choose(view_yview[0]-1,view_yview[0]+view_hview[0]+17)
    }
    tChicken.type=1
  }
  if decayTime<=0 {instance_destroy()}
}
