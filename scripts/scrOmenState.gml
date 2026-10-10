/*
dark omen change (added): the New Dark Omen (dipswitch, on by default: remasterSwitchList). While the Dark Omen is
equipped (on Jerry or Claire) the skill tree is brought down to Nightmare Mode's (each skill down to its level there,
never up: the [earthshiftisbroken] code, oInitializeGame) and any hit kills (takeDamage, as in Achilles Mode). Weapon
levels aren't changed here: they count 10 lower where they're used (scrOmenLv), so there's nothing to put back for them.
Item upgrades (max HP, ammo, breath, bombs) aren't touched.

It's only ever temporary. The real skill tree is kept aside (global.omenSave) and put back when it comes off: real =
kept + how far a skill went up from what was put in (global.omenSet), so nothing is ever taken away. Skills can't be
learned while it's on anyway (oPauseMenu). A save always gets the real skill tree (saveData: 3 and 4), and loading a save
or starting a new game starts from the real one (loadSaveData, initGameVars: global.omenActive=0).
argument0: 0 = put it on: keep the real skill tree aside and put the lowered one in
           1 = take it off: the real skill tree back
           2 = every frame (oGame's Step): on while the Dark Omen is equipped and New Dark Omen is on, off otherwise. Not
               while a boss gallery normalized build is in use (scrNormState): that fight starts and ends as it was
           3 = right before a save is written (saveData): the real skill tree in place of the lowered one
           4 = right after it: the lowered one back
           5 = oBossGalleryDoor, when a normalized build has just gone in with it on: that build's skill tree is lowered
               the same way (the kept real one isn't touched; scrNormState puts the lowered one back after the fight)
*/
var i,tPre,tLow,tWant,tD22,tD23,tD24;

if argument0=2 //---------- every frame ----------
{
  if !variable_global_exists("omenActive") or !variable_global_exists("newDarkOmen") {exit}
  if global.normActive=1 or !instance_exists(oPlayer1) {exit}
  tWant=0
  if global.newDarkOmen=1
  {
    for(i=0;i<3;i+=1) {if global.equipJerry[i]=27 or global.equipClaire[i]=27 {tWant=1}}
  }
  if tWant=1 and global.omenActive=0 {scrOmenState(0)}
  else if tWant=0 and global.omenActive=1 {scrOmenState(1)}
  exit
}

//the level each skill goes down to: Nightmare Mode's skill tree, skillTree[0]..[29]
tPre="223350000000000000000011452011"
for(i=0;i<30;i+=1) {tLow[i]=real(string_char_at(tPre,i+1))}

if argument0=0 //---------- put it on ----------
{
  if global.omenActive=1 {exit}
  tD22=global.skillTree[22]; tD23=global.skillTree[23]; tD24=global.skillTree[24]
  for(i=0;i<30;i+=1)
  {
    global.omenSave[i]=global.skillTree[i]
    if global.skillTree[i]>tLow[i] {global.skillTree[i]=tLow[i]}
    global.omenSet[i]=global.skillTree[i]
  }
  global.omenActive=1
}
else if argument0=1 //---------- take it off ----------
{
  if global.omenActive=0 {exit}
  tD22=global.skillTree[22]; tD23=global.skillTree[23]; tD24=global.skillTree[24]
  for(i=0;i<30;i+=1) {global.skillTree[i]=global.omenSave[i]+max(0,global.skillTree[i]-global.omenSet[i])}
  global.omenActive=0
}
else if argument0=3 //---------- before a save: the real skill tree ----------
{
  if global.omenActive=0 {exit}
  for(i=0;i<30;i+=1)
  {
    global.omenTmp[i]=global.skillTree[i]
    global.skillTree[i]=global.omenSave[i]+max(0,global.skillTree[i]-global.omenSet[i])
  }
  exit
}
else if argument0=4 //---------- after the save: the lowered one back ----------
{
  if global.omenActive=0 {exit}
  for(i=0;i<30;i+=1) {global.skillTree[i]=global.omenTmp[i]}
  exit
}
else if argument0=5 //---------- a boss gallery normalized build's skill tree, lowered too ----------
{
  if global.omenActive=0 {exit}
  for(i=0;i<30;i+=1) {if global.skillTree[i]>tLow[i] {global.skillTree[i]=tLow[i]}}
  exit
}

//0 and 1: the stats characterCreateEvent works out from the skill tree, for the player already in the room (as
//scrNormState does)
tD22=global.skillTree[22]-tD22; tD23=global.skillTree[23]-tD23; tD24=global.skillTree[24]-tD24
with oPlayer1
{
  dashRecovery+=tD22*2
  dashInvulnerability+=tD23
  recoverTime+=tD24
}
