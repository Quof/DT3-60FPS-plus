//Randomizer, Archipelago: the items received since last time (the client's items.txt, this game's: every item received,
//in the server's order; global.rndApRecv of them given already). One at a time with its message, or all at once when
//more are waiting. Not while the game's paused, the player's dying or between rooms of a boss fight.
//The first time after the game starts or is loaded (rndApNMSeen, rndApStart): a Nightmare ability received before
//that the player hasn't got (the builds before this one's rndApGive left their kind, 28, out, counting them received)
//is given then
var f,l,n,i,tNew,tLine,tOldN,tOld,tId,tGot;
if global.gamePaused=true or !instance_exists(oPlayer1) or instance_exists(oGameOver) or room=rBossGallery {exit}
if !file_exists(global.rndApPath+"items.txt") {exit}
f=file_text_open_read(global.rndApPath+"items.txt")
l=file_text_read_string(f)
file_text_readln(f)
if l!=global.rndApSeedLine {file_text_close(f); exit}
n=0
tNew=0
tOldN=0
while !file_text_eof(f)
{
  l=file_text_read_string(f)
  file_text_readln(f)
  if l!=""
  {
    if n>=global.rndApRecv {tLine[tNew]=l; tNew+=1}
    else if global.rndApNMSeen=0 {tOld[tOldN]=l; tOldN+=1}
    n+=1
  }
}
file_text_close(f)
if global.rndApNMSeen=0
{
  global.rndApNMSeen=1
  tGot=0
  for(i=0;i<tOldN;i+=1)
  {
    if rndApSplit(tOld[i])>=3
    {
      tId=real(global.rndApPart[0])-global.rndApBase
      if tId div 10000=28
      {
        if global.rndOwn[13+(tId mod 10000)]=0
        {
          global.rndMsgQuiet=1
          rndGiveKP(28,tId mod 10000)
          global.rndMsgQuiet=0
          tGot+=1
        }
      }
    }
  }
  if tGot=1 {rndMsg("Received a Nightmare ability#found earlier in the multiworld!",2)}
  else if tGot>1 {rndMsg("Received "+string(tGot)+" Nightmare abilities#found earlier in the multiworld!",2)}
}
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
