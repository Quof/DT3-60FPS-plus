event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

instrumentProg=0
instrumentActNum=0
instrumentReq=6
musicPlaying=1 //0 Abomination, 1 Instrument
spawnWalls=0

if room=rCh21_Main_76
{
  instrMoveProg=0
  instrDist=30
  instrAng=0
}

spsp=0
spspTime=0
spspConvo=0
holdY=oPlayer1.y

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
