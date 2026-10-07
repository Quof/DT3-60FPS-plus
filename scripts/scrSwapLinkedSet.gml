/*
standard fixed change (added): Swap Type "Standard (Fixed)" (global.optSwapType=4): the Ability Sets are linked across
the characters, Link with Belmont (set 1) and Mega Man with Samus (2), also the Game sets (3) and Defender (4, tower
defense). Swapping characters gives the character being swapped to the set linked to the current character's, instead
of the one they were on last. If they don't have it, they get Link/Belmont, or no set if they don't have that either.
A set counts as theirs when its token is active (Defender: during tower defense), or when they're already on it (sets
that events put both characters on, like the Game sets in the boss gallery).
argument0: 0 = only find the set (oHUD shows it for the other character), 1 = also give it to them (right before
           pSwapCharacter)
returns that set (0 = none)
*/
var tTo,tSet,tGet,tTry,i,tHave;
if global.activeCharacter=0 {tTo=1}
else if global.activeCharacter=1 {tTo=0}
else {return 0} //not Jerry or Claire: no swapping
tSet=global.activeAbility[global.activeCharacter]
tGet=0
for(i=0;i<2;i+=1)
{
  if i=0 {tTry=tSet} //the linked set
  else {tTry=1}      //then Link/Belmont
  tHave=0
  if tTry=1 {tHave=(global.hasAbilToken[1+tTo]>=2)}      //Link 1, Belmont 2
  else if tTry=2 {tHave=(global.hasAbilToken[3+tTo]>=2)} //Mega Man 3, Samus 4
  else if tTry=3 {tHave=(global.hasAbilToken[5+tTo]>=2)} //Game 5, 6
  else if tTry=4 {tHave=(global.bTowerDefense>0)}         //Defender
  if tTry>=1 and tTry<=4 and global.activeAbility[tTo]=tTry {tHave=1}
  if tHave {tGet=tTry; break}
}
if argument0=1 {global.activeAbility[tTo]=tGet}
return tGet
