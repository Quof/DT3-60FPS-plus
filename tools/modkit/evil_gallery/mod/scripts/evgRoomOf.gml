//Evil Boss Gallery: the room of a boss's evil fight (argument0: the boss gallery's type, oBossGalleryDoor's; argument1:
//the door's own room for it): the mod's copy for the first three (evgKind 1), the game's own for the rest (2), or -1
//while it has none (its door in the evil gallery is sealed)
var t;
t=argument0
if t=1 {return rEvgBowser}
if t=4 {return rEvgHelmet}
if t=14 {return rEvgDeath}
if evgKind(t)=2 {return argument1}
return -1
