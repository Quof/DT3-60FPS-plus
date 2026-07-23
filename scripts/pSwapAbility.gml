//This script swaps abilities

idleTime=0
var tSwapValid;
tSwapValid=0
if global.activeCharacter=0 //---------- Jerry ----------
{
  if global.activeAbility[0]=1 and global.hasAbilToken[3]>=2 //----- Ability: Link -----
  {
    tSwapValid=1
    global.activeAbility[0]=2 //To Mega Man
  }
  else if global.activeAbility[0]=2 //----- Ability: Mega Man -----
  {
    if global.hasAbilToken[5]>=2
    {
      tSwapValid=1
      global.activeAbility[0]=3 //To Game
    }
    else
    {
      if global.hasAbilToken[1]>=2
      {
        tSwapValid=1
        global.activeAbility[0]=1 //To Link
      }
    }
    if global.bTowerDefense>0
    {
      tSwapValid=1
      global.activeAbility[0]=4 //To Defender
    }
  }
  else if global.activeAbility[0]=3 //----- Ability: Game -----
  {
    if global.location!=58 and global.location!=76 and global.location!=107
    {
      tSwapValid=1
      global.activeAbility[0]=1 //To Link
    }
  }
  else if global.activeAbility[0]=4 //----- Ability: Defender -----
  {
    tSwapValid=1
    global.activeAbility[0]=1 //To Link
  }
}
else //---------- Claire ----------
{
  if global.activeAbility[1]=1 and global.hasAbilToken[4]>=2 //----- Ability: Belmont -----
  {
    tSwapValid=1
    global.activeAbility[1]=2 //To Samus
  }
  else if global.activeAbility[1]=2 //----- Ability: Samus -----
  {
    if global.hasAbilToken[6]>=2
    {
      tSwapValid=1
      global.activeAbility[1]=3 //To Game
    }
    else
    {
      if global.hasAbilToken[2]>=2
      {
        tSwapValid=1
        global.activeAbility[1]=1 //To Belmont
      }
    }
    if global.bTowerDefense>0
    {
      tSwapValid=1
      global.activeAbility[1]=4 //To Defender
    }
  }
  else if global.activeAbility[1]=3 //----- Ability: Game -----
  {
    if global.location!=58 and global.location!=76 and global.location!=107
    {
      tSwapValid=1
      global.activeAbility[1]=1 //To Belmont
    }
  }
  else if global.activeAbility[1]=4 //----- Ability: Defender -----
  {
    tSwapValid=1
    global.activeAbility[1]=1 //To Belmont
  }
}

if tSwapValid=1
{
  scrSwapEffect()
}
