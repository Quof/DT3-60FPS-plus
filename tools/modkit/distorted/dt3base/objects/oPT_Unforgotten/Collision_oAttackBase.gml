if attackCycle=1 and global.stJGame_C[0]>4000
{
  resType[0]=5
  event_inherited()
  resType[0]=3
}
else {event_inherited()}
