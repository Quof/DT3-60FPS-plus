//Randomizer: a code typed on the title screen (argument0: the code). 'seed' and a number: the next new game uses that
//seed. 'ap': the next new game is an Archipelago game, or not again (the DT3+ Client must be connected when it starts)
var c;
c=string_lower(argument0)
if c="ap"
{
  global.rndApNext=1-global.rndApNext
  if global.rndApNext=1 {show_message("Randomizer: the next new game is an Archipelago game. Start the DT3+ Client from the Archipelago Launcher and connect it to your multiworld before starting it.")}
  else {show_message("Randomizer: the next new game is a Randomizer game on its own.")}
  return 1
}
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
