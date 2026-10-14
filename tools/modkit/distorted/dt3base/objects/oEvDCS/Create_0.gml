event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

runeProg=0
if room=rDCS_G
{
  if global.newMapX>=512 {spiderTrap=100}
  else {spiderTrap=0}
}
else if room=rDCS_H
{
  runeCheck=string_char_at(global.gameDCS_Prog,1)
}
else if room=rDCS_N
{
  runeCheck=string_char_at(global.gameDCS_Prog,3)
}
else if room=rDCS_O
{
  runeCheck=string_char_at(global.gameDCS_Prog,4)
}
else if room=rDCS_Q
{
  runeCheck=string_char_at(global.gameDCS_Prog,4)
}
else if room=rDCS_S
{
  if global.newMapX>=512
  {
    with oTempleGhost {instance_destroy()}
    with oEventBarrier {instance_destroy()}
    ghostDoors=100
  }
  else {ghostDoors=0}
}
else if room=rDCS_U
{
  hexFlash=0
  hexTime=0
  hexX=0; hexY=0
  roomShake=0
}
else if room=rDCS_V
{
  portalWave=0
  pullIn=0
  pullSpeed=0
  effectTime=0
}
