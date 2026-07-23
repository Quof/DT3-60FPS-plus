/*
This script finds which set of music files to remove from memory
argument0: section of music to unload
*/
var tSectionUnload;
tSectionUnload=argument0

if tSectionUnload=0 //----- Mainland -----
{
  SS_FreeSound(global.msc_Main1); global.msc_Main1=0
  SS_FreeSound(global.msc_Main2); global.msc_Main2=0
  SS_FreeSound(global.msc_Main3); global.msc_Main3=0
  SS_FreeSound(global.msc_Main4); global.msc_Main4=0
  SS_FreeSound(global.msc_NoMain); global.msc_NoMain=0
  SS_FreeSound(global.msc_CentralCityA); global.msc_CentralCityA=0
  SS_FreeSound(global.msc_GamerRun); global.msc_GamerRun=0
  SS_FreeSound(global.msc_FamiliarFoe); global.msc_FamiliarFoe=0
  SS_FreeSound(global.msc_LabyrinthRuins); global.msc_LabyrinthRuins=0
  SS_FreeSound(global.msc_AncientGateway); global.msc_AncientGateway=0
  SS_FreeSound(global.msc_BegoniaTemple); global.msc_BegoniaTemple=0
  SS_FreeSound(global.msc_Encounter); global.msc_Encounter=0
  SS_FreeSound(global.msc_SacredTemple); global.msc_SacredTemple=0
  SS_FreeSound(global.msc_MomentOfTruth); global.msc_MomentOfTruth=0
  SS_FreeSound(global.msc_Farreaches); global.msc_Farreaches=0
  SS_FreeSound(global.msc_GiantEnemyRobot); global.msc_GiantEnemyRobot=0
  SS_FreeSound(global.msc_Vault); global.msc_Vault=0
  SS_FreeSound(global.msc_AbominationA); global.msc_AbominationA=0
  SS_FreeSound(global.msc_AbominationB); global.msc_AbominationB=0
  SS_FreeSound(global.msc_AbominationC); global.msc_AbominationC=0
  SS_FreeSound(global.msc_Barrens); global.msc_Barrens=0
  SS_FreeSound(global.msc_BurningStretch); global.msc_BurningStretch=0
  SS_FreeSound(global.msc_SRDreamer); global.msc_SRDreamer=0
  SS_FreeSound(global.msc_NGCLowerChamber); global.msc_NGCLowerChamber=0
  SS_FreeSound(global.msc_CityEscape); global.msc_CityEscape=0
  SS_FreeSound(global.msc_GamesNeverDie); global.msc_GamesNeverDie=0
  SS_FreeSound(global.msc_VirusInfection); global.msc_VirusInfection=0
  SS_FreeSound(global.msc_CentralCore); global.msc_CentralCore=0
  SS_FreeSound(global.msc_Sera); global.msc_Sera=0
  SS_FreeSound(global.msc_StarrySkies); global.msc_StarrySkies=0
  SS_FreeSound(global.msc_WeaponFacility); global.msc_WeaponFacility=0
  SS_FreeSound(global.msc_ChaosBossA); global.msc_ChaosBossA=0
  SS_FreeSound(global.msc_MarioLavaRoad); global.msc_MarioLavaRoad=0
  SS_FreeSound(global.msc_TranquilSerenity); global.msc_TranquilSerenity=0
  SS_FreeSound(global.msc_NoControl); global.msc_NoControl=0
  SS_FreeSound(global.msc_WarshipA); global.msc_WarshipA=0
  SS_FreeSound(global.msc_WarshipB); global.msc_WarshipB=0
  SS_FreeSound(global.msc_IFA); global.msc_IFA=0
  SS_FreeSound(global.msc_IFB); global.msc_IFB=0
  SS_FreeSound(global.msc_IFC); global.msc_IFC=0
  SS_FreeSound(global.msc_MonsterRoaming); global.msc_MonsterRoaming=0
  SS_FreeSound(global.msc_SeraBegin); global.msc_SeraBegin=0
  SS_FreeSound(global.msc_MasterPlan); global.msc_MasterPlan=0
  SS_FreeSound(global.msc_Trivia); global.msc_Trivia=0
  SS_FreeSound(global.msc_TD); global.msc_TD=0
  SS_FreeSound(global.msc_DarkAmbience); global.msc_DarkAmbience=0
  SS_FreeSound(global.msc_FortressSkyguard); global.msc_FortressSkyguard=0
  SS_FreeSound(global.msc_HiddenTown); global.msc_HiddenTown=0
  SS_FreeSound(global.msc_Discombobulated); global.msc_Discombobulated=0
  SS_FreeSound(global.msc_Defective); global.msc_Defective=0
  SS_FreeSound(global.msc_DarkShadow); global.msc_DarkShadow=0
  SS_FreeSound(global.msc_TheBattle); global.msc_TheBattle=0
  SS_FreeSound(global.msc_ChaosWarmaster); global.msc_ChaosWarmaster=0
  SS_FreeSound(global.msc_SubconsciousFilter); global.msc_SubconsciousFilter=0
  SS_FreeSound(global.msc_MagicalCastle); global.msc_MagicalCastle=0
  SS_FreeSound(global.msc_BowserAppears); global.msc_BowserAppears=0
  SS_FreeSound(global.msc_IntendedPattern); global.msc_IntendedPattern=0
  SS_FreeSound(global.msc_TheHouse); global.msc_TheHouse=0
  SS_FreeSound(global.msc_TheInstruments); global.msc_TheInstruments=0
  SS_FreeSound(global.msc_Hatred); global.msc_Hatred=0
  SS_FreeSound(global.msc_LastRun); global.msc_LastRun=0
  SS_FreeSound(global.msc_Credits); global.msc_Credits=0
  SS_FreeSound(global.msc_NoneChosen); global.msc_NoneChosen=0
  SS_FreeSound(global.msc_BossGallery); global.msc_BossGallery=0
  SS_FreeSound(global.msc_PttT); global.msc_PttT=0
  SS_FreeSound(global.msc_ParasiticSeed); global.msc_ParasiticSeed=0
  SS_FreeSound(global.msc_VirusParasite); global.msc_VirusParasite=0
  SS_FreeSound(global.msc_Skyfall); global.msc_Skyfall=0
  SS_FreeSound(global.msc_PtHA); global.msc_PtHA=0
  SS_FreeSound(global.msc_DistortedEncounterA); global.msc_DistortedEncounterA=0
  SS_FreeSound(global.msc_TheExecutive); global.msc_TheExecutive=0
  SS_FreeSound(global.msc_ChaosWarmasterEX); global.msc_ChaosWarmasterEX=0
  SS_FreeSound(global.msc_Scrolling); global.msc_Scrolling=0
  SS_FreeSound(global.msc_BTBSZ); global.msc_BTBSZ=0
}
else if tSectionUnload=1 //----- Gate 1: Mario -----
{
  SS_FreeSound(global.msc_MarioWorld); global.msc_MarioWorld=0
  SS_FreeSound(global.msc_MarioCastle1); global.msc_MarioCastle1=0
  SS_FreeSound(global.msc_MarioCastle2); global.msc_MarioCastle2=0
  SS_FreeSound(global.msc_MarioCastle3); global.msc_MarioCastle3=0
  SS_FreeSound(global.msc_BowserFight); global.msc_BowserFight=0
  SS_FreeSound(global.msc_MarioUnderground); global.msc_MarioUnderground=0
  SS_FreeSound(global.msc_Starman); global.msc_Starman=0
  SS_FreeSound(global.msc_MarioBoss); global.msc_MarioBoss=0
}
else if tSectionUnload=2 //----- Gate 2: Link -----
{
  SS_FreeSound(global.msc_ZeldaOverworld); global.msc_ZeldaOverworld=0
  SS_FreeSound(global.msc_ZeldaWater); global.msc_ZeldaWater=0
  SS_FreeSound(global.msc_OminousHall); global.msc_OminousHall=0
  SS_FreeSound(global.msc_ZeldaDunA); global.msc_ZeldaDunA=0
  SS_FreeSound(global.msc_ZeldaDunB); global.msc_ZeldaDunB=0
  SS_FreeSound(global.msc_ZeldaTown); global.msc_ZeldaTown=0
  SS_FreeSound(global.msc_ZeldasTheme); global.msc_ZeldasTheme=0
  SS_FreeSound(global.msc_DeathMountain); global.msc_DeathMountain=0
  SS_FreeSound(global.msc_ZeldaForest); global.msc_ZeldaForest=0
  SS_FreeSound(global.msc_ZeldaMiniBoss); global.msc_ZeldaMiniBoss=0
  SS_FreeSound(global.msc_ZeldaBoss); global.msc_ZeldaBoss=0
  SS_FreeSound(global.msc_EerieFaces); global.msc_EerieFaces=0
  SS_FreeSound(global.msc_FinalNightmare); global.msc_FinalNightmare=0
}
else if tSectionUnload=3 //----- Gate 3: Castlevania -----
{
  SS_FreeSound(global.msc_VampireKiller); global.msc_VampireKiller=0
  SS_FreeSound(global.msc_SimonsTheme); global.msc_SimonsTheme=0
  SS_FreeSound(global.msc_HeartOfFire); global.msc_HeartOfFire=0
  SS_FreeSound(global.msc_MarbleGallery); global.msc_MarbleGallery=0
  SS_FreeSound(global.msc_CastleCourtyard); global.msc_CastleCourtyard=0
  SS_FreeSound(global.msc_OutOfTime); global.msc_OutOfTime=0
  SS_FreeSound(global.msc_ReapersHall); global.msc_ReapersHall=0
  SS_FreeSound(global.msc_DanceOfIllusions); global.msc_DanceOfIllusions=0
  SS_FreeSound(global.msc_PiercingBattleFury); global.msc_PiercingBattleFury=0
  SS_FreeSound(global.msc_DanceWithDeath); global.msc_DanceWithDeath=0
  SS_FreeSound(global.msc_GhostlyTheatre); global.msc_GhostlyTheatre=0
  SS_FreeSound(global.msc_CVBoss); global.msc_CVBoss=0
}
else if tSectionUnload=4 //----- Gate 4: Mega Man X -----
{
  SS_FreeSound(global.msc_MMIntroStage); global.msc_MMIntroStage=0
  SS_FreeSound(global.msc_MMBossIntro); global.msc_MMBossIntro=0
  SS_FreeSound(global.msc_MMVictory); global.msc_MMVictory=0
  SS_FreeSound(global.msc_MMStormEagle); global.msc_MMStormEagle=0
  SS_FreeSound(global.msc_MMStageSelect); global.msc_MMStageSelect=0
  SS_FreeSound(global.msc_MMBossFight); global.msc_MMBossFight=0
  SS_FreeSound(global.msc_MMStageIntro); global.msc_MMStageIntro=0
  SS_FreeSound(global.msc_MMWeaponGet); global.msc_MMWeaponGet=0
  SS_FreeSound(global.msc_MMOverdriveOstrich); global.msc_MMOverdriveOstrich=0
  SS_FreeSound(global.msc_MMToxicJungle); global.msc_MMToxicJungle=0
  SS_FreeSound(global.msc_MMSigmaStage1); global.msc_MMSigmaStage1=0
  SS_FreeSound(global.msc_MMSigmaStage2); global.msc_MMSigmaStage2=0
  SS_FreeSound(global.msc_MMSigmaStage3); global.msc_MMSigmaStage3=0
  SS_FreeSound(global.msc_MMEpsilon); global.msc_MMEpsilon=0
  SS_FreeSound(global.msc_MMCityScape); global.msc_MMCityScape=0
}
else if tSectionUnload=5 //----- Gate 5: Samus -----
{
  SS_FreeSound(global.msc_MetMain); global.msc_MetMain=0
  SS_FreeSound(global.msc_MetBrinstar); global.msc_MetBrinstar=0
  SS_FreeSound(global.msc_MetNorfair); global.msc_MetNorfair=0
  SS_FreeSound(global.msc_MetMaridia); global.msc_MetMaridia=0
  SS_FreeSound(global.msc_MetTourian); global.msc_MetTourian=0
  SS_FreeSound(global.msc_MetRidley); global.msc_MetRidley=0
  SS_FreeSound(global.msc_MetroidBoss); global.msc_MetroidBoss=0
  SS_FreeSound(global.msc_MetNightmare); global.msc_MetNightmare=0
}
else if tSectionUnload=6 //----- Gate 6: Game -----
{
  SS_FreeSound(global.msc_RPGOverworld); global.msc_RPGOverworld=0
  SS_FreeSound(global.msc_RPGPlains); global.msc_RPGPlains=0
  SS_FreeSound(global.msc_RPGTown); global.msc_RPGTown=0
  SS_FreeSound(global.msc_RPGDoomCastle); global.msc_RPGDoomCastle=0
  SS_FreeSound(global.msc_RPGElementsA); global.msc_RPGElementsA=0
  SS_FreeSound(global.msc_RPGElementsB); global.msc_RPGElementsB=0
  SS_FreeSound(global.msc_RPGDreamWoods); global.msc_RPGDreamWoods=0
  SS_FreeSound(global.msc_RPGBoss); global.msc_RPGBoss=0
  SS_FreeSound(global.msc_ForgottenIsles); global.msc_ForgottenIsles=0
  SS_FreeSound(global.msc_OWA); global.msc_OWA=0
}
