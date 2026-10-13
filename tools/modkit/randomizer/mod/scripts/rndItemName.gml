//Randomizer: an item's name (argument0: the item's number). An ability set's item is named as a progressive one (which
//level it gives depends on how many the player has: rndGive names that one)
var k,p;
k=global.rndItemKind[argument0]
p=global.rndItemParam[argument0]
switch (k)
{
  case 1: return "Heart Piece"
  case 2: return string(p)+" Internetz"
  case 3: equipmentInit(2,p); return equipCheck[1]
  case 4: return "Arrow Quiver"
  case 5: return "Heart Energy Expansion"
  case 6: return "Missile Expansion"
  case 7: return "Game Power"
  case 8: return "Air Upgrade"
  case 9: return "Internetz Mod"
  case 10: return "Weapon Upgrade: "+rndWeaponName(p)
  case 11: return "Skill Point"
  case 12: return "Bomb Upgrade"
  case 13: return "Morph Bomb Upgrade"
  case 14: return "Key (its door: "+global.rndDoorPlace[p]+")"
  case 15: return "Heart Container"
  case 16: return "Item Finder"
  case 17: return "X-Special Charge"
  case 18: return "Spring Ball"
  case 19: return "Jump"
  case 20: return "Dash"
  case 21: return "Air Dash"
  case 22: return "Double Jump"
  case 23: return "High Jump Boots (progressive)"
  case 24:
    if p=0 {return "Mario Ability Set"}
    if p=1 {return "Link ability (progressive)"}
    if p=2 {return "Belmont ability (progressive)"}
    if p=3 {return "Mega Man ability (progressive)"}
    if p=4 {return "Samus ability (progressive)"}
    if p=5 {return "Jerry's Game Powers (progressive)"}
    return "Claire's Game Powers (progressive)"
}
return "?"
