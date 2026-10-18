//Randomizer: the game's check of one place's item having been taken, its place in the game's string for its kind
//(argument0: the string, argument2: the place's objectNum), "1" or "0". In a randomizer game those strings count the
//items the player has, filled in their own order (rndMarkNext), so there it's whether that place, a location
//(argument1: its location type), is taken. Otherwise, or for a place that isn't a location, the game's own
var tLoc;
if global.rndActive=1
{
  tLoc=rndLocFind(argument1,argument2)
  if tLoc>=0
  {
    if rndIsGot(tLoc) {return "1"}
    return "0"
  }
}
return string_char_at(argument0,argument2)
