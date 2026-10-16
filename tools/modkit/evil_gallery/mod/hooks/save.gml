//Evil Boss Gallery: its part of the save file (the save file is open): the records, each a list of numbers (a place a
//gallery type) followed by commas
var s,i,tT,tH,tW;
s="EvilGallery"
tT=""
tH=""
tW=""
for(i=0;i<70;i+=1)
{
  tT+=string(global.evgTime[i])+","
  tH+=string(global.evgHits[i])+","
  tW+=string(global.evgWins[i])+","
}
ini_write_string(s,"time",tT)
ini_write_string(s,"hits",tH)
ini_write_string(s,"wins",tW)
