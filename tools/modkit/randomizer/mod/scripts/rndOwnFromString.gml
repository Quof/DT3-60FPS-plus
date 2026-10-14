//Randomizer: the abilities found (global.rndOwn) from the save file's string (argument0; one saved before the Varia
//Suit was an item is a digit shorter: none of it)
var i,c;
for(i=0;i<13;i+=1)
{
  global.rndOwn[i]=0
  c=string_char_at(argument0,i+1)
  if c!="" {global.rndOwn[i]=real(c)}
}
