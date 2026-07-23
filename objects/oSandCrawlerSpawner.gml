#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y+=4
if global.gameOptDT>=3 {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if !instance_exists(oSandCrawler)
    instance_create(oPlayer1.x,y+26,oSandCrawler)
}
