//Evil Boss Gallery: the room of a boss's evil fight (argument0: the boss gallery's type, oBossGalleryDoor's), or -1
//while it has none (its door in the evil gallery is sealed)
var t;
t=argument0
if t=1 {return rEvgBowser}
if t=4 {return rEvgHelmet}
if t=14 {return rEvgDeath}
return -1
