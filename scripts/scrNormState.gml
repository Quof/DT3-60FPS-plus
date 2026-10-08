/*
normalized gallery change (added): the player's real build while a normalized one is in use for a boss gallery fight
(oGalleryLever on: oBossGalleryDoor puts in that boss's build, scrNormApply).
argument0: 0 = keep the real values aside (oBossGalleryDoor, right before the normalized build goes in)
           1 = put them back (rBossGallery's creation code: every way out of a gallery fight goes back there)
           2 = swap the live and the kept values (saveData: a save always gets the real ones, swapped back after it)
global.normActive is 1 while the kept values are the real ones.
The values: the skill tree and AP, max HP and heart pieces, the arrow/sub-weapon energy/missile/Game Power maximums and
current amounts, breath, bomb upgrades, weapon levels, and the status the boss rooms restore from (storeStatus).
AP spent during the fight (on the normalized skill tree) comes back; AP earned during it is given again when the real
values go back in (global.recTotalAP counts all AP earned, awardAP).
*/
var tN,tX,k,i,tV,tCount,tD22,tD23,tD24,tGain;
k=0
for(i=0;i<30;i+=1) {tN[k]="skillTree"; tX[k]=i; k+=1}
tN[k]="pAP"; tX[k]=-1; k+=1
tN[k]="pAPLevel"; tX[k]=-1; k+=1
tN[k]="pAPExp"; tX[k]=-1; k+=1
tN[k]="pAPNext"; tX[k]=-1; k+=1
tN[k]="pMaxLife"; tX[k]=-1; k+=1
tN[k]="pHeartPieces"; tX[k]=-1; k+=1
tN[k]="pLife"; tX[k]=-1; k+=1
tN[k]="hudLink_Arrows"; tX[k]=0; k+=1
tN[k]="hudLink_Arrows"; tX[k]=1; k+=1
tN[k]="hudLink_BombEn"; tX[k]=0; k+=1
tN[k]="hudBelmont_WeaponEn"; tX[k]=0; k+=1
tN[k]="hudBelmont_WeaponEn"; tX[k]=1; k+=1
tN[k]="hudSamus_Missiles"; tX[k]=0; k+=1
tN[k]="hudSamus_Missiles"; tX[k]=1; k+=1
tN[k]="hudGame_WeaponEn"; tX[k]=0; k+=1
tN[k]="hudGame_WeaponEn"; tX[k]=1; k+=1
tN[k]="pBreathMax"; tX[k]=-1; k+=1
tN[k]="pCurrBreath"; tX[k]=-1; k+=1
tN[k]="linkBombUpgrade"; tX[k]=-1; k+=1
tN[k]="metBombUpgrade"; tX[k]=-1; k+=1
tN[k]="stLink_Sword"; tX[k]=0; k+=1
tN[k]="stLink_Arrow"; tX[k]=0; k+=1
tN[k]="stLink_Bomb"; tX[k]=0; k+=1
tN[k]="stBelmont_HairWhip"; tX[k]=0; k+=1
tN[k]="stBelmont_Dagger"; tX[k]=0; k+=1
tN[k]="stBelmont_Holywater"; tX[k]=0; k+=1
tN[k]="stMega_Buster"; tX[k]=0; k+=1
tN[k]="stMega_ShotIce"; tX[k]=0; k+=1
tN[k]="stMega_Gravity"; tX[k]=0; k+=1
tN[k]="stSamus_Cannon"; tX[k]=0; k+=1
tN[k]="stSamus_Missile"; tX[k]=0; k+=1
tN[k]="stSamus_Bomb"; tX[k]=0; k+=1
for(i=0;i<5;i+=1) {tN[k]="pStatusStore"; tX[k]=i; k+=1}
tCount=k

if argument0=0 //---------- keep the real values ----------
{
  for(k=0;k<tCount;k+=1)
  {
    if tX[k]<0 {global.normSave[k]=variable_global_get(tN[k])}
    else {global.normSave[k]=variable_global_array_get(tN[k],tX[k])}
  }
  global.normSaveAPTotal=global.recTotalAP
  global.normActive=1
}
else if argument0=1 //---------- put them back ----------
{
  if global.normActive=1
  {
    tD22=global.skillTree[22]; tD23=global.skillTree[23]; tD24=global.skillTree[24]
    for(k=0;k<tCount;k+=1)
    {
      if tX[k]<0 {variable_global_set(tN[k],global.normSave[k])}
      else {variable_global_array_set(tN[k],tX[k],global.normSave[k])}
    }
    global.normActive=0
    //AP earned during the fight
    tGain=global.recTotalAP-global.normSaveAPTotal
    if tGain>0
    {
      global.recTotalAP-=tGain
      awardAP(tGain)
    }
    //the player already in the room was made with the normalized build: its max HP (writeToPlayerGlobals copies it
    //back) and the stats characterCreateEvent works out from the skill tree
    tD22=global.skillTree[22]-tD22; tD23=global.skillTree[23]-tD23; tD24=global.skillTree[24]-tD24
    with oPlayer1
    {
      maxLife=global.pMaxLife; life=global.pLife
      dashRecovery+=tD22*2
      dashInvulnerability+=tD23
      recoverTime+=tD24
    }
  }
}
else if argument0=2 //---------- swap ----------
{
  if global.normActive=1
  {
    for(k=0;k<tCount;k+=1)
    {
      if tX[k]<0
      {
        tV=variable_global_get(tN[k])
        variable_global_set(tN[k],global.normSave[k])
      }
      else
      {
        tV=variable_global_array_get(tN[k],tX[k])
        variable_global_array_set(tN[k],tX[k],global.normSave[k])
      }
      global.normSave[k]=tV
    }
    tV=global.recTotalAP; global.recTotalAP=global.normSaveAPTotal; global.normSaveAPTotal=tV
  }
}
