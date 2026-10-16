//Evil Boss Gallery: its part of the save file (the save file is open): the records back (the save hook's lists). A
//save from before the mod has none (the init hook's)
var s,i,tT,tH,tW,p;
s="EvilGallery"
tT=ini_read_string(s,"time","")
tH=ini_read_string(s,"hits","")
tW=ini_read_string(s,"wins","")
for(i=0;i<70;i+=1)
{
  p=string_pos(",",tT)
  if p>0 {global.evgTime[i]=real(string_copy(tT,1,p-1)); tT=string_delete(tT,1,p)}
  p=string_pos(",",tH)
  if p>0 {global.evgHits[i]=real(string_copy(tH,1,p-1)); tH=string_delete(tH,1,p)}
  p=string_pos(",",tW)
  if p>0 {global.evgWins[i]=real(string_copy(tW,1,p-1)); tW=string_delete(tW,1,p)}
}
global.evgFight=0
