#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Image Index
//0: Permanent
//1: Reset when map resets
//2: Water switch
sprite_index=sSwitchH_Icon
image_speed=0
image_blend=make_color_rgb(100,100,100)
activated=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("bSendActive")
{
  image_blend=c_white
  activated=1
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if activated=0 and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,1,1)
  image_blend=c_white
  if variable_local_exists("nextObjective")
    global.gameProgress=nextObjective
  if variable_local_exists("optionalFlag")
  {
    var tCheckFlags;
    tNewString=string_delete(global.extraFlags,optionalFlag,1)
    tNewString=string_insert("1",tNewString,optionalFlag)
    global.extraFlags=tNewString
    if optionalFlag=1 {with (261802) {instance_destroy()}} //Main 43
    else if optionalFlag=2 {with (393786) {instance_destroy()}} //Main 78
    else if optionalFlag=3 {with (395002) {instance_destroy()}} //Main 34
  }
  if variable_local_exists("sideFlag")
  {
    var tCheckFlags;
    tNewString=string_delete(global.gameOptShortcuts,sideFlag,1)
    tNewString=string_insert("1",tNewString,sideFlag)
    global.gameOptShortcuts=tNewString
    if sideFlag=1
    {
      tile_layer_show(999990)
      var tNewCol;
      tNewCol=instance_create(2576,1232,oInvisibleSolid); tNewCol.image_xscale=3
      tNewCol=instance_create(2640,1152,oInvisibleSolid); tNewCol.image_xscale=3
      tNewCol=instance_create(2704,1072,oInvisibleSolid); tNewCol.image_xscale=3
    }
    else if sideFlag=2
    {
      tile_layer_hide(999990)
      with (470408) {instance_destroy()}
    }
    else if sideFlag=3
    {
      tile_layer_show(999990)
      var tNewCol;
      tNewCol=instance_create(208,192,oInvisibleSolid); tNewCol.image_xscale=3
      tNewCol=instance_create(112,272,oInvisibleSolid); tNewCol.image_xscale=3
      tNewCol=instance_create(272,448,oInvisibleSolid); tNewCol.image_xscale=3
      tNewCol=instance_create(304,592,oInvisibleSolid); tNewCol.image_xscale=3
    }
  }
  activated=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sSwitchHolder,image_index,x,y)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
