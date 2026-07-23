/*
This script checks the last 10 directional inputs from the player.

use: checkComboString(set)
argument0: If 0: set value; If 1: check string
1: Up
2: Down
3: Left
4: Right
*/

var tSetCheck;
tSetCheck=argument0

lastDirPress=8

if tSetCheck=0 //Set
{
  if kUpPressed=1 {myDirPress[dirPressIter]=1}
  if kDownPressed=1 {myDirPress[dirPressIter]=2}
  if kLeftPressed=1 {myDirPress[dirPressIter]=3}
  if kRightPressed=1 {myDirPress[dirPressIter]=4}

  if dirPressIter<10 {dirPressIter+=1}
  else
  {
    for(i=0;i<10;i+=1)
    {
      myDirPress[i]=myDirPress[i+1]
    }
  }
}
else if tSetCheck=1 //Check
{
  //Check Fireball
  var tFindFireball;
  tFindFireball=0
  for(i=0;i<10;i+=1) //Iterate through the last 10 key presses and check if any special moves were found
  {
    if tFindFireball=0 and myDirPress[i]=2 {tFindFireball=1; tInputBuffer=-1}
    else if tFindFireball=1 and (myDirPress[i]=3 or myDirPress[i]=4)
    {
      dirPressIter=0
      for(i=0;i<11;i+=1)
      {
        myDirPress[i]=0
      }
      jeremySpecMove=1
      tFindFireball+=1
    }
  }
}
