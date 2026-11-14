//Evil Boss Gallery: every room's start. An evil fight given up from the game over screen goes back to the Boss Gallery
//(oGameOver, by the boss's name, to the boss's door): to the evil gallery instead, at the same place (the two have the
//same layout), with the gallery's records and the game's sprites as they were. An evil fight in the game's own room
//(evgKind 2) gets its controller there (oEvgFight); anywhere else the sprites are put back
if global.evgFight>0
{
  if room=rBossGallery
  {
    evgRecRestore()
    evgSprRestore()
    global.evgFight=0
    transition_kind=0
    room_goto(rEvgGallery)
  }
  else if evgKind(global.evgFight)=2
  {
    if room=global.evgRoom {instance_create(0,0,oEvgFight)}
    else {evgSprRestore()}
  }
}
else if global.evgSprN>0 {evgSprRestore()}
