if atkPhase=2
{
    if false //global.stJGame_C[0]>4000
    {
        resType[0]=4
        event_inherited()
        resType[0]=3
    }
    else {event_inherited()}
}
else if atkPhase=3 //invulnerable
{
}
else if atkPhase=4 //mixed //spsp
{
    if cycleCounter>0 and other.damageType="NORMAL" and chatcool=0
    {
        chatcool=15
    }
    else if lastParryChar=0 and cycleCounter>0 //Jerry parried apples
    {
        resType[3]=4 - (bossProgress-1)
        resType[0]=4 - (bossProgress-1)
        event_inherited()
        resType[0]=1
        resType[3]=1
    }
    else if lastParryChar=1 and cycleCounter>0 //Claire parried a melee attack
    {
        resType[3]=5
        resType[0]=3
        event_inherited()
        resType[3]=1
        resType[0]=1
    }
    else {event_inherited()}
}
/*else if atkPhase=5
{
    if global.stJGame_C[0]>4000
    {
        resType[5]=4
        event_inherited()
        resType[5]=3
    }
    else {event_inherited()}
}*/
/*else if atkPhase=6
{
  if global.stJGame_C[0]>4000
  {
    if phase6_phase<=3 {resType[3]=2}
    resType[0]=3
    event_inherited()
    resType[0]=phase6_normalRes
    resType[3]=1
  }
  else {event_inherited()}
}*/
else {event_inherited()}
