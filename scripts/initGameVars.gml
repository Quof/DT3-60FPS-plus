/*
This script initializes the game variables.
*/
//----- Current active character and ability set -----
global.activeCharacter=0 //0:Jerry, 1:Claire, 2:Jeremy (Mech), 3:Chao, 4:Jeremy (Fighting), 5: Other
global.activeAbility[0]=0 //Jerry's active ability set
//-- 1: Link (Zelda)
//-- 2: Mega Man (X Series)
//-- 3: Game (DT)
global.activeAbility[1]=0 //Claire's active ability set
//-- 1: Belmont (Castlevania)
//-- 2: Samus (Metroid)
//-- 3: Game (DT)

global.charScan[0]=1 //Jeremy's scan ability
global.charScan[1]=1 //Chao's scan ability

//----- Player Stats -----
global.awesomePoints=0
global.pMaxLife=12
global.pLife=global.pMaxLife
global.pAP=0
global.pAPLevel=0
global.pAPExp=0
global.pAPNext=100

global.pMoney=0
global.pMoneyMax=20000
global.pCommLink=5
global.pKeys=0
global.pHeartPieces=0
global.pBreathMax=600
global.pCurrBreath=global.pBreathMax

//----- Ability Stats -----
//-- 0: Level
//-- 1: Exp (Hits)
//-- 2: Next (Shots)
for(i=0;i<3;i+=1)
{
  global.stLink_Sword[i]=0
  global.stLink_Arrow[i]=0
  global.stLink_Bomb[i]=0
  global.stBelmont_HairWhip[i]=0
  global.stBelmont_Dagger[i]=0
  global.stBelmont_Holywater[i]=0
  global.stMega_Buster[i]=0
  global.stMega_ShotIce[i]=0
  global.stMega_Gravity[i]=0
  global.stSamus_Cannon[i]=0
  global.stSamus_Missile[i]=0
  global.stSamus_Bomb[i]=0
}
//----- Link Stats -----
global.hudLink_Arrows[0]=10
global.hudLink_Arrows[1]=10
global.hudLink_BombEn[0]=150
//----- Castlevania Stats -----
global.hudBelmont_WeaponEn[0]=60
global.hudBelmont_WeaponEn[1]=60
//----- Mega Man Stats -----
global.MMactiveAtk=0
global.hudMega_BusterEn[0]=32
global.hudMega_ShotIceEn[0]=32
global.hudMega_GravityEn[0]=32
//----- Samus Stats -----
global.hudSamus_CannonEn[0]=0
global.hudSamus_CannonEn[1]=500
global.hudSamus_Missiles[0]=10
global.hudSamus_Missiles[1]=10
global.hudSamus_Bombs[0]=0
//----- Game Stats -----
//Jerry: Spam Gun
global.stJGame_A[0]=0 //Unused
global.stJGame_A[1]=0
global.stJGame_A[2]=0
//Jerry: Bird Swarm
global.stJGame_B[0]=0 //Unused
global.stJGame_B[1]=0
global.stJGame_B[2]=0
//Game: Misc
global.stJGame_C[0]=1000 //Block energy
global.stJGame_C[1]=1    //Characters level (Gate 6)
global.stJGame_C[2]=0    //Current exp (Gate 6)
//Claire: Blade Strike
global.stCGame_A[0]=0
global.stCGame_A[1]=0
global.stCGame_A[2]=0
//Claire: Chainblade Storm
global.stCGame_B[0]=0
global.stCGame_B[1]=0
global.stCGame_B[2]=0
//Game: Misc
global.stCGame_C[0]=40    //Exp till level (Gate 6)
global.stCGame_C[1]=1336  //Great Bird X
global.stCGame_C[2]=712   //Great Bird Y
global.hudGame_WeaponEn[0]=150
global.hudGame_WeaponEn[1]=150
//Defender (Both Characters)
global.hudDefend=0

//Others
global.jeremyCanAtk=1

