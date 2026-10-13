//Altered Beast's title screen code (argument0: the code typed). [alterme]: start the game with every piece of
//equipment, altered
var i;
if argument0="alterme"
{
  if global.alterEquip=0
  {
    global.alterEquip=1
    global.equipItems="1111111111111111111111111111111111111111"
    for(i=0;i<3;i+=1)
    {
      global.equipJerry[i]=0
      global.equipClaire[i]=0
    }
    show_message("[Altered Mode] Activated!##Start the game with all the equip items in their altered form. Master new item synergies or equip brutal curses to play the game as it's never been played before!")
  }
  else
  {
    show_message("You have already been altered, pray I do not alter you further...")
  }
}
//[earthshiftisbroken] (Nightmare Mode) gives the equipment found by the end of the game: altered, all of it stays (as the
//original; the game's own code for that code has run already)
if argument0="earthshiftisbroken" and global.alterEquip=1
{
  global.equipItems="1111111111111111111111111111111111111111"
}
