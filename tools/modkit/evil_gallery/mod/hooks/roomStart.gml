//Evil Boss Gallery: every room's start. An evil fight given up from the game over screen goes back to the Boss Gallery
//(oGameOver, by the boss's name, to the boss's door): to the evil gallery instead, at the same place (it's that room's
//copy)
if room=rBossGallery and global.evgFight>0
{
  global.evgFight=0
  transition_kind=0
  room_goto(rEvgGallery)
}