//========================================
//============== Game Flags ==============
//========================================
//----- Important item flags
//-- 0: Do not have
//-- 1: Have, can't use
//-- 2: Have, can use
for(i=0;i<4;i+=1)
{
  global.hasShoes[i]=0
}
//-- 0: Movement
//-- 1: Jump
//-- 2: Dash
//-- 3: Air Dash
global.canCharSwap=0
global.canDoubleJump=0

for(i=0;i<7;i+=1)
{
  global.hasAbilToken[i]=0
}

//-- 0: Mario
//-- 1: Link
//-- 2: Belmont (Castlevania)
//-- 3: Mega Man (X Series)
//-- 4: Samus
//-- 5: Jerry (Game)
//-- 6: Claire (Game)

global.hasBoostedXCharge=0 //If player can charge special weapons (optional)
global.linkBombUpgrade=0 //Number of Link's bomb radius upgrades (optional) (5)
global.metBombUpgrade=0 //Number of Samus' bomb radius upgrades (optional) (5)
global.metJumpUpgrade=0 //0=No upgrade; 1=High Jump Boots; 2=Super High Jump Boots
global.metSpringBall=0 //If player can use the Spring Ball

//----- Equipment Flags -----
//-- 0: Do not have
//-- 1: In inventory
//-- 2: Equip to Jerry (Bottle: Filled with Energy Drink)
//-- 3: Equip to Claire (Bottle: Filled with Turbo Smoothie)

global.equipItems="0000000000000000000000000000000000000000" //40/40
global.extraItems="00010000" //7/8

//-1: Do not have, 0: Empty, The rest corresponds to item indexes
for(i=0;i<3;i+=1)
{
  global.equipJerry[i]=-1
  global.equipClaire[i]=-1
}
global.equipJerry[0]=0
global.equipClaire[0]=0

//----- Map Flags -----
global.mapAreas="00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" //110
global.mapExt2="000000000000"
global.mapExt3="0000000000000"
//0000000000
//----- Optional Items -----
global.heartPiece="00000000000000000000000000000000000000000000" //44
global.chestMoney="00000000000000000000000000000000000000000000000000000000000000000000000000000" //77
global.arrowQuiver="000000000000000000000000000000" //30
global.heartEnergy="0000000000000000000000000000" //28
global.missilePack="000000000000000000000000000000" //30
global.kiEnergy="00000000000000000000000000000000000000000000000000" //50
global.airUpgrade="0000000000" //10
global.fullHeartContainer="0000000" //7
global.walletBoost="00000000000000000000" //20
global.apBoost="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" //100
global.weaponBoosts="00000000000000000000" //10/20
global.weaponLevels="000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" //0/120

global.extraFlags="0000000000" //Used: 5/10 --10th digit used for cheat room
global.itemFinder=0
global.yoshiDoll=0

//----- Progress Items ----- 17/50
global.doorKey="00000000000000000000000000000000000000000000000000"
global.lockedDoor="00000000000000000000000000000000000000000000000000"

//----- Warp Points -----
global.warpMain="0000000000000000000000000" //13/(25)
global.warpGate1="0000" //4
global.warpGate2="00000000" //8
global.warpGate3="0000000000" //7
global.warpGate4="0" //None
global.warpGate5="0" //None
global.warpGate6="0" //None

//----- Play time (total game time) -----
global.playTimeHour=0
global.playTimeMinute=0
global.playTimeSecond=0
global.playTimeFrameCount=0

global.forceTime=-100 //time left till Game Over  [Countdown Timer] (if applicable)

//----- Level play time (per map) -----
global.levelTimeSecond=0
global.levelTimeFrameCount=0

global.rmDeaths=0                //deaths attained in a map

//----- Game progress data -----
global.gameProgress=0            //the game's global progress state
global.programChips=0            //the amount of program chips the player has
global.gamePercent=0             //game content completion percent
global.gameGate2Prog="000"       //Gate 2 progress
global.gameGate3Prog="00"        //Gate 3 progress
global.gameGate4Prog="000"       //Gate 4 progress
global.gameVaultProg="0000"      //Vault room shift progress
global.gameGate5Prog="000"       //Gate 5 progress (3 main bosses)
global.gameGate6Prog="000"       //Gate 6 progress (Castle of Doom)
global.gameDCS_Prog="0000"       //DCS progress
global.gamePttT_Prog=0           //Path to the truth progress
global.gameExecutiveDefeated=0   //If player has defeated The Executive
global.altEndingProg=1           //Alt end progress if alt method of Abom fight is done early (Is not saved)

