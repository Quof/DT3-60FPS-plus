#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myGrid=mp_grid_create(0,0,room_width/16,room_height/16,16,16)
mp_grid_add_instances(myGrid,oSolid,1)

updateCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if global.gamePaused=false
{
  //Update grid
  //updateCheck+=1
  updateCheck+=1*gDeltaTime //60fps change: the grid was rebuilt from every solid every 30 frames, 2x/4x as often at 60/120fps
  if updateCheck>=30
  {
    mp_grid_clear_all(myGrid)
    mp_grid_add_instances(myGrid,oSolid,1)
    updateCheck=0
  }
}
