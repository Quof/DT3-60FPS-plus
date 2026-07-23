if global.location!=49
{
  global.metCheckpoint[0]=room
  global.metCheckpoint[1]=368
  global.metCheckpoint[2]=288
}

locationCheck(49)
global.desertHeat=1500

if global.metJumpUpgrade=1 {oPlayer1.initialJumpAcc=-7.8; oPlayer1.jumpTimeTotal=28}
else if global.metJumpUpgrade=2 {oPlayer1.initialJumpAcc=-9.4; oPlayer1.jumpTimeTotal=35}

if global.gameProgress=2660 {global.gameProgress=2670}

if global.hasAbilToken[4]=1 and global.gameProgress<=3060
{
  global.canCharSwap=1
  charSwitcher(1)
  global.hasAbilToken[2]=1
  global.activeAbility[1]=2
  global.hasShoes[2]=1; global.hasShoes[3]=1
  if global.gameProgress>=2770 {global.hasShoes[2]=2} //Dash
  if global.gameProgress>=2830 {global.hasShoes[3]=2} //Air Dash

  if global.gameProgress<=2680 //Beam
    global.hasAbilToken[4]=2
  else if global.gameProgress>=2700 and global.gameProgress<=2740 //Morph Ball
    global.hasAbilToken[4]=3
  else if global.gameProgress>=2750 and global.gameProgress<=2780 //Charge Beam
    global.hasAbilToken[4]=4
  else if global.gameProgress=2790 //Missile
    global.hasAbilToken[4]=5
  else if global.gameProgress=2800 //Spazer Beam
    global.hasAbilToken[4]=6
  else if global.gameProgress>=2810 and global.gameProgress<=2859 //Bomb
    global.hasAbilToken[4]=7
  else if global.gameProgress>=2860 //Missile Upgrade
    global.hasAbilToken[4]=8
}

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress>=2680
{
  var tempMplay;
  tempMplay=findMusic(501)
  playMusic(tempMplay,0,0)
}

musicUnload(0)
