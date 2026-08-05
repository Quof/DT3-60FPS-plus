///getReplayGainMultiplier(argument0)
/*
Returns a linear volume multiplier (0-1+ range) computed from a per-track
ReplayGain dB value, for use as a multiplier against playSound()'s existing
volume argument.

argument0: the music sound resource (e.g. DT_AbominationA)

Usage in playSound() or at the call site:
  playSound(DT_Main1, 1, 1*getReplayGainMultiplier(DT_Main1), 1)

linear = 10^(dB/20) is the standard dB-to-amplitude-ratio conversion.
Tracks with positive dB values (want to be MADE LOUDER) return a multiplier
above 1.0 -- if you multiply against a base volume already at 1.0, this can
exceed GM's expected 0-1 volume range on some tracks (DT_TranquilSerenity
is +11.43dB -> 3.73x). If GM clamps or misbehaves above 1.0, clamp the
return value here instead of leaving it uncapped.
*/
var dB, refOffset;
refOffset = -1; //adjust decibles with positive or negative numbers here
switch (argument0)
{
  case 1: dB=-5.12; break; //DT_Main1
  case 2: dB=-2.82; break; //DT_CentralCityA
  case 3: dB=-12.07; break; //DT_GamerRun
  case 4: dB=-1.60; break; //DT_Main2
  case 5: dB=-2.45; break; //DT_LabyrinthRuins
  case 6: dB=-6.54; break; //DT_AncientGateway
  case 7: dB=-7.41; break; //DT_Main3
  case 8: dB=-7.65; break; //DT_BegoniaTemple
  case 9: dB=-6.49; break; //DT_MomentOfTruth
  case 10: dB=-7.83; break; //DT_Farreaches
  case 11: dB=-1.72; break; //DT_Vault
  case 13: dB=-2.98; break; //DT_Barrens
  case 14: dB=-9.86; break; //DT_BurningStretch
  case 15: dB=-7.84; break; //DT_SRDreamer
  case 16: dB=-3.89; break; //DT_NGCLowerChamber
  case 17: dB=-11.25; break; //DT_CityEscape
  case 19: dB=-5.57; break; //DT_CentralCore
  case 20: dB=-1.46; break; //DT_VirusInfection
  case 21: dB=-5.23; break; //DT_StarrySkies
  case 22: dB=-4.96; break; //DT_WeaponFacility
  case 23: dB=-10.55; break; //DT_MarioLavaRoad
  case 24: dB=-8.76; break; //DT_Main4
  case 25: dB=0.33; break; //DT_NoMain
  case 26: dB=11.43; break; //DT_TranquilSerenity
  case 27: dB=-6.17; break; //DT_HiddenTown
  case 28: dB=-7.10; break; //DT_Discombobulated
  case 29: dB=-5.28; break; //DT_SubconsciousFilter
  case 30: dB=-8.07; break; //DT_MagicalCastle
  case 31: dB=0.20; break; //DT_BTBSZ
  case 101: dB=2.87; break; //DT_MarioWorld
  case 102: dB=1.78; break; //DT_MarioCastle1
  case 103: dB=-7.74; break; //DT_MarioCastle2
  case 104: dB=-3.10; break; //DT_MarioUnderground
  case 105: dB=-1.38; break; //DT_MarioCastle3
  case 201: dB=1.86; break; //DT_ZeldaWater
  case 202: dB=-1.54; break; //DT_OminousHall
  case 203: dB=-4.55; break; //DT_ZeldaOverworld
  case 204: dB=1.01; break; //DT_ZeldaDunA
  case 205: dB=-6.57; break; //DT_ZeldaDunB
  case 206: dB=-7.17; break; //DT_ZeldaTown
  case 207: dB=-4.19; break; //DT_ZeldasTheme
  case 208: dB=-9.58; break; //DT_DeathMountain
  case 209: dB=1.04; break; //DT_ZeldaForest
  case 301: dB=-2.73; break; //DT_CVVampireKiller
  case 302: dB=-7.98; break; //DT_CVHeartOfFire
  case 303: dB=-9.33; break; //DT_CVSimonsTheme
  case 304: dB=-4.71; break; //DT_CVMarbleGallery
  case 305: dB=-1.12; break; //DT_CVCastleCourtyard
  case 306: dB=-5.64; break; //DT_CVOutOfTime
  case 307: dB=-3.63; break; //DT_CVReapersHall
  case 401: dB=-6.85; break; //DT_MMIntroStage
  case 402: dB=1.00; break; //DT_MMBossIntro
  case 403: dB=-3.80; break; //DT_MMVictory
  case 404: dB=-7.98; break; //DT_MMStormEagle
  case 405: dB=-9.32; break; //DT_MMStageSelect
  case 406: dB=-6.33; break; //DT_MMStageIntro
  case 407: dB=-7.40; break; //DT_MMWeaponGet
  case 408: dB=-12.25; break; //DT_MMOverdriveOstrich
  case 409: dB=-6.38; break; //DT_MMToxicJungle
  case 410: dB=-5.22; break; //DT_MMSigmaStage1
  case 411: dB=-12.70; break; //DT_MMSigmaStage2
  case 412: dB=-5.35; break; //DT_MMSigmaStage3
  case 501: dB=2.97; break; //DT_MetMain
  case 502: dB=-2.41; break; //DT_MetBrinstar
  case 503: dB=-3.09; break; //DT_MetNorfair
  case 504: dB=-5.12; break; //DT_MetMaridia
  case 505: dB=2.39; break; //DT_MetTourian
  case 601: dB=-8.59; break; //DT_RPGOverworld
  case 602: dB=-8.76; break; //DT_RPGPlains
  case 603: dB=-1.49; break; //DT_RPGTown
  case 604: dB=-5.62; break; //DT_RPGDoomCastle
  case 605: dB=-1.74; break; //DT_RPGElementsA
  case 606: dB=-5.88; break; //DT_RPGDreamWoods
  case 607: dB=-9.50; break; //DT_RPGElementsB
  case 801: dB=-9.42; break; //DT_BowserFight
  case 802: dB=-10.83; break; //DT_ZeldaMiniBoss
  case 803: dB=-8.82; break; //DT_ZeldaBoss
  case 804: dB=-1.11; break; //DT_CVDanceOfIllusions
  case 805: dB=-10.19; break; //DT_CVPiercingBattleFury
  case 806: dB=-9.18; break; //DT_CVDanceWithDeath
  case 807: dB=-10.04; break; //DT_FamiliarFoe
  case 808: dB=-1.71; break; //DT_FinalNightmare
  case 809: dB=-5.65; break; //DT_Encounter
  case 810: dB=-1.81; break; //DT_MMBossFight
  case 812: dB=-8.37; break; //DT_MMEpsilon
  case 813: dB=-11.19; break; //DT_GiantEnemyRobot
  case 814: dB=-6.08; break; //DT_AbominationA
  case 815: dB=-5.83; break; //DT_MetroidBoss
  case 816: dB=-6.31; break; //DT_MetRidley
  case 817: dB=-11.04; break; //DT_MetNightmare
  case 818: dB=-10.54; break; //DT_MarioBoss
  case 819: dB=-4.64; break; //DT_RPGBoss
  case 820: dB=-5.70; break; //DT_OWA
  case 821: dB=-7.55; break; //DT_Sera
  case 822: dB=-3.68; break; //DT_AbominationB
  case 823: dB=-6.80; break; //DT_AbominationC
  case 824: dB=-8.86; break; //DT_CVBoss
  case 825: dB=-8.40; break; //DT_ChaosBossA
  case 826: dB=-3.72; break; //DT_Defective
  case 827: dB=-5.59; break; //DT_DarkShadow
  case 828: dB=-9.17; break; //DT_TheBattle
  case 829: dB=-9.47; break; //DT_ChaosWarmaster
  case 830: dB=-3.14; break; //DT_Hatred
  case 831: dB=-8.39; break; //DT_ParasiticSeed
  case 832: dB=-5.01; break; //DT_VirusParasite
  case 833: dB=-6.87; break; //DT_DistortedEncounterA
  case 834: dB=0.64; break; //DT_TheExecutive
  case 835: dB=-9.74; break; //DT_WEX
  case 901: dB=-0.25; break; //DT_EerieFaces
  case 902: dB=-4.74; break; //DT_SacredTemple
  case 903: dB=-6.53; break; //DT_CVGhostlyTheatre
  case 904: dB=-7.94; break; //DT_MMCityScape
  case 905: dB=-2.71; break; //DT_ForgottenIsles
  case 906: dB=-3.47; break; //DT_TheHouse
  case 907: dB=-1.26; break; //DT_NoControl
  case 1001: dB=-8.41; break; //DT_IFA
  case 1002: dB=-3.63; break; //DT_IFB
  case 1003: dB=-0.26; break; //DT_IFC
  case 1004: dB=-8.70; break; //DT_MonsterRoaming
  case 1005: dB=-6.72; break; //DT_SeraBegin
  case 1010: dB=-6.28; break; //DT_FortressSkyguard
  case 1011: dB=-11.31; break; //DT_MasterPlan
  case 1012: dB=-0.55; break; //DT_Trivia
  case 1013: dB=-1.45; break; //DT_TD
  case 1014: dB=0.12; break; //DT_DarkAmbience
  case 1015: dB=-8.85; break; //DT_WarshipA
  case 1017: dB=3.34; break; //DT_BowserAppears
  case 1018: dB=-10.52; break; //DT_IntendedPattern
  case 1019: dB=-4.26; break; //DT_TheInstruments
  case 1020: dB=-2.39; break; //DT_LastRun
  case 1021: dB=2.51; break; //DT_Credits
  case 1022: dB=-2.04; break; //DT_NoneChosen
  case 1023: dB=-5.39; break; //DT_BossGallery
  case 1024: dB=-7.74; break; //DT_PttT
  case 1025: dB=-6.81; break; //DT_Skyfall
  case 1026: dB=0.27; break; //DT_PtHA
  case 1027: dB=-5.24; break; //DT_Scrolling
  default:
    dB=0;
    show_debug_message("getReplayGainMultiplier: no entry for " + string(argument0));
    break;
}
return dB+refOffset;
