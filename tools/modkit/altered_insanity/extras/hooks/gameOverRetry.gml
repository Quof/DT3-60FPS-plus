//Retrying after a game over in one of Altered Insanity's boss challenges goes back to where the challenge was started
//(oGameOver; returns 1 when it has sent the player somewhere).
if global.inBossChallenge
{
  global.bossTrack=0
  global.newMapX=global.Cousinoer5HUBX
  global.newMapY=global.Cousinoer5HUBY
  room_goto(global.Cousinoer5ReturnRoom)
  return 1
}
return 0
