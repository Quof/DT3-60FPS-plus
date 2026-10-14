//End attack
sprite_index=sSeph_Idle
bFastAtk=0
actTime=0
actCheck=0
altAtk=0
if bossProgress>=3 {bFaster=1}

atkNum+=1
if atkNum>=atkMax
{
  atkNum=0
  waitTime=0
  meteor+=1
}
else
{
  waitTime=waitDelay-2
}
