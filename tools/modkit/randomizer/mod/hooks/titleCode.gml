//Randomizer: 'seed' and a number typed on the title screen: the next new game uses that seed (argument0: the code)
var c;
c=string_lower(argument0)
if string_copy(c,1,4)="seed" and string_length(c)>4
{
  var d;
  d=string_digits(string_copy(c,5,string_length(c)-4))
  if d!=""
  {
    global.rndNextSeed=real(d)
    show_message("Randomizer: the next new game uses seed "+string(global.rndNextSeed)+".")
    return 1
  }
}
return 0
