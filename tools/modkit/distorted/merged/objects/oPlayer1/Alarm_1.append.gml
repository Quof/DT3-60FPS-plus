//-------------------- spsp ns Sword messages ----
if global.bossTrack=0 and global.rmDeaths mod 3=1 //spsp ns
{
  if (global.activeCharacter=0 and (global.equipJerry[0]=1 or global.equipJerry[1]=1 or global.equipJerry[2]=1)) or (global.activeCharacter=1 and (global.equipClaire[0]=1 or global.equipClaire[1]=1 or global.equipClaire[2]=1))
  {
    var rng, advice;
    rng=irandom(40)
    if rng<10 {advice="Have you tried bomb jumps?"}
    else if rng<20 {advice="Don't forget about bomb stalls."}
    else if rng<30 {advice="Hold jump to fall slowly after a bonk."}
    else if rng<40 {advice="Morph ball mode can help sometimes."}
    else if rng=40 {advice="Maybe with frame perfect arrows..."}
    msgCreate(0,0,"Magic Sword",advice,0,1,oMessagePerson,0)
    newMessage.fadingTime=120
  }
}
