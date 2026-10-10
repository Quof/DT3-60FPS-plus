/*
sound volume change (added): each sound effect's loudness adjustment in dB, for playSound. Like the music's (getReplayGain), measured with EBU R128 (integrated loudness, short sounds padded
with silence). The level is the music's, -16.5 LUFS (getReplayGain's -18 with its +1.5): the sounds louder than that are
turned down to it. Quieter ones can't be turned up (SS_SetSoundVol goes up to the file's own volume), so they aren't
listed.
Called once by oInitializeGame, right after loadExtFiles.
*/
global.sndGain=ds_map_create()
ds_map_add(global.sndGain,global.snd_PlayerJump[1],-2.4) //DT_PlayerJump2.wav, -14.1 LUFS
ds_map_add(global.sndGain,global.snd_MarioKick,-1.8) //DT_MarioKick.wav, -14.7 LUFS
ds_map_add(global.sndGain,global.snd_MarioStomp,-0.9) //DT_MarioStomp.wav, -15.6 LUFS
ds_map_add(global.sndGain,global.snd_KirbySuck,-2.5) //DT_KirbySuck.wav, -14.0 LUFS
ds_map_add(global.sndGain,global.snd_AirBubble,-3.6) //DT_AirBubble.wav, -12.9 LUFS
ds_map_add(global.sndGain,global.snd_GameOver,-3.4) //DT_GameOver.wav, -13.1 LUFS
ds_map_add(global.sndGain,global.snd_PlayerAtk[3],-0.9) //DT_PlayerAtk4.wav, -15.6 LUFS
ds_map_add(global.sndGain,global.snd_DaggerHit,-4.8) //DT_DaggerHit.wav, -11.7 LUFS
ds_map_add(global.sndGain,global.snd_HolyWater,-5.0) //DT_HolyWater.wav, -11.5 LUFS
ds_map_add(global.sndGain,global.snd_MetroidBomb,-3.3) //DT_MetroidBomb.wav, -13.2 LUFS
ds_map_add(global.sndGain,global.snd_ComicHit1,-5.7) //DT_ComicHit1.wav, -10.8 LUFS
ds_map_add(global.sndGain,global.snd_ComicHit2,-4.9) //DT_ComicHit2.wav, -11.6 LUFS
ds_map_add(global.sndGain,global.snd_ComicHit3,-3.3) //DT_ComicHit3.wav, -13.2 LUFS
ds_map_add(global.sndGain,global.snd_MMBuster[1],-4.3) //DT_MMBuster2.wav, -12.2 LUFS
ds_map_add(global.sndGain,global.snd_MMBuster[2],-1.0) //DT_MMBuster3.wav, -15.5 LUFS
ds_map_add(global.sndGain,global.snd_MetShotB,-0.5) //DT_MetShotB.wav, -16.0 LUFS
ds_map_add(global.sndGain,global.snd_MetMissile,-1.8) //DT_MetMissile.wav, -14.7 LUFS
ds_map_add(global.sndGain,global.snd_MarioCannon,-3.1) //DT_MarioCannon.wav, -13.4 LUFS
ds_map_add(global.sndGain,global.snd_ThwompHit,-4.3) //DT_ThwompHit.wav, -12.2 LUFS
ds_map_add(global.sndGain,global.snd_Bobomb,-0.6) //DT_Bobomb.wav, -15.9 LUFS
ds_map_add(global.sndGain,global.snd_Fireball,-2.6) //DT_Fireball.wav, -13.9 LUFS
ds_map_add(global.sndGain,global.snd_HardHit2,-2.3) //DT_HardHit2.wav, -14.2 LUFS
ds_map_add(global.sndGain,global.snd_Flame1,-1.2) //DT_Flame1.wav, -15.3 LUFS
ds_map_add(global.sndGain,global.snd_Beam,-0.8) //DT_Beam.wav, -15.7 LUFS
ds_map_add(global.sndGain,global.snd_BombLaunch,-7.4) //DT_BombLaunch.wav, -9.1 LUFS
ds_map_add(global.sndGain,global.snd_RidleyFire,-4.7) //DT_RidleyFire.wav, -11.8 LUFS
ds_map_add(global.sndGain,global.snd_Shock,-10.7) //DT_Shock.wav, -5.8 LUFS
ds_map_add(global.sndGain,global.snd_Dec_ChargeUp,-5.4) //DT_Dec_ChargeUp.wav, -11.1 LUFS
ds_map_add(global.sndGain,global.snd_Dec_Fire,-2.1) //DT_Dec_Fire.wav, -14.4 LUFS
ds_map_add(global.sndGain,global.snd_EnemyDie,-2.7) //DT_EnemyDie.wav, -13.8 LUFS
ds_map_add(global.sndGain,global.snd_EnemyDieZelda,-0.9) //DT_EnemyDieZelda.wav, -15.6 LUFS
ds_map_add(global.sndGain,global.snd_MetEnemyDieA,-2.2) //DT_MetEnemyDieA.wav, -14.3 LUFS
ds_map_add(global.sndGain,global.snd_Wilhelm,-7.1) //DT_Wilhelm.wav, -9.4 LUFS
ds_map_add(global.sndGain,global.snd_DemonLaugh,-1.3) //DT_DemonLaugh.wav, -15.2 LUFS
ds_map_add(global.sndGain,global.snd_DemonTalk,-0.6) //DT_DemonTalk.wav, -15.9 LUFS
ds_map_add(global.sndGain,global.snd_RidleyScreamA,-6.1) //DT_RidleyScreamA.wav, -10.4 LUFS
ds_map_add(global.sndGain,global.snd_RidleyScreamB,-4.0) //DT_RidleyScreamB.wav, -12.5 LUFS
ds_map_add(global.sndGain,global.snd_KraidRoarA,-4.5) //DT_KraidRoarA.wav, -12.0 LUFS
ds_map_add(global.sndGain,global.snd_PortalCreate,-3.4) //DT_PortalCreate.wav, -13.1 LUFS
ds_map_add(global.sndGain,global.snd_VO_GH_01,-0.9) //DT_VO_GH_01.wav, -15.6 LUFS
ds_map_add(global.sndGain,global.snd_MoneyPickup,-6.2) //DT_MoneyPickup.wav, -10.3 LUFS
ds_map_add(global.sndGain,global.snd_SkillCapsule,-1.4) //DT_SkillCapsule.wav, -15.1 LUFS
ds_map_add(global.sndGain,global.snd_MarioBlockBreak,-1.2) //DT_MarioBlockBreak.wav, -15.3 LUFS
ds_map_add(global.sndGain,global.snd_ItemSprout,-3.1) //DT_ItemSprout.wav, -13.4 LUFS
ds_map_add(global.sndGain,global.snd_SwitchHit,-4.1) //DT_SwitchHit.wav, -12.4 LUFS
ds_map_add(global.sndGain,global.snd_Teleport,-7.9) //DT_Teleport.wav, -8.6 LUFS
ds_map_add(global.sndGain,global.snd_MMDoorClose,-3.7) //DT_MMDoorClose.wav, -12.8 LUFS
ds_map_add(global.sndGain,global.snd_MetDoorOpen,-1.0) //DT_MetDoorOpen.wav, -15.5 LUFS
ds_map_add(global.sndGain,global.snd_Slam,-4.1) //DT_Slam.wav, -12.4 LUFS
ds_map_add(global.sndGain,global.snd_Static,-6.5) //DT_Static.wav, -10.0 LUFS
ds_map_add(global.sndGain,global.snd_Spark,-5.8) //DT_Spark.wav, -10.7 LUFS
ds_map_add(global.sndGain,global.snd_Alert,-1.1) //DT_Alert.wav, -15.4 LUFS
ds_map_add(global.sndGain,global.snd_Earthquake,-0.6) //DT_Earthquake.wav, -15.9 LUFS
ds_map_add(global.sndGain,global.snd_FadeAway,-2.4) //DT_FadeAway.wav, -14.1 LUFS
ds_map_add(global.sndGain,global.snd_DoorOpen,-1.7) //DT_DoorOpen.wav, -14.8 LUFS
ds_map_add(global.sndGain,global.snd_Secret,-0.6) //DT_Secret.wav, -15.9 LUFS
ds_map_add(global.sndGain,global.snd_killChain[0],-6.7) //DT_KC_1.wav, -9.8 LUFS
ds_map_add(global.sndGain,global.snd_killChain[1],-7.3) //DT_KC_2.wav, -9.2 LUFS
ds_map_add(global.sndGain,global.snd_killChain[2],-7.7) //DT_KC_3.wav, -8.8 LUFS
ds_map_add(global.sndGain,global.snd_killChain[3],-7.3) //DT_KC_4.wav, -9.2 LUFS
ds_map_add(global.sndGain,global.snd_killChain[4],-5.7) //DT_KC_5.wav, -10.8 LUFS
ds_map_add(global.sndGain,global.snd_killChain[5],-7.3) //DT_KC_6.wav, -9.2 LUFS
ds_map_add(global.sndGain,global.snd_killChain[6],-5.7) //DT_KC_7.wav, -10.8 LUFS
ds_map_add(global.sndGain,global.snd_killChain[7],-1.4) //DT_KC_8.wav, -15.1 LUFS
ds_map_add(global.sndGain,global.snd_killChain[8],-4.5) //DT_KC_9.wav, -12.0 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[0],-8.2) //DT_KS_1.wav, -8.3 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[1],-7.4) //DT_KS_2.wav, -9.1 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[2],-7.8) //DT_KS_3.wav, -8.7 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[3],-7.6) //DT_KS_4.wav, -8.9 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[4],-5.6) //DT_KS_5.wav, -10.9 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[5],-7.2) //DT_KS_6.wav, -9.3 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[6],-8.4) //DT_KS_7.wav, -8.1 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[7],-6.3) //DT_KS_8.wav, -10.2 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[8],-8.0) //DT_KS_9.wav, -8.5 LUFS
ds_map_add(global.sndGain,global.snd_killingSpree[9],-6.5) //DT_KS_10.wav, -10.0 LUFS
ds_map_add(global.sndGain,global.snd_SkillGet,-3.9) //DT_SkillGet.wav, -12.6 LUFS
