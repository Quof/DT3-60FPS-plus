//Randomizer: the ways into rooms kept for a Teleport Trap, read back from the save (argument0: rndSnareHistString's
//string): a room that isn't there any more is left out
var s,e,c1,c2,tR;
s=argument0
global.rndSnareHistN=0
while string_length(s)>0
{
  e=string_pos(";",s)
  if e=0 {e=string_length(s)+1}
  c1=string_pos(",",s)
  if c1>0 and c1<e
  {
    c2=c1+string_pos(",",string_copy(s,c1+1,e-c1-1))
    if c2>c1
    {
      tR=real(string_copy(s,1,c1-1))
      if room_exists(tR) and global.rndSnareHistN<400
      {
        global.rndSnareHistR[global.rndSnareHistN]=tR
        global.rndSnareHistX[global.rndSnareHistN]=real(string_copy(s,c1+1,c2-c1-1))
        global.rndSnareHistY[global.rndSnareHistN]=real(string_copy(s,c2+1,e-c2-1))
        global.rndSnareHistN+=1
      }
    }
  }
  s=string_delete(s,1,e)
}
