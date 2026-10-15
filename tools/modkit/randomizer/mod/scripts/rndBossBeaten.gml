//Randomizer: whether the boss of type argument0 is beaten, wherever its fight was (with Boss Rando, the place whose
//fight it was: rndBRFight); false for one that isn't the Randomizer's
var i,s;
for(i=0;i<global.rndBossN;i+=1)
{
  if global.rndBossType[i]=argument0
  {
    for(s=0;s<global.rndBossN;s+=1)
    {
      if global.rndBRFight[s]=i and string_char_at(global.rndBossDone,s+1)="1" {return true}
    }
    return false
  }
}
return false
