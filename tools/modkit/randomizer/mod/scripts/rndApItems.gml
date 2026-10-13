//Randomizer, Archipelago: the items received since last time (the client's items.txt, this game's: every item received,
//in the server's order; global.rndApRecv of them given already). One at a time with its message, or all at once when
//more are waiting. Not while the game's paused, the player's dying or between rooms of a boss fight
var f,l,n,i,tNew,tLine;
if global.gamePaused=true or !instance_exists(oPlayer1) or instance_exists(oGameOver) or room=rBossGallery {exit}
if !file_exists(global.rndApPath+"items.txt") {exit}
f=file_text_open_read(global.rndApPath+"items.txt")
l=file_text_read_string(f)
file_text_readln(f)
if l!=global.rndApSeedLine {file_text_close(f); exit}
n=0
tNew=0
while !file_text_eof(f)
{
  l=file_text_read_string(f)
  file_text_readln(f)
  if l!=""
  {
    if n>=global.rndApRecv {tLine[tNew]=l; tNew+=1}
    n+=1
  }
}
file_text_close(f)
if tNew=0 {exit}
if tNew>3
{
  global.rndMsgQuiet=1
  for(i=0;i<tNew;i+=1) {rndApGive(tLine[i],0)}
  global.rndMsgQuiet=0
  rndMsg("Received "+string(tNew)+" items from the multiworld!",1)
  exit
}
rndApGive(tLine[0],1)
