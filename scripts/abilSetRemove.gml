/*
This script checks which abilities have been earned and sets them back to an active state or inactive state.
argument0: Whether to set active or inactive
-- 0: Set abilities active
-- 1: Set abilities inactive
*/
var tAbilSet;
tAbilSet=argument0

if tAbilSet=0 //Set active
{
  for(i=0;i<4;i+=1)
  {
    if global.hasShoes[i]=1 {global.hasShoes[i]=2}
  }

  if global.canCharSwap=1 {global.canCharSwap=2}
  if global.canDoubleJump=1
  {
    if global.gameProgress>=3870 {global.canDoubleJump=2}
  }

  //----- Set abilities -----
  if global.hasAbilToken[0]>=1 and global.gameProgress>=510 {global.hasAbilToken[0]=2}
  if global.hasAbilToken[1]>=1 and global.gameProgress>=910 {global.hasAbilToken[1]=5}
  if global.hasAbilToken[2]>=1 and global.gameProgress>=1520 {global.hasAbilToken[2]=5}
  if global.hasAbilToken[3]>=1 and global.gameProgress>=1990 {global.hasAbilToken[3]=5}
  if global.hasAbilToken[4]>=1 and global.gameProgress>=3050 {global.hasAbilToken[4]=8}

  //Set Gate 6 abilities to inactive state so they are not usable outside of Gate 6
  if global.hasAbilToken[5]>=2
  {
    if global.activeAbility[0]=3 {global.activeAbility[0]=1}
    global.hasAbilToken[5]=1
  }
  if global.hasAbilToken[6]>=2
  {
    if global.activeAbility[1]=3 {global.activeAbility[1]=1}
    global.hasAbilToken[6]=1
  }

  //-------------------------

  if global.hasAbilToken[1]>=2 and global.activeAbility[0]=0 {global.activeAbility[0]=1}
  if global.hasAbilToken[2]>=2 and global.activeAbility[1]=0 {global.activeAbility[1]=1}
}
else if tAbilSet=1 //Set inactive
{
  for(i=0;i<4;i+=1)
  {
    if global.hasShoes[i]=2 {global.hasShoes[i]=1}
  }

  if global.canCharSwap=2 {global.canCharSwap=1}
  if global.canDoubleJump=2 {global.canDoubleJump=1}

  for(i=0;i<7;i+=1)
  {
    if global.hasAbilToken[i]>=2 {global.hasAbilToken[i]=1}
  }
  global.activeAbility[0]=0
  global.activeAbility[1]=0
}