global.eGateProg="00000000"      //Nightmare gate progress
global.gameOptDT=0               //Deserted Tower progress
global.gameOptTowerDef=3         //Optional tower defense progress
global.trialMasterQuest="0000000" //Optional trial master quest line (challenge rooms)
global.gateHProg=0               //Progress in Gate H
global.gateHLamps="111111111"    //Which candles are lit (Do not save in data file)
global.BTB_ZephSecret=0          //If the secret Zephyr map is unlocked
global.BTB_FedexBeat=0           //If Fedex in Bubble Tower B is beaten
global.gameOptShortcuts="00000000000000000000" //Optional shortcuts opened
global.abomAttempts=0            //Checks if the Abomination has been attempted after all Instruments have been obtained
global.BTB_HelmetHead=0          //Helmet Head EX checks

//----- Game state data -----
global.gameOver=0                //if the game over screen is showing
global.showHUD=1                 //if the HUD should be displayed
global.cutscene=0                //used so the character can be moved during cutscenes easier
global.bCanSave=1                //whether the player can save or not
global.bCanForceGO=1             //whether the player can use 'Force Game Over' or not
global.canPause=1                //if the player can pause the game
global.newMapX=240               //where to place the player on a new map
global.newMapY=336               //where to place the player on a new map
global.currentBoss=""            //the current boss battle in progress
global.bossTrack=0               //used for continuing in boss fights
global.currentMusic=0            //current music playing
global.rbSwitchBlueOn=false      //which switch color is active
global.wpWaterLevel=368          //water levels in the Water Palace in Gate 2
global.wpWaterLEntry=368         //the water level in Water Palace on map entry
global.partySplit=0              //whether the characters are splitting up or not
global.quickGameOver=0           //speed up game over sequence
global.bCanGameOver=true         //if the player can get a Game Over
global.mapTeleport=0             //teleport option - 0: Not usable; 1-x: Scripted per location
global.vaultWeakness=1           //weakness of Vault enemies
global.vaultRooms=1              //current rotation of the Vault rotation maze
global.desertHeat=1500           //time till the character needs water in the desert
global.genEnemyAward=10          //number of generated enemies that will award AP per map
global.difficulty=2              //difficulty setting - 1: Easy; 2: Normal
global.bNightmareMode=0          //if the player is playing in Nightmare mode (no pickups or drops)
global.bOneHitKillMode=0         //if the player is playing in One Hit Kill mode (can be in normal or nightmare)
global.easyModeUnlocked=0        //if easy mode can be accessed
global.permaEasyMode=0           //permanent half damage mode with no penalties
global.bRecordHits=1             //if the game should record when the player is taking damage (used for sections where the player is forced to take damage)
global.bTowerDefense=0           //if the tower defense ability set is available, and TD level
global.challengeRoom=0           //if the player is in a challenge room (this activates the cursed equipment set)
global.CHAOS_Invasion=0          //if CHAOS bots are spawned in other map locations
global.CHAOS_Upgrade=0           //if CHAOS bots are upgraded
global.noInactiveState=0         //enemies cannot be deactivated when offscreen
global.Ch19WIn=0                 //the chapter 19 warship invasion
global.bShooter=0                //if the player is in the shooter segment
global.shooterDifficulty=1       //alters enemy bullet patterns in the Dragoon segment
global.shooterProgress=0         //permanent progress in the Dragoon segment
global.chaoRecognition=0         //if Chao emotes a heart when the player reaches a new map they lost on a lot
global.bSoundCanPlay=1           //do not save in the data file, this is only for moments when I don't want any sound effects playing
global.bBossGallery=0            //do not save in the data file, when the player is in the boss gallery
global.bBossResultShow=0         //display boss gallery results screen
global.bossResultTime=0          //amount of time the player took to beat a boss in the boss room
global.bossResultHit=0           //amount of times the player was hit on a boss in the boss room
global.bossResultNewRecord=0     //if the new boss time is a new record
global.checkForDeath=0           //just used for the header feature
global.wearingHatJ=0             //check which hat Jerry is wearing
global.wearingHatC=0             //check which hat Claire is wearing
for(i=0;i<3;i+=1)                //Gate 5, checkpoint location - 0:mapID, 1:x, 2:y
{
  global.metCheckpoint[i]=0
}
for(i=0;i<3;i+=1)                //Stuff to remember over level segments (save to file)
{
  global.mySegmentCheck[i]=0
}

