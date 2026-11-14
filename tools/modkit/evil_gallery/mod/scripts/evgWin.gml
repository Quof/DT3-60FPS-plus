//Evil Boss Gallery: an evil fight in the game's room won (oEvgFight, as the boss's defeat leaves for the Boss
//Gallery): the gallery's records back, the win the evil fight's, the sprites back, and to the evil gallery instead (the
//same place: the boss's door)
var t;
t=global.evgFight
evgRecRestore()
evgTallyRes(t)
evgSprRestore()
global.evgFight=0
room_goto(rEvgGallery)
