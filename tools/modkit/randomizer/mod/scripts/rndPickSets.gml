//Randomizer: each character's active ability set is one the player has. Jerry: 1 Link (hasAbilToken 1), 2 Mega Man (3),
//3 Gate 6's (5); Claire: 1 Belmont (2), 2 Samus (4), 3 Gate 6's (6); 0 is neither (the base attacks)
var a;
a=global.activeAbility[0]
if (a=1 and global.hasAbilToken[1]<2) or (a=2 and global.hasAbilToken[3]<2) or (a=3 and global.hasAbilToken[5]<2) {a=0}
if a=0
{
  if global.hasAbilToken[1]>=2 {a=1}
  else if global.hasAbilToken[3]>=2 {a=2}
}
global.activeAbility[0]=a
a=global.activeAbility[1]
if (a=1 and global.hasAbilToken[2]<2) or (a=2 and global.hasAbilToken[4]<2) or (a=3 and global.hasAbilToken[6]<2) {a=0}
if a=0
{
  if global.hasAbilToken[2]>=2 {a=1}
  else if global.hasAbilToken[4]>=2 {a=2}
}
global.activeAbility[1]=a
