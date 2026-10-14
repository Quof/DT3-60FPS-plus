oTD_HUD.tdStat_Wave+=1
with oTD_FlagPole
{
  if oTD_HUD.tdStat_Wave=1 {waveCountdown=1800}
  else {waveCountdown=900}
  bWaveStart=0
}
