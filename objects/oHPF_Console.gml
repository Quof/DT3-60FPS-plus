#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//If type=2 - requires: turMax

screenFrm=0
bActivate=0
turretProg=0

myInfectSpot=instance_create(x,y-16,oHPF_ConInfect)
myInfectSpot.myOwner=id
alarm[0]=1 //gid order change (added): see Alarm 0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gid order change (added): the creation code looks up what this console controls (controlID, turID) with GID, but
//the bridge/door/turrets can come later in the room's order and register themselves (GID_SET) after it. On the room's
//first visit the lookup found no one, so infecting the console did nothing (later visits found the previous visit's
//ids, which happened to match). Looked up again here, once every instance in the room exists
if variable_local_exists("controlCache") {controlID=GID(controlCache)}
if type=2 and variable_local_exists("controlCache") //(rooms set turCache with controlCache; checked by the plain variable)
{
  for(i=0;i<turMax;i+=1) {turID[i]=GID(turCache[i])}
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  screenFrm+=0.25*gDeltaTime
  if bActivate=1
  {
    if type=0 //Energy bridge
    {
      image_blend=make_color_rgb(200,255,200)
      with controlID
      {
        instance_destroy()
      }
      bActivate=2
    }
    else if type=1 //Door
    {
      image_blend=make_color_rgb(200,255,200)
      if controlID.progCheck=0 {controlID.progCheck=1}
    }
    else if type=2 //Door & Laser Turrets
    {
      if turretProg=0 //Activate turrets and door
      {
        image_blend=make_color_rgb(200,255,200)
        if controlID.progCheck=0 {controlID.progCheck=1}
        for(i=0;i<turMax;i+=1)
        {
          with turID[i]
          {
            event_user(0)
          }
        }
        turretProg=1
      }
      else if turretProg=1 //Check if all turrets(enemies) are destroyed
      {
        var tTurCheck;
        tTurCheck=0
        for(i=0;i<turMax;i+=1)
        {
          if !instance_exists(turID[i]) {tTurCheck+=1}
        }
        if tTurCheck>=turMax
        {
          with controlID {instance_destroy()}
          turretProg=2
        }
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sHPF_ConScreen,screenFrm,x,y-26,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
