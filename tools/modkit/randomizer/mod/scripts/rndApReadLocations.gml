//Randomizer, Archipelago: what this world's locations hold, from the client's locations.txt when it's this game's (lines
//"<location id>|<this world's 0/1>|<item id, 0 if another world's>|<item name>|<player it's for>|<flags>"): into
//global.rndApLocKnown/Own/Item/Name/Player/Flags, by location number. Returns 1 when read
var f,l,id,t,o,L;
if !file_exists(global.rndApPath+"locations.txt") {return 0}
f=file_text_open_read(global.rndApPath+"locations.txt")
l=file_text_read_string(f)
file_text_readln(f)
if l!=global.rndApSeedLine {file_text_close(f); return 0}
while !file_text_eof(f)
{
  l=file_text_read_string(f)
  file_text_readln(f)
  if rndApSplit(l)>=6
  {
    id=real(global.rndApPart[0])-global.rndApBase
    t=id div 1000
    o=id mod 1000
    if t>=1 and t<=18 and o>=0 and o<=130
    {
      L=global.rndLocOf[t,o]
      if L>=0
      {
        global.rndApLocKnown[L]=1
        global.rndApLocOwn[L]=real(global.rndApPart[1])
        global.rndApLocItem[L]=real(global.rndApPart[2])
        global.rndApLocName[L]=global.rndApPart[3]
        global.rndApLocPlayer[L]=global.rndApPart[4]
        global.rndApLocFlags[L]=real(global.rndApPart[5])
      }
    }
  }
}
file_text_close(f)
global.rndApLocLoaded=1
return 1
