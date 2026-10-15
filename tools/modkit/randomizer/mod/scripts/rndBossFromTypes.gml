//Randomizer: a save's beaten bosses (argument0: a character a boss, "1" beaten) in the order of the boss list it was
//made with (argument1: its types, comma-separated, a comma each side), in this build's (global.rndBossType). A boss
//that list doesn't have isn't beaten yet; one this build doesn't have is left out
var i,p,tOut;
tOut=""
for(i=0;i<global.rndBossN;i+=1)
{
  p=string_pos(","+string(global.rndBossType[i])+",",argument1)
  //(its place in the save's list: the commas up to the one before it)
  if p>0 and string_char_at(argument0,string_count(",",string_copy(argument1,1,p)))="1" {tOut+="1"}
  else {tOut+="0"}
}
return tOut
