#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Used for the Stalker segment in Neo Grime
//Lights: Player, Room lights
surf=surface_create(room_width,room_height)
surface_set_target(surf)
draw_clear(c_black)
surface_reset_target()
sizeMod=0
bSizeUp=false
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bSizeUp=false
{
  sizeMod-=0.0005
  if sizeMod<=0 {bSizeUp=true}
}
else
{
  sizeMod+=0.0005
  if sizeMod>=0.02 {bSizeUp=false}
}

if surface_exists(surf)
{
  surface_set_target(surf)
  draw_clear_alpha(c_black,1)
  draw_set_blend_mode(bm_subtract)

  with oLC_Spotlights
  {
    draw_sprite_ext(sSurfSpotLightA,0,x,y,image_xscale+oSurfLightC.sizeMod,image_yscale+oSurfLightC.sizeMod,image_angle,c_white,0.8)
  }
  if instance_exists(oWepEf_Light)
  {
    with oWepEf_Light
    {
      draw_sprite_ext(sSurfOmniLightA,0,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
    }
  }

  with oInvisibleSolid
  {
    draw_sprite_ext(sInvisibleSolidMask,0,x,y,image_xscale,image_yscale,image_angle,c_white,0.03)
  }

  draw_set_blend_mode(bm_normal)
  if collision_rectangle(oPlayer1.x-6,oPlayer1.y-1,oPlayer1.x+6,oPlayer1.y-oPlayer1.sprite_height-2,oLC_Spotlights,1,1)
  {
    draw_sprite_ext(oPlayer1.sprite_index,oPlayer1.image_index,oPlayer1.x,oPlayer1.y,oPlayer1.image_xscale,oPlayer1.image_yscale,0,c_red,0.35)
  }
  else
  {
    draw_sprite_ext(oPlayer1.sprite_index,oPlayer1.image_index,oPlayer1.x,oPlayer1.y,oPlayer1.image_xscale,oPlayer1.image_yscale,0,c_green,0.35)
  }
  surface_reset_target()
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(surf)
{
  surface_free(surf)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if surface_exists(surf)
{
  draw_surface(surf,0,0)
}
else
{
  surf=surface_create(room_width,room_height)
}
