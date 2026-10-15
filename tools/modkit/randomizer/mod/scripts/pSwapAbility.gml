//Randomizer: the mod's version of the game's pSwapAbility (the ability swap button: the character's next ability set),
//which runs in its place (one of the scripts a mod can replace: Mods\README.txt). In a Randomizer game it goes round
//the sets the player has, in the game's order (Jerry: Link, Mega Man, his Game Powers; Claire: Belmont, Samus, her Game
//Powers), skipping any they haven't found and the Game Powers where they don't work (out of Gate 6: their token is 1,
//rndAbilApply). The game's own goes from Link only to Mega Man (and from Belmont only to Samus), and in Gate 6 won't
//leave the Game Powers (its own loadout there, which a Randomizer game doesn't keep): with the sets found in any order,
//that could leave a set out of reach. Otherwise (no Randomizer game, tower defense's Defender, The Executive's fight,
//Jeremy's mech and the other characters) the game's own does it: this version stands aside for the call
//(global.modOvr; "pSwapAbility (" with the space is the game's script, scrModFixCode)
var tOvr,c,a,k,n,tTok;
if global.rndActive=0 or global.bTowerDefense>0 or global.activeCharacter>1 or rndExecFight()
{
  tOvr=global.modOvr[pSwapAbility]
  global.modOvr[pSwapAbility]=-1
  pSwapAbility ()
  global.modOvr[pSwapAbility]=tOvr
  exit
}
idleTime=0
c=global.activeCharacter
a=global.activeAbility[c]
if a<1 or a>3 {a=3} //(none or another: the next is the first)
tTok=0
n=a
for(k=1;k<=3;k+=1)
{
  n=((a-1+k) mod 3)+1
  //(the set's token: Jerry's 1 Link, 3 Mega Man, 5 Game; Claire's 2 Belmont, 4 Samus, 6 Game)
  if c=0 {tTok=global.hasAbilToken[n*2-1]}
  else {tTok=global.hasAbilToken[n*2]}
  if tTok>=2 {break}
}
if tTok>=2 and n!=global.activeAbility[c]
{
  global.activeAbility[c]=n
  scrSwapEffect()
}
