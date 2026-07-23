/*
This script finds the default frequency for a sound file.
Returns the default frequency of the music file currently playing.
*/
var tSoundFile,tempFindFreq;
tSoundFile=argument0
tempFindFreq=0

//if SS_IsSoundLooping(global.msc_DustyRuins)
tempFindFreq=22050

/*
if tSoundFile=global.snd_PlayerJump[0] {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerJump[1] {tempFindFreq=22050}
else if tSoundFile=global.snd_JumpLand {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioPipe {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioKick {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioStomp {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerDamaged[0] {tempFindFreq=22050}
else if tSoundFile=global.snd_GameOver {tempFindFreq=22050}
else if tSoundFile=global.snd_Continue {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerAtk[0] {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerAtk[1] {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerAtk[2] {tempFindFreq=22050}
else if tSoundFile=global.snd_PlayerAtk[3] {tempFindFreq=22050}
else if tSoundFile=global.snd_ArrowFling {tempFindFreq=22050}
else if tSoundFile=global.snd_BombExplode {tempFindFreq=22050}
else if tSoundFile=global.snd_DaggerHit {tempFindFreq=22050}
else if tSoundFile=global.snd_HolyWater {tempFindFreq=22050}
else if tSoundFile=global.snd_MetroidBomb {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioCannon {tempFindFreq=22050}
else if tSoundFile=global.snd_ThwompHit {tempFindFreq=22050}
else if tSoundFile=global.snd_Bobomb {tempFindFreq=22050}
else if tSoundFile=global.snd_Fireball {tempFindFreq=22050}
else if tSoundFile=global.snd_EnemyHit {tempFindFreq=22050}
else if tSoundFile=global.snd_EnemyDie {tempFindFreq=22050}
else if tSoundFile=global.snd_MoneyPickup {tempFindFreq=22050}
else if tSoundFile=global.snd_HealthPickup {tempFindFreq=22050}
else if tSoundFile=global.snd_HealingPlant {tempFindFreq=22050}
else if tSoundFile=global.snd_SkillCapsule {tempFindFreq=22050}
else if tSoundFile=global.snd_HeartPiece {tempFindFreq=22050}
else if tSoundFile=global.snd_DoorUnlock {tempFindFreq=22050}
else if tSoundFile=global.snd_ChestOpen {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioCoin {tempFindFreq=22050}
else if tSoundFile=global.snd_MarioBlockBreak {tempFindFreq=22050}
else if tSoundFile=global.snd_SpringJump {tempFindFreq=22050}
else if tSoundFile=global.snd_RBSwitch {tempFindFreq=22050}
else if tSoundFile=global.snd_ItemSprout {tempFindFreq=22050}
else if tSoundFile=global.snd_SwitchHit {tempFindFreq=22050}
else if tSoundFile=global.snd_Teleport {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuOpen {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuClose {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuCursor {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuConfirm {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuCancel {tempFindFreq=22050}
else if tSoundFile=global.snd_MenuShift {tempFindFreq=22050}
else if tSoundFile=global.snd_InfoOn {tempFindFreq=22050}
else if tSoundFile=global.snd_InfoOff {tempFindFreq=22050}
else if tSoundFile=global.snd_SkillGet {tempFindFreq=22050}*/

return tempFindFreq