//----- Stuff to remember across maps -----
global.killStreak=0              //current kills in killing streak
global.hitsTaken=0               //number of times the player is hit on a single map
global.finalBossHP=1000          //remember HP for true final boss (Hexor)
global.jeremySuperEnergy=1500    //remember for true final boss

for(i=0;i<3;i+=1) //these remember various temporary states as needed
{
  global.tempAction[i]=0
}
/*
[0]
Gate 4: Level Ready Text
Vault_1: Tracks hit count of weakness hits
Main_45: Tracks progress of Twin Rocks puzzle
Gate 6/G: Enemy level when using delayed spawn
Hidden Program Facility: Track spawn position of scripted virus
Gate H: Track mother's activity (State)
BTB_Extra: Helmethead EX intro
[1]
Vault_R: Timer till room shift
Gate 6: Paradise Island sprite during enemy trap
Gate H: Track mother's activity (Time)
[2]
Vault_R: Timer till key/lock reset
Gate H: When player is caught
*/
global.gameCompleted=0

//----- Achievements (Token Recognitions) -----
global.tokenRecognitions="00000000000000000000000000000000000000000000000000" //50
global.tokenRecognitionsSetTwo="00000000000000000000000000000000000000000000000000" //50

//----- Skills -----
//--  0: Sword Master
//--  1: Boom
//--  2: Pulse
//--  3: Stab
//--  4: Burn
//--  5: X Charge
//--  6: S Charge
//--  7: Decimate
//--  8: Rapid Fire
//--  9: Advanced Shielding
//-- 10: Feathery Ally
//-- 11: Furious Cutter
//-- 12: Mastery
//-- 13: Glorious Flames
//-- 14: Elemental Resist
//-- 15: Shrapnel Resist
//-- 16: Perseverance
//-- 17: Safeguard
//-- 18: Lucky
//-- 19: Fortune
//-- 20: Manliness
//-- 21: Charm
//-- 22: Agility
//-- 23: Swift Foot
//-- 24: Quick Recovery
//-- 25: Expertise
//-- 26: Cool Whip
//-- 27: Resilience
//-- 28: Boost
//-- 29: Cooldown
for(i=0;i<30;i+=1)
{
  global.skillTree[i]=0
}

//----- Records -----
global.recKillCount=0
global.recDeathCount=0
global.recTotalAP=0
global.recDistFoot=0
global.recDistAir=0
global.recJumped=0
global.recDashForward=0
global.recDashBack=0
global.recAirDash=0
global.recAtkNum=0
global.recAtkHit=0
global.recDmgDealt=0

global.recDmgTaken=0
global.recTimesHit=0
global.recMostPowerfulHit=0
global.recFallenOffLevel=0
global.recObjectsBroken=0
global.recSaveNum=0
global.recMenuOpenNum=0
global.recAreaTrans=0
global.recLongestIdle=0
global.recScanNum=0
global.recPeopleTalkNum=0
global.recInterEarnEnemy=0
global.recInterLostDeath=0

global.recInterEarnChest=0
global.recInterSpent=0
global.recInterEarnTotal=0
global.recItemBought=0
global.recItemUsed=0
global.recQuestionBlockHit=0
global.recEnemyJumpedOn=0
global.recMaxEnemyJumpCombo=0
global.recSignsRead=0
global.recBestCombo=0
global.recBestChain=0
global.recBestStreak=0
global.recMaxBubbles=0

