if global.optShowDamage<2
{
  global.optShowDamage+=2
}
oPlayer1.visible=0

bCanTakeDamage=true
damageTime=0

normalSpd=6
focusSpd=3
moveSpd=normalSpd
bFocus=0
hitBoxImgRot=0
swapDelay=0

bCanSuck=1
bSucking=0
suckMax=30
suckTime=suckMax
checkSuckSound=0

bCanUseWeapon=1
shotDelay=0
shotType=0
charJerryShot=0
charClaireShot=0

shotHP_Jerry=0
shotHP_Claire=0

charJerryShot=1 //drills
charClaireShot=3 //triple
defaultShotHP=20
maxShotHP=20
ammoPack=5
shotHP_Jerry=defaultShotHP
shotHP_Claire=defaultShotHP
if global.activeCharacter=0 {shotType=charJerryShot} else {shotType=charClaireShot}
//Also reduce max HP for each assist option. 2/1 hearts per (normal/nightmare)
//still needs to gain these on winning attempts
multiple=0
for(i=0;i<min(global.shooterProgress,4);i+=1)
{
  oDragoonShip.shipAssist[oDragoonShip.i]=instance_create(oDragoonShip.x,oDragoonShip.y,oDragAssist)
  oDragoonShip.shipAssist[oDragoonShip.i].type=2 - (i mod 2)
  oDragoonShip.multiple+=1
}


killCombo=0
comboTime=0

/*multiple=0
shipAssist[0]=noone*/
assistDir=0

instance_create(x,y,oDragKirby)
instance_create(x,y,oDragSuck)
