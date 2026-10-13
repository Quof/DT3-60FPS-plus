makeActive()
setCollisionBounds(-5,-5,5,5)
global.recAtkNum+=1
global.stLink_Bomb[2]+=1

if oPlayer1.yVel>0
{
  oPlayer1.yVel=0
  scrSlowFall(2,0.4,0)
}
lifeTime=9000
inColTime=0
special=1
image_xscale=0.6
image_yscale=0.6
