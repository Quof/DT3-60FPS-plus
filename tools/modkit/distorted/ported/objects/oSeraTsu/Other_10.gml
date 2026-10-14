//End attack
sprite_index=sSeraIdle
actTime=0
actCheck=0

atkNum+=1
waitTime=waitDelay-12

if atkNum>=atkMax
{
  moveType+=1
  if moveType=4 {moveType=0}
  roundNum+=1
  bigBlockChk+=1
  waitTime=0; atkNum=0
}
