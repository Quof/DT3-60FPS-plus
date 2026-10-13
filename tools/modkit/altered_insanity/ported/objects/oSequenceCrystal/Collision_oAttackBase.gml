event_inherited()
//if oPlayer1.dashEnergy<oPlayer1.dashMeterMax-1000 {oPlayer1.dashEnergy+=1000}
//if other.maxAtkId > 0
//{
//other.maxAtkId-=1
//}
if gDeltaDoTicks //60fps change (added if): once per 30fps tick while an attack overlaps it (every frame gave 2x/4x the dash energy at 60/120fps)
{
if oPlayer1.dashEnergy<oPlayer1.dashMeterMax-1000 {oPlayer1.dashEnergy+=1000}
if other.maxAtkId > 0
{
other.maxAtkId-=1
}
}
