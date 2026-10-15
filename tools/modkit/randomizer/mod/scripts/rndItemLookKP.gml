//Randomizer: makes the instance look like an item (argument0: its kind, argument1: its parameter): its sprite and frame.
//Ability items show their weapon's or boots' picture, tinted gold
var k,p;
k=argument0
p=argument1
image_speed=0.2
image_index=0
image_blend=c_white
switch (k)
{
  case 1: sprite_index=sHeartPiece; image_speed=0.16; break
  case 2: sprite_index=sCoin_1; break
  case 3: sprite_index=sEquipItemIcons; equipmentInit(2,p); image_index=equipCheck[4]; image_speed=0; break
  case 4: sprite_index=sArrowQuiver; image_speed=0.33; break
  case 5: sprite_index=sHeartEnergy; break
  case 6: sprite_index=sMissilePack; break
  case 7: sprite_index=sGamePower; break
  case 8: sprite_index=sAirUpgrade; break
  case 9: sprite_index=sWalletBoost; break
  case 10: sprite_index=sWeaponLevelPickup; image_index=p; image_speed=0; break
  case 11: sprite_index=sAPBoost; break
  case 12: sprite_index=sLinkBombUpgrade; break
  case 13: sprite_index=sMorphBombPickup; break
  case 14: sprite_index=sDoorKey; break
  case 15: sprite_index=sHeartContainer; break
  case 16: sprite_index=sItemFinderPickup; break
  case 17: sprite_index=sWeaponLevelPickup; image_index=6; image_speed=0; image_blend=make_color_rgb(120,190,255); break
  case 18: sprite_index=sMetPick_SpringBall; break
  case 19: sprite_index=sHiJumpBoots; image_speed=0; image_blend=make_color_rgb(255,220,120); break
  case 20: sprite_index=sDashBoots; image_speed=0; image_blend=make_color_rgb(255,220,120); break
  case 21: sprite_index=sDashBoots; image_speed=0; image_blend=make_color_rgb(150,210,255); break
  case 22: sprite_index=sDoubleJumpItem; image_speed=0; break
  case 23: sprite_index=sHiJumpBoots; image_index=1; image_speed=0; break
  case 25: sprite_index=sVariaPickup; image_speed=0.2; break
  case 26: sprite_index=sPauseM_Instruments; image_index=p-1; image_speed=0; break //(the instrument's own picture: oInstrument's)
  case 27: sprite_index=sPauseM_Chips; image_index=p-1; image_speed=0; break //(the chip's own picture: the pause menu's)
  case 24:
    sprite_index=sWeaponLevelPickup; image_speed=0; image_blend=make_color_rgb(255,220,120)
    if p=0 {sprite_index=sMarioQBlockN; image_index=0; image_speed=0.2; image_blend=c_white} //the Mario Ability Set: a ? block
    else if p=1 {image_index=0}
    else if p=2 {image_index=3}
    else if p=3 {image_index=6}
    else if p=4 {image_index=9}
    else {sprite_index=sGamePower; image_speed=0.2}
    break
}
