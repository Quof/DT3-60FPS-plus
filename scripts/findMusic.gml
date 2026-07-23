/*
This script finds which music track to play depending on where the player is.
Returns the ID of the music file to play.
argument0: find a specific track
*/
var tempFindMusic,tTrackPlay,bStream;
tTrackPlay=argument0
bStream=1

if global.currentMusic!=tTrackPlay {stopAllMusic()}
global.currentMusic=tTrackPlay

if tTrackPlay=0 {stopAllMusic()}
else if tTrackPlay=1 //---------- MAIN WORLD ----------
{
  if !SS_IsHandleValid(global.msc_Main1)
    global.msc_Main1=SS_LoadSound(working_directory+"\Music\DT_Main1.ogg",bStream)
  tempFindMusic=global.msc_Main1
}
else if tTrackPlay=2
{
  if !SS_IsHandleValid(global.msc_CentralCityA)
    global.msc_CentralCityA=SS_LoadSound(working_directory+"\Music\DT_CentralCityA.ogg",bStream)
  tempFindMusic=global.msc_CentralCityA
}
else if tTrackPlay=3
{
  if !SS_IsHandleValid(global.msc_GamerRun)
    global.msc_GamerRun=SS_LoadSound(working_directory+"\Music\DT_GamerRun.ogg",bStream)
  tempFindMusic=global.msc_GamerRun
}
else if tTrackPlay=4
{
  if !SS_IsHandleValid(global.msc_Main2)
    global.msc_Main2=SS_LoadSound(working_directory+"\Music\DT_Main2.ogg",bStream)
  tempFindMusic=global.msc_Main2
}
else if tTrackPlay=5
{
  if !SS_IsHandleValid(global.msc_LabyrinthRuins)
    global.msc_LabyrinthRuins=SS_LoadSound(working_directory+"\Music\DT_LabyrinthRuins.ogg",bStream)
  tempFindMusic=global.msc_LabyrinthRuins
}
else if tTrackPlay=6
{
  if !SS_IsHandleValid(global.msc_AncientGateway)
    global.msc_AncientGateway=SS_LoadSound(working_directory+"\Music\DT_AncientGateway.ogg",bStream)
  tempFindMusic=global.msc_AncientGateway
}
else if tTrackPlay=7
{
  if !SS_IsHandleValid(global.msc_Main3)
    global.msc_Main3=SS_LoadSound(working_directory+"\Music\DT_Main3.ogg",bStream)
  tempFindMusic=global.msc_Main3
}
else if tTrackPlay=8
{
  if !SS_IsHandleValid(global.msc_BegoniaTemple)
    global.msc_BegoniaTemple=SS_LoadSound(working_directory+"\Music\DT_BegoniaTemple.ogg",bStream)
  tempFindMusic=global.msc_BegoniaTemple
}
else if tTrackPlay=9
{
  if !SS_IsHandleValid(global.msc_MomentOfTruth)
    global.msc_MomentOfTruth=SS_LoadSound(working_directory+"\Music\DT_MomentOfTruth.ogg",bStream)
  tempFindMusic=global.msc_MomentOfTruth
}
else if tTrackPlay=10
{
  if !SS_IsHandleValid(global.msc_Farreaches)
    global.msc_Farreaches=SS_LoadSound(working_directory+"\Music\DT_Farreaches.ogg",bStream)
  tempFindMusic=global.msc_Farreaches
}
else if tTrackPlay=11
{
  if !SS_IsHandleValid(global.msc_Vault)
    global.msc_Vault=SS_LoadSound(working_directory+"\Music\DT_Vault.ogg",bStream)
  tempFindMusic=global.msc_Vault
}
else if tTrackPlay=12
{
  if !SS_IsHandleValid(global.msc_DrumLine)
    global.msc_DrumLine=SS_LoadSound(working_directory+"\Music\DT_DrumLine.ogg",bStream)
  tempFindMusic=global.msc_DrumLine
}
else if tTrackPlay=13
{
  if !SS_IsHandleValid(global.msc_Barrens)
    global.msc_Barrens=SS_LoadSound(working_directory+"\Music\DT_Barrens.ogg",bStream)
  tempFindMusic=global.msc_Barrens
}
else if tTrackPlay=14
{
  if !SS_IsHandleValid(global.msc_BurningStretch)
    global.msc_BurningStretch=SS_LoadSound(working_directory+"\Music\DT_BurningStretch.ogg",bStream)
  tempFindMusic=global.msc_BurningStretch
}
else if tTrackPlay=15
{
  if !SS_IsHandleValid(global.msc_SRDreamer)
    global.msc_SRDreamer=SS_LoadSound(working_directory+"\Music\DT_SRDreamer.ogg",bStream)
  tempFindMusic=global.msc_SRDreamer
}
else if tTrackPlay=16
{
  if !SS_IsHandleValid(global.msc_NGCLowerChamber)
    global.msc_NGCLowerChamber=SS_LoadSound(working_directory+"\Music\DT_NGCLowerChamber.ogg",bStream)
  tempFindMusic=global.msc_NGCLowerChamber
}
else if tTrackPlay=17
{
  if !SS_IsHandleValid(global.msc_CityEscape)
    global.msc_CityEscape=SS_LoadSound(working_directory+"\Music\DT_CityEscape.ogg",bStream)
  tempFindMusic=global.msc_CityEscape
}
else if tTrackPlay=18
{
  if !SS_IsHandleValid(global.msc_GamesNeverDie)
    global.msc_GamesNeverDie=SS_LoadSound(working_directory+"\Music\DT_GamesNeverDie.ogg",bStream)
  tempFindMusic=global.msc_GamesNeverDie
}
else if tTrackPlay=19
{
  if !SS_IsHandleValid(global.msc_CentralCore)
    global.msc_CentralCore=SS_LoadSound(working_directory+"\Music\DT_CentralCore.ogg",bStream)
  tempFindMusic=global.msc_CentralCore
}
else if tTrackPlay=20
{
  if !SS_IsHandleValid(global.msc_VirusInfection)
    global.msc_VirusInfection=SS_LoadSound(working_directory+"\Music\DT_VirusInfection.ogg",bStream)
  tempFindMusic=global.msc_VirusInfection
}
else if tTrackPlay=21
{
  if !SS_IsHandleValid(global.msc_StarrySkies)
    global.msc_StarrySkies=SS_LoadSound(working_directory+"\Music\DT_StarrySkies.ogg",bStream)
  tempFindMusic=global.msc_StarrySkies
}
else if tTrackPlay=22
{
  if !SS_IsHandleValid(global.msc_WeaponFacility)
    global.msc_WeaponFacility=SS_LoadSound(working_directory+"\Music\DT_WeaponFacility.ogg",bStream)
  tempFindMusic=global.msc_WeaponFacility
}
else if tTrackPlay=23
{
  if !SS_IsHandleValid(global.msc_MarioLavaRoad)
    global.msc_MarioLavaRoad=SS_LoadSound(working_directory+"\Music\DT_MarioLavaRoad.ogg",bStream)
  tempFindMusic=global.msc_MarioLavaRoad
}
else if tTrackPlay=24
{
  if !SS_IsHandleValid(global.msc_Main4)
    global.msc_Main4=SS_LoadSound(working_directory+"\Music\DT_Main4.ogg",bStream)
  tempFindMusic=global.msc_Main4
}
else if tTrackPlay=25
{
  if !SS_IsHandleValid(global.msc_NoMain)
    global.msc_NoMain=SS_LoadSound(working_directory+"\Music\DT_NoMain.ogg",bStream)
  tempFindMusic=global.msc_NoMain
}
else if tTrackPlay=26
{
  if !SS_IsHandleValid(global.msc_TranquilSerenity)
    global.msc_TranquilSerenity=SS_LoadSound(working_directory+"\Music\DT_TranquilSerenity.ogg",bStream)
  tempFindMusic=global.msc_TranquilSerenity
}
else if tTrackPlay=27
{
  if !SS_IsHandleValid(global.msc_HiddenTown)
    global.msc_HiddenTown=SS_LoadSound(working_directory+"\Music\DT_HiddenTown.ogg",bStream)
  tempFindMusic=global.msc_HiddenTown
}
else if tTrackPlay=28
{
  if !SS_IsHandleValid(global.msc_Discombobulated)
    global.msc_Discombobulated=SS_LoadSound(working_directory+"\Music\DT_Discombobulated.ogg",bStream)
  tempFindMusic=global.msc_Discombobulated
}
else if tTrackPlay=29
{
  if !SS_IsHandleValid(global.msc_SubconsciousFilter)
    global.msc_SubconsciousFilter=SS_LoadSound(working_directory+"\Music\DT_SubconsciousFilter.ogg",bStream)
  tempFindMusic=global.msc_SubconsciousFilter
}
else if tTrackPlay=30
{
  if !SS_IsHandleValid(global.msc_MagicalCastle)
    global.msc_MagicalCastle=SS_LoadSound(working_directory+"\Music\DT_MagicalCastle.ogg",bStream)
  tempFindMusic=global.msc_MagicalCastle
}
else if tTrackPlay=31
{
  if !SS_IsHandleValid(global.msc_BTBSZ)
    global.msc_BTBSZ=SS_LoadSound(working_directory+"\Music\DT_BTBSZ.ogg",bStream)
  tempFindMusic=global.msc_BTBSZ
}
else if tTrackPlay=101 //---------- GATE 1 - MARIO ----------
{
  if !SS_IsHandleValid(global.msc_MarioWorld)
    global.msc_MarioWorld=SS_LoadSound(working_directory+"\Music\DT_MarioWorld.ogg",bStream)
  tempFindMusic=global.msc_MarioWorld
}
else if tTrackPlay=102
{
  if !SS_IsHandleValid(global.msc_MarioCastle1)
    global.msc_MarioCastle1=SS_LoadSound(working_directory+"\Music\DT_MarioCastle1.ogg",bStream)
  tempFindMusic=global.msc_MarioCastle1
}
else if tTrackPlay=103
{
  if !SS_IsHandleValid(global.msc_MarioCastle2)
    global.msc_MarioCastle2=SS_LoadSound(working_directory+"\Music\DT_MarioCastle2.ogg",bStream)
  tempFindMusic=global.msc_MarioCastle2
}
else if tTrackPlay=104
{
  if !SS_IsHandleValid(global.msc_MarioUnderground)
    global.msc_MarioUnderground=SS_LoadSound(working_directory+"\Music\DT_MarioUnderground.ogg",bStream)
  tempFindMusic=global.msc_MarioUnderground
}
else if tTrackPlay=105
{
  if !SS_IsHandleValid(global.msc_MarioCastle3)
    global.msc_MarioCastle3=SS_LoadSound(working_directory+"\Music\DT_MarioCastle3.ogg",bStream)
  tempFindMusic=global.msc_MarioCastle3
}
else if tTrackPlay=201 //---------- GATE 2 - LINK ----------
{
  if !SS_IsHandleValid(global.msc_ZeldaWater)
    global.msc_ZeldaWater=SS_LoadSound(working_directory+"\Music\DT_ZeldaWater.ogg",bStream)
  tempFindMusic=global.msc_ZeldaWater
}
else if tTrackPlay=202
{
  if !SS_IsHandleValid(global.msc_OminousHall)
    global.msc_OminousHall=SS_LoadSound(working_directory+"\Music\DT_OminousHall.ogg",bStream)
  tempFindMusic=global.msc_OminousHall
}
else if tTrackPlay=203
{
  if !SS_IsHandleValid(global.msc_ZeldaOverworld)
    global.msc_ZeldaOverworld=SS_LoadSound(working_directory+"\Music\DT_ZeldaOverworld.ogg",bStream)
  tempFindMusic=global.msc_ZeldaOverworld
}
else if tTrackPlay=204
{
  if !SS_IsHandleValid(global.msc_ZeldaDunA)
    global.msc_ZeldaDunA=SS_LoadSound(working_directory+"\Music\DT_ZeldaDunA.ogg",bStream)
  tempFindMusic=global.msc_ZeldaDunA
}
else if tTrackPlay=205
{
  if !SS_IsHandleValid(global.msc_ZeldaDunB)
    global.msc_ZeldaDunB=SS_LoadSound(working_directory+"\Music\DT_ZeldaDunB.ogg",bStream)
  tempFindMusic=global.msc_ZeldaDunB
}
else if tTrackPlay=206
{
  if !SS_IsHandleValid(global.msc_ZeldaTown)
    global.msc_ZeldaTown=SS_LoadSound(working_directory+"\Music\DT_ZeldaTown.ogg",bStream)
  tempFindMusic=global.msc_ZeldaTown
}
else if tTrackPlay=207
{
  if !SS_IsHandleValid(global.msc_ZeldasTheme)
    global.msc_ZeldasTheme=SS_LoadSound(working_directory+"\Music\DT_ZeldasTheme.ogg",bStream)
  tempFindMusic=global.msc_ZeldasTheme
}
else if tTrackPlay=208
{
  if !SS_IsHandleValid(global.msc_DeathMountain)
    global.msc_DeathMountain=SS_LoadSound(working_directory+"\Music\DT_DeathMountain.ogg",bStream)
  tempFindMusic=global.msc_DeathMountain
}
else if tTrackPlay=209
{
  if !SS_IsHandleValid(global.msc_ZeldaForest)
    global.msc_ZeldaForest=SS_LoadSound(working_directory+"\Music\DT_ZeldaForest.ogg",bStream)
  tempFindMusic=global.msc_ZeldaForest
}
else if tTrackPlay=301 //---------- GATE 3 - BELMONT ----------
{
  if !SS_IsHandleValid(global.msc_VampireKiller)
    global.msc_VampireKiller=SS_LoadSound(working_directory+"\Music\DT_CVVampireKiller.ogg",bStream)
  tempFindMusic=global.msc_VampireKiller
}
else if tTrackPlay=302
{
  if !SS_IsHandleValid(global.msc_HeartOfFire)
    global.msc_HeartOfFire=SS_LoadSound(working_directory+"\Music\DT_CVHeartOfFire.ogg",bStream)
  tempFindMusic=global.msc_HeartOfFire
}
else if tTrackPlay=303
{
  if !SS_IsHandleValid(global.msc_SimonsTheme)
    global.msc_SimonsTheme=SS_LoadSound(working_directory+"\Music\DT_CVSimonsTheme.ogg",bStream)
  tempFindMusic=global.msc_SimonsTheme
}
else if tTrackPlay=304
{
  if !SS_IsHandleValid(global.msc_MarbleGallery)
    global.msc_MarbleGallery=SS_LoadSound(working_directory+"\Music\DT_CVMarbleGallery.ogg",bStream)
  tempFindMusic=global.msc_MarbleGallery
}
else if tTrackPlay=305
{
  if !SS_IsHandleValid(global.msc_CastleCourtyard)
    global.msc_CastleCourtyard=SS_LoadSound(working_directory+"\Music\DT_CVCastleCourtyard.ogg",bStream)
  tempFindMusic=global.msc_CastleCourtyard
}
else if tTrackPlay=306
{
  if !SS_IsHandleValid(global.msc_OutOfTime)
    global.msc_OutOfTime=SS_LoadSound(working_directory+"\Music\DT_CVOutOfTime.ogg",bStream)
  tempFindMusic=global.msc_OutOfTime
}
else if tTrackPlay=307
{
  if !SS_IsHandleValid(global.msc_ReapersHall)
    global.msc_ReapersHall=SS_LoadSound(working_directory+"\Music\DT_CVReapersHall.ogg",bStream)
  tempFindMusic=global.msc_ReapersHall
}
else if tTrackPlay=401 //---------- GATE 4 - MEGA MAN X ----------
{
  if !SS_IsHandleValid(global.msc_MMIntroStage)
    global.msc_MMIntroStage=SS_LoadSound(working_directory+"\Music\DT_MMIntroStage.ogg",bStream)
  tempFindMusic=global.msc_MMIntroStage
}
else if tTrackPlay=402
{
  if !SS_IsHandleValid(global.msc_MMBossIntro)
    global.msc_MMBossIntro=SS_LoadSound(working_directory+"\Music\DT_MMBossIntro.ogg",bStream)
  tempFindMusic=global.msc_MMBossIntro
}
else if tTrackPlay=403
{
  if !SS_IsHandleValid(global.msc_MMVictory)
    global.msc_MMVictory=SS_LoadSound(working_directory+"\Music\DT_MMVictory.ogg",bStream)
  tempFindMusic=global.msc_MMVictory
}
else if tTrackPlay=404
{
  if !SS_IsHandleValid(global.msc_MMStormEagle)
    global.msc_MMStormEagle=SS_LoadSound(working_directory+"\Music\DT_MMStormEagle.ogg",bStream)
  tempFindMusic=global.msc_MMStormEagle
}
else if tTrackPlay=405
{
  if !SS_IsHandleValid(global.msc_MMStageSelect)
    global.msc_MMStageSelect=SS_LoadSound(working_directory+"\Music\DT_MMStageSelect.ogg",bStream)
  tempFindMusic=global.msc_MMStageSelect
}
else if tTrackPlay=406
{
  if !SS_IsHandleValid(global.msc_MMStageIntro)
    global.msc_MMStageIntro=SS_LoadSound(working_directory+"\Music\DT_MMStageIntro.ogg",bStream)
  tempFindMusic=global.msc_MMStageIntro
}
else if tTrackPlay=407
{
  if !SS_IsHandleValid(global.msc_MMWeaponGet)
    global.msc_MMWeaponGet=SS_LoadSound(working_directory+"\Music\DT_MMWeaponGet.ogg",bStream)
  tempFindMusic=global.msc_MMWeaponGet
}
else if tTrackPlay=408
{
  if !SS_IsHandleValid(global.msc_MMOverdriveOstrich)
    global.msc_MMOverdriveOstrich=SS_LoadSound(working_directory+"\Music\DT_MMOverdriveOstrich.ogg",bStream)
  tempFindMusic=global.msc_MMOverdriveOstrich
}
else if tTrackPlay=409
{
  if !SS_IsHandleValid(global.msc_MMToxicJungle)
    global.msc_MMToxicJungle=SS_LoadSound(working_directory+"\Music\DT_MMToxicJungle.ogg",bStream)
  tempFindMusic=global.msc_MMToxicJungle
}
else if tTrackPlay=410
{
  if !SS_IsHandleValid(global.msc_MMSigmaStage1)
    global.msc_MMSigmaStage1=SS_LoadSound(working_directory+"\Music\DT_MMSigmaStage1.ogg",bStream)
  tempFindMusic=global.msc_MMSigmaStage1
}
else if tTrackPlay=411
{
  if !SS_IsHandleValid(global.msc_MMSigmaStage2)
    global.msc_MMSigmaStage2=SS_LoadSound(working_directory+"\Music\DT_MMSigmaStage2.ogg",bStream)
  tempFindMusic=global.msc_MMSigmaStage2
}
else if tTrackPlay=412
{
  if !SS_IsHandleValid(global.msc_MMSigmaStage3)
    global.msc_MMSigmaStage3=SS_LoadSound(working_directory+"\Music\DT_MMSigmaStage3.ogg",bStream)
  tempFindMusic=global.msc_MMSigmaStage3
}
else if tTrackPlay=501 //---------- GATE 5 - SAMUS ----------
{
  if !SS_IsHandleValid(global.msc_MetMain)
    global.msc_MetMain=SS_LoadSound(working_directory+"\Music\DT_MetMain.ogg",bStream)
  tempFindMusic=global.msc_MetMain
}
else if tTrackPlay=502
{
  if !SS_IsHandleValid(global.msc_MetBrinstar)
    global.msc_MetBrinstar=SS_LoadSound(working_directory+"\Music\DT_MetBrinstar.ogg",bStream)
  tempFindMusic=global.msc_MetBrinstar
}
else if tTrackPlay=503
{
  if !SS_IsHandleValid(global.msc_MetNorfair)
    global.msc_MetNorfair=SS_LoadSound(working_directory+"\Music\DT_MetNorfair.ogg",bStream)
  tempFindMusic=global.msc_MetNorfair
}
else if tTrackPlay=504
{
  if !SS_IsHandleValid(global.msc_MetMaridia)
    global.msc_MetMaridia=SS_LoadSound(working_directory+"\Music\DT_MetMaridia.ogg",bStream)
  tempFindMusic=global.msc_MetMaridia
}
else if tTrackPlay=505
{
  if !SS_IsHandleValid(global.msc_MetTourian)
    global.msc_MetTourian=SS_LoadSound(working_directory+"\Music\DT_MetTourian.ogg",bStream)
  tempFindMusic=global.msc_MetTourian
}
else if tTrackPlay=601 //---------- GATE 6 - GAME ----------
{
  if !SS_IsHandleValid(global.msc_RPGOverworld)
    global.msc_RPGOverworld=SS_LoadSound(working_directory+"\Music\DT_RPGOverworld.ogg",bStream)
  tempFindMusic=global.msc_RPGOverworld
}
else if tTrackPlay=602
{
  if !SS_IsHandleValid(global.msc_RPGPlains)
    global.msc_RPGPlains=SS_LoadSound(working_directory+"\Music\DT_RPGPlains.ogg",bStream)
  tempFindMusic=global.msc_RPGPlains
}
else if tTrackPlay=603
{
  if !SS_IsHandleValid(global.msc_RPGTown)
    global.msc_RPGTown=SS_LoadSound(working_directory+"\Music\DT_RPGTown.ogg",bStream)
  tempFindMusic=global.msc_RPGTown
}
else if tTrackPlay=604
{
  if !SS_IsHandleValid(global.msc_RPGDoomCastle)
    global.msc_RPGDoomCastle=SS_LoadSound(working_directory+"\Music\DT_RPGDoomCastle.ogg",bStream)
  tempFindMusic=global.msc_RPGDoomCastle
}
else if tTrackPlay=605
{
  if !SS_IsHandleValid(global.msc_RPGElementsA)
    global.msc_RPGElementsA=SS_LoadSound(working_directory+"\Music\DT_RPGElementsA.ogg",bStream)
  tempFindMusic=global.msc_RPGElementsA
}
else if tTrackPlay=606
{
  if !SS_IsHandleValid(global.msc_RPGDreamWoods)
    global.msc_RPGDreamWoods=SS_LoadSound(working_directory+"\Music\DT_RPGDreamWoods.ogg",bStream)
  tempFindMusic=global.msc_RPGDreamWoods
}
else if tTrackPlay=607
{
  if !SS_IsHandleValid(global.msc_RPGElementsB)
    global.msc_RPGElementsB=SS_LoadSound(working_directory+"\Music\DT_RPGElementsB.ogg",bStream)
  tempFindMusic=global.msc_RPGElementsB
}
else if tTrackPlay=801 //---------- BOSS & ENCOUNTER ----------
{
   if !SS_IsHandleValid(global.msc_BowserFight)
    global.msc_BowserFight=SS_LoadSound(working_directory+"\Music\DT_BowserFight.ogg",bStream)
  tempFindMusic=global.msc_BowserFight
}
else if tTrackPlay=802
{
  if !SS_IsHandleValid(global.msc_ZeldaMiniBoss)
    global.msc_ZeldaMiniBoss=SS_LoadSound(working_directory+"\Music\DT_ZeldaMiniBoss.ogg",bStream)
  tempFindMusic=global.msc_ZeldaMiniBoss
}
else if tTrackPlay=803
{
  if !SS_IsHandleValid(global.msc_ZeldaBoss)
    global.msc_ZeldaBoss=SS_LoadSound(working_directory+"\Music\DT_ZeldaBoss.ogg",bStream)
  tempFindMusic=global.msc_ZeldaBoss
}
else if tTrackPlay=804
{
  if !SS_IsHandleValid(global.msc_DanceOfIllusions)
    global.msc_DanceOfIllusions=SS_LoadSound(working_directory+"\Music\DT_CVDanceOfIllusions.ogg",bStream)
  tempFindMusic=global.msc_DanceOfIllusions
}
else if tTrackPlay=805
{
  if !SS_IsHandleValid(global.msc_PiercingBattleFury)
    global.msc_PiercingBattleFury=SS_LoadSound(working_directory+"\Music\DT_CVPiercingBattleFury.ogg",bStream)
  tempFindMusic=global.msc_PiercingBattleFury
}
else if tTrackPlay=806
{
  if !SS_IsHandleValid(global.msc_DanceWithDeath)
    global.msc_DanceWithDeath=SS_LoadSound(working_directory+"\Music\DT_CVDanceWithDeath.ogg",bStream)
  tempFindMusic=global.msc_DanceWithDeath
}
else if tTrackPlay=807
{
  if !SS_IsHandleValid(global.msc_FamiliarFoe)
    global.msc_FamiliarFoe=SS_LoadSound(working_directory+"\Music\DT_FamiliarFoe.ogg",bStream)
  tempFindMusic=global.msc_FamiliarFoe
}
else if tTrackPlay=808
{
  if !SS_IsHandleValid(global.msc_FinalNightmare)
    global.msc_FinalNightmare=SS_LoadSound(working_directory+"\Music\DT_FinalNightmare.ogg",bStream)
  tempFindMusic=global.msc_FinalNightmare
}
else if tTrackPlay=809
{
  if !SS_IsHandleValid(global.msc_Encounter)
    global.msc_Encounter=SS_LoadSound(working_directory+"\Music\DT_Encounter.ogg",bStream)
  tempFindMusic=global.msc_Encounter
}
else if tTrackPlay=810
{
  if !SS_IsHandleValid(global.msc_MMBossFight)
    global.msc_MMBossFight=SS_LoadSound(working_directory+"\Music\DT_MMBossFight.ogg",bStream)
  tempFindMusic=global.msc_MMBossFight
}
else if tTrackPlay=812
{
  if !SS_IsHandleValid(global.msc_MMEpsilon)
    global.msc_MMEpsilon=SS_LoadSound(working_directory+"\Music\DT_MMEpsilon.ogg",bStream)
  tempFindMusic=global.msc_MMEpsilon
}
else if tTrackPlay=813
{
  if !SS_IsHandleValid(global.msc_GiantEnemyRobot)
    global.msc_GiantEnemyRobot=SS_LoadSound(working_directory+"\Music\DT_GiantEnemyRobot.ogg",bStream)
  tempFindMusic=global.msc_GiantEnemyRobot
}
else if tTrackPlay=814
{
  if !SS_IsHandleValid(global.msc_AbominationA)
    global.msc_AbominationA=SS_LoadSound(working_directory+"\Music\DT_AbominationA.ogg",bStream)
  tempFindMusic=global.msc_AbominationA
}
else if tTrackPlay=815
{
  if !SS_IsHandleValid(global.msc_MetroidBoss)
    global.msc_MetroidBoss=SS_LoadSound(working_directory+"\Music\DT_MetroidBoss.ogg",bStream)
  tempFindMusic=global.msc_MetroidBoss
}
else if tTrackPlay=816
{
  if !SS_IsHandleValid(global.msc_MetRidley)
    global.msc_MetRidley=SS_LoadSound(working_directory+"\Music\DT_MetRidley.ogg",bStream)
  tempFindMusic=global.msc_MetRidley
}
else if tTrackPlay=817
{
  if !SS_IsHandleValid(global.msc_MetNightmare)
    global.msc_MetNightmare=SS_LoadSound(working_directory+"\Music\DT_MetNightmare.ogg",bStream)
  tempFindMusic=global.msc_MetNightmare
}
else if tTrackPlay=818
{
  if !SS_IsHandleValid(global.msc_MarioBoss)
    global.msc_MarioBoss=SS_LoadSound(working_directory+"\Music\DT_MarioBoss.ogg",bStream)
  tempFindMusic=global.msc_MarioBoss
}
else if tTrackPlay=819
{
  if !SS_IsHandleValid(global.msc_RPGBoss)
    global.msc_RPGBoss=SS_LoadSound(working_directory+"\Music\DT_RPGBoss.ogg",bStream)
  tempFindMusic=global.msc_RPGBoss
}
else if tTrackPlay=820
{
  if !SS_IsHandleValid(global.msc_OWA)
    global.msc_OWA=SS_LoadSound(working_directory+"\Music\DT_OWA.ogg",bStream)
  tempFindMusic=global.msc_OWA
}
else if tTrackPlay=821
{
  if !SS_IsHandleValid(global.msc_Sera)
    global.msc_Sera=SS_LoadSound(working_directory+"\Music\DT_Sera.ogg",bStream)
  tempFindMusic=global.msc_Sera
}
else if tTrackPlay=822
{
  if !SS_IsHandleValid(global.msc_AbominationB)
    global.msc_AbominationB=SS_LoadSound(working_directory+"\Music\DT_AbominationB.ogg",bStream)
  tempFindMusic=global.msc_AbominationB
}
else if tTrackPlay=823
{
  if !SS_IsHandleValid(global.msc_AbominationC)
    global.msc_AbominationC=SS_LoadSound(working_directory+"\Music\DT_AbominationC.ogg",bStream)
  tempFindMusic=global.msc_AbominationC
}
else if tTrackPlay=824
{
  if !SS_IsHandleValid(global.msc_CVBoss)
    global.msc_CVBoss=SS_LoadSound(working_directory+"\Music\DT_CVBoss.ogg",bStream)
  tempFindMusic=global.msc_CVBoss
}
else if tTrackPlay=825
{
  if !SS_IsHandleValid(global.msc_ChaosBossA)
    global.msc_ChaosBossA=SS_LoadSound(working_directory+"\Music\DT_ChaosBossA.ogg",bStream)
  tempFindMusic=global.msc_ChaosBossA
}
else if tTrackPlay=826
{
  if !SS_IsHandleValid(global.msc_Defective)
    global.msc_Defective=SS_LoadSound(working_directory+"\Music\DT_Defective.ogg",bStream)
  tempFindMusic=global.msc_Defective
}
else if tTrackPlay=827
{
  if !SS_IsHandleValid(global.msc_DarkShadow)
    global.msc_DarkShadow=SS_LoadSound(working_directory+"\Music\DT_DarkShadow.ogg",bStream)
  tempFindMusic=global.msc_DarkShadow
}
else if tTrackPlay=828
{
  if !SS_IsHandleValid(global.msc_TheBattle)
    global.msc_TheBattle=SS_LoadSound(working_directory+"\Music\DT_TheBattle.ogg",bStream)
  tempFindMusic=global.msc_TheBattle
}
else if tTrackPlay=829
{
  if !SS_IsHandleValid(global.msc_ChaosWarmaster)
    global.msc_ChaosWarmaster=SS_LoadSound(working_directory+"\Music\DT_ChaosWarmaster.ogg",bStream)
  tempFindMusic=global.msc_ChaosWarmaster
}
else if tTrackPlay=830
{
  if !SS_IsHandleValid(global.msc_Hatred)
    global.msc_Hatred=SS_LoadSound(working_directory+"\Music\DT_Hatred.ogg",bStream)
  tempFindMusic=global.msc_Hatred
}
else if tTrackPlay=831
{
  if !SS_IsHandleValid(global.msc_ParasiticSeed)
    global.msc_ParasiticSeed=SS_LoadSound(working_directory+"\Music\DT_ParasiticSeed.ogg",bStream)
  tempFindMusic=global.msc_ParasiticSeed
}
else if tTrackPlay=832
{
  if !SS_IsHandleValid(global.msc_VirusParasite)
    global.msc_VirusParasite=SS_LoadSound(working_directory+"\Music\DT_VirusParasite.ogg",bStream)
  tempFindMusic=global.msc_VirusParasite
}
else if tTrackPlay=833
{
  if !SS_IsHandleValid(global.msc_DistortedEncounterA)
    global.msc_DistortedEncounterA=SS_LoadSound(working_directory+"\Music\DT_DistortedEncounterA.ogg",bStream)
  tempFindMusic=global.msc_DistortedEncounterA
}
else if tTrackPlay=834
{
  if !SS_IsHandleValid(global.msc_TheExecutive)
    global.msc_TheExecutive=SS_LoadSound(working_directory+"\Music\DT_TheExecutive.ogg",bStream)
  tempFindMusic=global.msc_TheExecutive
}
else if tTrackPlay=835
{
  if !SS_IsHandleValid(global.msc_ChaosWarmasterEX)
    global.msc_ChaosWarmasterEX=SS_LoadSound(working_directory+"\Music\DT_WEX.ogg",bStream)
  tempFindMusic=global.msc_ChaosWarmasterEX
}
else if tTrackPlay=901 //---------- EXTRA GATES ----------
{
  if !SS_IsHandleValid(global.msc_EerieFaces)
    global.msc_EerieFaces=SS_LoadSound(working_directory+"\Music\DT_EerieFaces.ogg",bStream)
  tempFindMusic=global.msc_EerieFaces
}
else if tTrackPlay=902
{
  if !SS_IsHandleValid(global.msc_SacredTemple)
    global.msc_SacredTemple=SS_LoadSound(working_directory+"\Music\DT_SacredTemple.ogg",bStream)
  tempFindMusic=global.msc_SacredTemple
}
else if tTrackPlay=903
{
  if !SS_IsHandleValid(global.msc_GhostlyTheatre)
    global.msc_GhostlyTheatre=SS_LoadSound(working_directory+"\Music\DT_CVGhostlyTheatre.ogg",bStream)
  tempFindMusic=global.msc_GhostlyTheatre
}
else if tTrackPlay=904
{
  if !SS_IsHandleValid(global.msc_MMCityScape)
    global.msc_MMCityScape=SS_LoadSound(working_directory+"\Music\DT_MMCityScape.ogg",bStream)
  tempFindMusic=global.msc_MMCityScape
}
else if tTrackPlay=905
{
  if !SS_IsHandleValid(global.msc_ForgottenIsles)
    global.msc_ForgottenIsles=SS_LoadSound(working_directory+"\Music\DT_ForgottenIsles.ogg",bStream)
  tempFindMusic=global.msc_ForgottenIsles
}
else if tTrackPlay=906
{
  if !SS_IsHandleValid(global.msc_TheHouse)
    global.msc_TheHouse=SS_LoadSound(working_directory+"\Music\DT_TheHouse.ogg",bStream)
  tempFindMusic=global.msc_TheHouse
}
else if tTrackPlay=907
{
  if !SS_IsHandleValid(global.msc_NoControl)
    global.msc_NoControl=SS_LoadSound(working_directory+"\Music\DT_NoControl.ogg",bStream)
  tempFindMusic=global.msc_NoControl
}
else if tTrackPlay=1001 //---------- OTHERS ----------
{
  if !SS_IsHandleValid(global.msc_IFA)
    global.msc_IFA=SS_LoadSound(working_directory+"\Music\DT_IFA.ogg",bStream)
  tempFindMusic=global.msc_IFA
}
else if tTrackPlay=1002
{
  if !SS_IsHandleValid(global.msc_IFB)
    global.msc_IFB=SS_LoadSound(working_directory+"\Music\DT_IFB.ogg",bStream)
  tempFindMusic=global.msc_IFB
}
else if tTrackPlay=1003
{
  if !SS_IsHandleValid(global.msc_IFC)
    global.msc_IFC=SS_LoadSound(working_directory+"\Music\DT_IFC.ogg",bStream)
  tempFindMusic=global.msc_IFC
}
else if tTrackPlay=1004
{
  if !SS_IsHandleValid(global.msc_MonsterRoaming)
    global.msc_MonsterRoaming=SS_LoadSound(working_directory+"\Music\DT_MonsterRoaming.ogg",bStream)
  tempFindMusic=global.msc_MonsterRoaming
}
else if tTrackPlay=1005
{
  if !SS_IsHandleValid(global.msc_SeraBegin)
    global.msc_SeraBegin=SS_LoadSound(working_directory+"\Music\DT_SeraBegin.ogg",bStream)
  tempFindMusic=global.msc_SeraBegin
}
else if tTrackPlay=1010
{
  if !SS_IsHandleValid(global.msc_FortressSkyguard)
    global.msc_FortressSkyguard=SS_LoadSound(working_directory+"\Music\DT_FortressSkyguard.ogg",bStream)
  tempFindMusic=global.msc_FortressSkyguard
}
else if tTrackPlay=1011
{
  if !SS_IsHandleValid(global.msc_MasterPlan)
    global.msc_MasterPlan=SS_LoadSound(working_directory+"\Music\DT_MasterPlan.ogg",bStream)
  tempFindMusic=global.msc_MasterPlan
}
else if tTrackPlay=1012
{
  if !SS_IsHandleValid(global.msc_Trivia)
    global.msc_Trivia=SS_LoadSound(working_directory+"\Music\DT_Trivia.ogg",bStream)
  tempFindMusic=global.msc_Trivia
}
else if tTrackPlay=1013
{
  if !SS_IsHandleValid(global.msc_TD)
    global.msc_TD=SS_LoadSound(working_directory+"\Music\DT_TD.ogg",bStream)
  tempFindMusic=global.msc_TD
}
else if tTrackPlay=1014
{
  if !SS_IsHandleValid(global.msc_DarkAmbience)
    global.msc_DarkAmbience=SS_LoadSound(working_directory+"\Music\DT_DarkAmbience.ogg",bStream)
  tempFindMusic=global.msc_DarkAmbience
}
else if tTrackPlay=1015
{
  if !SS_IsHandleValid(global.msc_WarshipA)
    global.msc_WarshipA=SS_LoadSound(working_directory+"\Music\DT_WarshipA.ogg",bStream)
  tempFindMusic=global.msc_WarshipA
}
else if tTrackPlay=1016
{
  if !SS_IsHandleValid(global.msc_WarshipB)
    global.msc_WarshipB=SS_LoadSound(working_directory+"\Music\DT_WarshipB.ogg",bStream)
  tempFindMusic=global.msc_WarshipB
}
else if tTrackPlay=1017
{
  if !SS_IsHandleValid(global.msc_BowserAppears)
    global.msc_BowserAppears=SS_LoadSound(working_directory+"\Music\DT_BowserAppears.ogg",bStream)
  tempFindMusic=global.msc_BowserAppears
}
else if tTrackPlay=1018
{
  if !SS_IsHandleValid(global.msc_IntendedPattern)
    global.msc_IntendedPattern=SS_LoadSound(working_directory+"\Music\DT_IntendedPattern.ogg",bStream)
  tempFindMusic=global.msc_IntendedPattern
}
else if tTrackPlay=1019
{
  if !SS_IsHandleValid(global.msc_TheInstruments)
    global.msc_TheInstruments=SS_LoadSound(working_directory+"\Music\DT_TheInstruments.ogg",bStream)
  tempFindMusic=global.msc_TheInstruments
}
else if tTrackPlay=1020
{
  if !SS_IsHandleValid(global.msc_LastRun)
    global.msc_LastRun=SS_LoadSound(working_directory+"\Music\DT_LastRun.ogg",bStream)
  tempFindMusic=global.msc_LastRun
}
else if tTrackPlay=1021
{
  if !SS_IsHandleValid(global.msc_Credits)
    global.msc_Credits=SS_LoadSound(working_directory+"\Music\DT_Credits.ogg",bStream)
  tempFindMusic=global.msc_Credits
}
else if tTrackPlay=1022
{
  if !SS_IsHandleValid(global.msc_NoneChosen)
    global.msc_NoneChosen=SS_LoadSound(working_directory+"\Music\DT_NoneChosen.ogg",bStream)
  tempFindMusic=global.msc_NoneChosen
}
else if tTrackPlay=1023
{
  if !SS_IsHandleValid(global.msc_BossGallery)
    global.msc_BossGallery=SS_LoadSound(working_directory+"\Music\DT_BossGallery.ogg",bStream)
  tempFindMusic=global.msc_BossGallery
}
else if tTrackPlay=1024
{
  if !SS_IsHandleValid(global.msc_PttT)
    global.msc_PttT=SS_LoadSound(working_directory+"\Music\DT_PttT.ogg",bStream)
  tempFindMusic=global.msc_PttT
}
else if tTrackPlay=1025
{
  if !SS_IsHandleValid(global.msc_Skyfall)
    global.msc_Skyfall=SS_LoadSound(working_directory+"\Music\DT_Skyfall.ogg",bStream)
  tempFindMusic=global.msc_Skyfall
}
else if tTrackPlay=1026
{
  if !SS_IsHandleValid(global.msc_PtHA)
    global.msc_PtHA=SS_LoadSound(working_directory+"\Music\DT_PtHA.ogg",bStream)
  tempFindMusic=global.msc_PtHA
}
else if tTrackPlay=1027
{
  if !SS_IsHandleValid(global.msc_Scrolling)
    global.msc_Scrolling=SS_LoadSound(working_directory+"\Music\DT_Scrolling.ogg",bStream)
  tempFindMusic=global.msc_Scrolling
}

if tTrackPlay!=0 {return tempFindMusic}
else {return 0}
