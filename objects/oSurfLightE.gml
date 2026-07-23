#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Lights: Player, Chao, Castle torch, Platforms
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
  sizeMod-=0.002
  if sizeMod<=0 {bSizeUp=true}
}
else
{
  sizeMod+=0.002
  if sizeMod>=0.07 {bSizeUp=false}
}

if surface_exists(surf)
{
  surface_set_target(surf)
  draw_clear_alpha(c_black,1)
  draw_set_blend_mode(bm_subtract)
  draw_sprite_ext(sSurfOmniLightA,0,oPlayer1.x,oPlayer1.y-26,1.75+sizeMod,1.75+sizeMod,0,c_white,1)
  draw_sprite_ext(sSurfOmniLightA,0,oIdentifier.x,oIdentifier.y,1.75+sizeMod,1.75+sizeMod,0,c_white,1)
  with oCastlePlatMaker
  {
    draw_sprite_ext(sSurfOmniLightA,0,x,y,1.25+oSurfLightE.sizeMod,1.25+oSurfLightE.sizeMod,0,c_white,0.8)
  }
  with oMCastle_PlatA
  {
    draw_sprite_ext(sSurfOmniLightA,0,x,y,1.5+oSurfLightE.sizeMod,1.5+oSurfLightE.sizeMod,0,c_white,0.8)
  }
  with oMCastle_PlatB
  {
    draw_sprite_ext(sSurfOmniLightA,0,x,y,1.25+oSurfLightE.sizeMod,1+oSurfLightE.sizeMod,0,c_white,0.75)
  }
  with oMCastle_TorchA
  {
    draw_sprite_ext(sSurfOmniLightA,0,x,y-4,1.33+oSurfLightE.sizeMod,1.33+oSurfLightE.sizeMod,0,c_white,0.9)
  }
  if instance_exists(oWepEf_Light)
  {
    with oWepEf_Light
    {
      draw_sprite_ext(sSurfOmniLightA,0,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
    }
  }
  surface_reset_target()
  draw_set_blend_mode(bm_normal)
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
