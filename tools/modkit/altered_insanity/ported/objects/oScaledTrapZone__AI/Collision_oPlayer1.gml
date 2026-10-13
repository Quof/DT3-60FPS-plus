if atkPower=1000
{
  if oPlayer1.bCanTakeHit=true and oPlayer1.dashInvulnerabilityTime=0
    oPlayer1.life-=oPlayer1.maxLife
}
if room=rBT_Cousinoer5HUB_Newer
{
    redDmgHit(0)
}
if room=rC5_Arena2 or room=rC5_Arena9
{
    //insta death touching the floor
    oPlayer1.life-=oPlayer1.maxLife
}
else
  event_inherited()
