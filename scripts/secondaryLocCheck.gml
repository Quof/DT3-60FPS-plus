/*
Updates the secondary locations the player has discovered.
argument0: location type
argument1: location index
*/
var tExtLocType,tNewExtLoc,mapExtCheck;
tExtLocType=argument0
tNewExtLoc=argument1

if tExtLocType=2 //G2 - Forest Temple
{
  mapExtCheck=string_char_at(global.mapExt2,tNewExtLoc)
  if mapExtCheck="0"
  {
    var tNewString;
    tNewString=string_delete(global.mapExt2,tNewExtLoc,1)
    tNewString=string_insert("1",tNewString,tNewExtLoc)
    global.mapExt2=tNewString
  }
}
else if tExtLocType=3 //G2 - Water Temple
{
  mapExtCheck=string_char_at(global.mapExt3,tNewExtLoc)
  if mapExtCheck="0"
  {
    var tNewString;
    tNewString=string_delete(global.mapExt3,tNewExtLoc,1)
    tNewString=string_insert("1",tNewString,tNewExtLoc)
    global.mapExt3=tNewString
  }
}