global.recZeldaEnc=0
global.recDrowned=0
global.recMostTeamHits=0
global.recDashInterruptedRed=0
global.recOneShotted=0
global.recBikeCrashes=0
global.recTimeReadingScanData=0
global.recComboDamage=0
global.recDamageFromBirds=0
global.recPlantsBurned=0
global.recHeardWilhelm=0
global.recTimeInMenu=0
global.recCloudsBusted=0

global.recParried=0
global.recShieldBroken=0
global.recG6TotalExp=0
global.recG6MostPowerfulHit=0
global.recStdMarioCoins=0
global.recSpottedSeeker=0
global.recCopierBroken=0
global.recRetryBossRoom=0
global.recTimeUnderWater=0
global.recBirdsScared=0
global.recBirdsSeen=0
global.recHeadBonks=0
global.recTimeSpentDucking=0

global.recStrikeChainMisses=0
global.recBumpKills=0
global.recTypeNormal=0
global.recTypePierce=0
global.recTypeElemental=0
global.recTypeShot=0
global.recTypeExplosion=0
global.recTypeSpecial=0
global.recForcedGameOver=0
global.recJerryDamage=0
global.recClaireDamage=0
global.recJeremyDamage=0
global.recWarmasterLoses=0
global.recWarmasterResets=0

//----- Options Flags -----
global.optGamePad=0
global.optGamepadSetup=1
global.optDPadDash=1
global.optRightIsForward=1
global.optShowKeyState=0
global.optCursorRepeat=3
global.optKeepMenuPos=0
global.optSwapType=0
global.optStickDeadZone=0.4
//-----
global.optVSync=1
global.optWindowSize=1
global.optCanResizeWindow=1
global.optLowHealthWarn=1
global.optBitrateExplosion=1
global.optPlayerTrail=0
global.optWeaponTrail=0
//-----
global.optShowHUD=1
global.optCentralizeHUD=0
global.optSplitWindow=30
global.optShowCombatAward=1
global.optShowChainMeter=1
global.optShowArea=1
global.optShowScore=1
global.optShowMapHeader=0
global.optDeathCounter=0
//-----
global.optShowDamage=1
global.optShowPointsEarned=1
global.optEnemyHP=1
global.optShowMoney=1
global.optAtkTShow=1
global.optChaoRoam=1
global.optShowHoverInfo=0
global.optChaoAttack=0
global.optNoBounce=0
global.optMorphControls=1
//-----
global.optUnrealGuyChainAudio=0
global.optUnrealGuyChainVisual=0
global.optUnrealGuySpreeAudio=0
global.optUnrealGuySpreeVisual=0
global.optUnrealVolume=100
global.optUnrealPitch=1
//-----
global.optMusic=95
global.optSound=95
global.optMessagePlink=0
global.optDashWarn=0
global.optChaoItemWarn=1

//-- Hidden modes --
global.modeDark=0        //All maps are dark rooms
global.modeButtface=0    //All enemies named 'Buttface McGee'
global.modeDroggeljug=0  //Replace most text with 'droggeljug'
global.modeWahfuu=0      //Replace Abomination name with "Wahfuu" and Sand Crawler with "Wahfuu Jr."

//global.modeSpeed=0       //Game runs 2x as fast
//global.gameFrameRate=30

//----- Controls -----
global.ctrlUp="W"
global.ctrlDown="S"
global.ctrlLeft="A"
global.ctrlRight="D"
global.ctrlJump="J"
global.ctrlCharSwap="U"
global.ctrlAbilSwap="I"
global.ctrlActA="K"
global.ctrlActB="L"
global.ctrlActC="O"
global.ctrlDashLeft="Q"
global.ctrlDashRight="E"

for(i=0;i<5;i+=1)
{
  global.pStatusStore[i]=0
}

global.nightmareDagger=21

//----- Boss Gallery time trials -----
for(i=0;i<65;i+=1)
{
  global.bossGalleryTime[i]=99999
}

//Debug flags
global.debugInvincible=false
global.debugMouseMove=false
