//The desert puzzle Altered Insanity adds to the Barrens' Twin Rocks room (rMain_45), at progress 1673: going through
//its doors in the right order (in oExit, as the player goes through it; argument0 is its exitType).
if argument0=0 and room=rMain_45 and global.cousinoer5Progress=1673
{
  if global.tempAction[0]=0 and desertDir=4 {global.tempAction[0]+=1}
  else if global.tempAction[0]=1 and desertDir=3 {global.tempAction[0]+=1}
  else if global.tempAction[0]=2 and desertDir=4 {global.tempAction[0]+=1}
  else if global.tempAction[0]=3 and desertDir=3 {global.tempAction[0]+=1}
  else if global.tempAction[0]=4 and desertDir=2 {global.tempAction[0]+=1}
  else if global.tempAction[0]=5 and desertDir=2 {global.tempAction[0]+=1}
  else if global.tempAction[0]=6 and desertDir=1 {global.tempAction[0]+=1}
  else if global.tempAction[0]=7 and desertDir=1
  {
    global.cousinoer5Progress=1763
  }
  else
  {
    global.tempAction[0]=0
    if desertDir=4 {global.tempAction[0]+=1}
  }
}
