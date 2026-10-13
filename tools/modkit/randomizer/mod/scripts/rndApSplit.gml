//Randomizer, Archipelago: splits a line of the DT3+ Client's files at its | into global.rndApPart[0...] (argument0: the
//line). Returns how many parts
var s,n,p;
s=argument0
n=0
while 1
{
  p=string_pos("|",s)
  if p=0 {global.rndApPart[n]=s; n+=1; break}
  global.rndApPart[n]=string_copy(s,1,p-1)
  n+=1
  s=string_delete(s,1,p)
}
return n
