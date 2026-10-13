//Randomizer, Archipelago: the time of the newest DeathLink death in the client's death_in.txt ("<time in ms>|<cause>"
//after this game's seed line), 0 if none; its cause in global.rndApDeathCause
var f,l,t;
t=0
global.rndApDeathCause=""
if !file_exists(global.rndApPath+"death_in.txt") {return 0}
f=file_text_open_read(global.rndApPath+"death_in.txt")
l=file_text_read_string(f)
file_text_readln(f)
if l=global.rndApSeedLine
{
  l=file_text_read_string(f)
  if rndApSplit(l)>=2 {t=real(global.rndApPart[0]); global.rndApDeathCause=global.rndApPart[1]}
}
file_text_close(f)
return t
