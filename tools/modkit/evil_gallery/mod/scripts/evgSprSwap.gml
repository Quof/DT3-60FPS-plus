//Evil Boss Gallery: the sprites of the evil fight of type argument0 recoloured (evgSprList, the build's list for each
//fight), if they aren't yet (a Retry keeps them)
if global.evgSprType=argument0 {exit}
evgSprRestore()
global.evgSprType=argument0
evgSprList(argument0)
