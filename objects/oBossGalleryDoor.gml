#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
arrowX=x+8
arrowY=y-24
pointTime=0
arrowColor=0
activateTime=20
textColorGreen=make_color_rgb(0,86,82)

alarm[0]=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if activateTime>0 {activateTime-=1}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Boss Gallery Door script
*/
if oKeyCodes.kCodePressed[3]=1 and activateTime=0 and global.gamePaused=false
{
  event_user(0)
  global.bCanSave=0
  global.wpWaterLEntry=global.wpWaterLevel
  global.recAreaTrans+=1
  global.newMapX=newMapX; global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  if global.bNightmareMode=0 {global.difficulty=2}
  if global.rmDeaths>=5 {global.chaoRecognition=1}
  global.rmDeaths=0; global.hitsTaken=0
  transition_steps=10
  transition_kind=21
  room_goto(toRoom)
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Bowser
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2
  global.hasAbilToken[0]=2
  global.currentBoss="Bowser"; global.bossTrack=1
}
else if type=2 //Cackletta
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(1)
  global.hasAbilToken[0]=2
  global.currentBoss="Cackletta"; global.bossTrack=1
}
else if type=3 //Kamek
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2
  global.hasAbilToken[0]=2
  global.currentBoss="Kamek"; global.bossTrack=1
}
else if type=4 //Helmethead
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=3
  global.currentBoss="Helmethead"; global.bossTrack=1
}
else if type=5 //Dead Hand
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=4
  global.currentBoss="Dead Hand"; global.bossTrack=1
}
else if type=6 //Barba
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=4
  global.currentBoss="Barba"; global.bossTrack=1
}
else if type=7 //Thunderbird
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=4
  global.currentBoss="Thunderbird"; global.bossTrack=1
}
else if type=8 //Aqua Serpent
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=4
  global.currentBoss="Aqua Serpent"; global.bossTrack=1
}
else if type=9 //Final Nightmare
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[1]=4
  global.currentBoss="Final Nightmare"; global.bossTrack=1
}
else if type=10 //Control Virus
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2; charSwitcher(0)
  global.activeAbility[0]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4
  global.currentBoss="Control Virus"; global.bossTrack=1
}
else if type=11 //Vampire Bat
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=1
  global.hasAbilToken[2]=2
  global.currentBoss="Vampire Bat"; global.bossTrack=1
}
else if type=12 //Dracula
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=1
  global.hasAbilToken[2]=4
  global.currentBoss="Dracula"; global.bossTrack=1
}
else if type=13 //Menace
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=1
  global.hasAbilToken[2]=4
  global.currentBoss="Menace"; global.bossTrack=1
}
else if type=14 or type=15 //Death
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=1
  global.hasAbilToken[2]=4
  global.currentBoss="Death"
  if type=14 {global.bossTrack=1}
  else if type=15 {global.bossTrack=2}
}
else if type=16 //Blackmoor
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=1
  global.hasAbilToken[2]=4
  global.currentBoss="Blackmoor"; global.bossTrack=1
}
else if type=17 //Enmity
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4
  global.currentBoss="Enmity"; global.bossTrack=1
}
else if type=18 //Maoh
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=2
  global.currentBoss="Maoh"; global.bossTrack=1
}
else if type=19 //Storm Eagle
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Storm Eagle"; global.bossTrack=1
}
else if type=20 //Overdrive Ostrich
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Overdrive Ostrich"; global.bossTrack=1
}
else if type=21 //Gravity Beetle
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Gravity Beetle"; global.bossTrack=1
}
else if type=22 //Bospider
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Bospider"; global.bossTrack=1
}
else if type=23 //Bit & Byte
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Bit & Byte"; global.bossTrack=1
}
else if type=24 or type=25 //Sigma
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  if type=24 {global.currentBoss="Sigma"; global.bossTrack=1}
  else if type=25 {global.currentBoss="Sigma Epsilon"; global.bossTrack=3}
}
else if type=26 //Elpizo
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=1; charSwitcher(0)
  global.activeAbility[0]=2; global.hasAbilToken[3]=5
  global.currentBoss="Elpizo"; global.bossTrack=1
}
else if type=27 //Army Eye
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5
  global.currentBoss="Army Eye"; global.bossTrack=1
}
else if type=28 //Hex (Vault)
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5
  global.currentBoss="Hex"; global.bossTrack=1
}
else if type=29 //Shadow Form
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5
  global.currentBoss="Shadow Form"; global.bossTrack=1
}
else if type=30 //Vault Demon
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5
  global.currentBoss="Vault Demon"; global.bossTrack=1
}
else if type=31 //Arachnus
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="Arachnus"; global.bossTrack=1
}
else if type=32 //King Worm
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="King Worm"; global.bossTrack=1
}
else if type=33 //Kraid
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="Kraid"; global.bossTrack=1
}
else if type=34 //Mother Brain
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="Mother Brain"; global.bossTrack=1
}
else if type=35 or type=36 or type=37 //Ridley - (Lava) - (Tunnel)
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="Ridley"
  if type=35 {global.bossTrack=1}
  else if type=36 {global.bossTrack=2}
  else if type=37 {global.bossTrack=3}
}
else if type=38 //Nightmare
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=1; charSwitcher(1)
  global.activeAbility[1]=2; global.hasAbilToken[4]=8
  global.currentBoss="Nightmare"; global.bossTrack=1
}
else if type=39 //Sand Crawler
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Sand Crawler"; global.bossTrack=1
}
else if type=40 //Malevolence
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Malevolence"; global.bossTrack=2
}
else if type=41 //Leviathan
{
  abilSetRemove(1)
  global.currentBoss="Leviathan"; global.bossTrack=1
}
else if type=42 //The Stone Golem
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(1)
  global.hasAbilToken[6]=2; global.activeAbility[1]=3
  global.currentBoss="Stone Golem"; global.bossTrack=1
}
else if type=43 //The Flame Elemental
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=1; charSwitcher(0)
  global.hasAbilToken[5]=2; global.activeAbility[0]=3
  global.currentBoss="Fire Elemental"; global.bossTrack=1
}
else if type=44 //High Heels Girl
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2
  global.activeAbility[0]=3 global.activeAbility[1]=3
  global.hasAbilToken[5]=2; global.hasAbilToken[6]=2
  global.currentBoss="High Heels Girl"; global.bossTrack=1
}
else if type=45 //The Unforgotten
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=3 global.activeAbility[1]=3
  global.hasAbilToken[5]=2; global.hasAbilToken[6]=2
  global.currentBoss="Unforgotten"; global.bossTrack=1
}
else if type=46 //The Chosen One
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=3 global.activeAbility[1]=3
  global.hasAbilToken[5]=3; global.hasAbilToken[6]=3
  global.currentBoss="Chosen One"; global.bossTrack=1
}
else if type=47 //Sephiroth
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=3 global.activeAbility[1]=3
  global.hasAbilToken[5]=3; global.hasAbilToken[6]=3
  global.currentBoss="Sephiroth"; global.bossTrack=1
}
else if type=48 //Antipathy
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Antipathy"; global.bossTrack=1
}
else if type=49 //Sera
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Sera"; global.bossTrack=1
}
else if type=50 //Brain Machine
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Brain Machine"; global.bossTrack=1
}
else if type=51 //Blade Bot
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Blade Bot"; global.bossTrack=1
}
else if type=52 //Combat Apparatus
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Combat Apparatus"; global.bossTrack=1
}
else if type=53 //Giant Blargg
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Giant Blargg"; global.bossTrack=1
}
else if type=54 //Defective
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Defective"; global.bossTrack=1
}
else if type=55 //Shadow Eura
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Shadow Eura"; global.bossTrack=1
}
else if type=56 or type=57 //Decimator 10000/20000
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Decimator"
  if type=56 {global.bossTrack=1}
  else if type=57 {global.bossTrack=3}
}
else if type=58 //Abomination
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Abomination"; global.bossTrack=1
}
else if type=59 //Hex Final
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Hex Final"; global.bossTrack=1
}
else if type=60 //Warmaster
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Warmaster"; global.bossTrack=1
}
else if type=61 //Parasitic Seed
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Parasitic Seed"; global.bossTrack=1
}
else if type=62 //Virus Parasite
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Virus Parasite"; global.bossTrack=1
}
else if type=63 //Hexor
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2
  charSwitcher(2)
  global.currentBoss="Hexor"; global.bossTrack=1
}
else if type=64 //The Executive
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=3 global.activeAbility[1]=3
  global.hasAbilToken[5]=3; global.hasAbilToken[6]=3
  global.currentBoss="The Executive"; global.bossTrack=1
}
else if type=65 //Warmaster EX
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2; global.hasShoes[3]=2; global.canCharSwap=2; global.canDoubleJump=2
  global.activeAbility[0]=1; global.activeAbility[1]=1
  global.hasAbilToken[0]=2; global.hasAbilToken[1]=4; global.hasAbilToken[2]=4; global.hasAbilToken[3]=5; global.hasAbilToken[4]=8
  global.currentBoss="Warmaster EX"; global.bossTrack=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=480
{
  if activateTime=0
  {
    pointTime+=1
    if pointTime=20 {arrowY+=1}
    else if pointTime=40
    {
      arrowY-=1
      pointTime=0
    }
    draw_sprite(sExitArrow,arrowColor,arrowX,arrowY)
  }

  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_middle)
  if global.bossGalleryTime[type-1]=99999 {draw_text(x+8,y-112,string(bossName) +string("#-Best Time-#-----"))}
  else {draw_text(x+8,y-112,string(bossName) +string("#-Best Time-#") +string(global.bossGalleryTime[type-1]))}

  //Award board
  if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=64
  {
    draw_sprite(sBossAwardCheck,0,x+8,y+64)
    draw_set_color(textColorGreen)
    for(i=0;i<3;i+=1)
    {
      draw_text(x-22+(i*30),y+58,award[i])
      if global.bossGalleryTime[type-1]<=award[i] {draw_sprite(sBossGalleryMedals,i,x-22+(i*30),y+64)}
    }

    /*if variable_local_exists("hasPlat")
    {
      if global.bossGalleryTime[type-1]<=award[3]
      {
        draw_sprite(sBossGalleryMedals,3,x+8,y+106)
        draw_set_color(c_white)
        draw_text(x+8,y+120,award[3])
      }
    }*/
  }
}
