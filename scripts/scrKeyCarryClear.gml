/*
key carry change (added): goes right after every io_clear(). io_clear makes GM forget every held key; this makes the
left/right keys carried through a screen transition (scrKeyCarry) forgotten too, the same as any other key.
*/
var i;
for(i=0;i<256;i+=1)
{
  global.kbCarry[i]=0
  global.kbWasHeld[i]=0
}
