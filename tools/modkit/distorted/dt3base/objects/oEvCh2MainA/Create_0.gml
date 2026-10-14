//----- Gate 1: Mario World -----
event_inherited()
enemyCount=-1
fadeColor=c_white
if global.gameProgress=150
  fadeAlpha=1
else
  fadeAlpha=0

if room=rMario1_CCc
{
  xScrollSpd=2
  autoScroll=instance_create(240,176,oMisc)
  autoScroll.type=0
  autoScroll.sprite_index=sNull
  view_object[0]=autoScroll
}
else if room=rMario1_CCBoss
  circleRad=0
