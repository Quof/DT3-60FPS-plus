//Evil Boss Gallery: Evil Bowser's inferno catches (in his instance): a flame (oEvgFloorFlame) on the highest brick or
//bottom block of each 16px column of the arena (576-863), lit later the further it is from his feet (2 ticks a column),
//all of them out at the end of the inferno (infernoLen)
var cx,yy,tTop,tF;
for(cx=576;cx<864;cx+=16)
{
  tTop=-1
  for(yy=272;yy<=336;yy+=16)
  {
    if tTop<0
    {
      if position_meeting(cx+8,yy+8,oMarioBreakBlock) {tTop=yy}
      else if position_meeting(cx+8,yy+8,oBowBottomBlock) {tTop=yy}
    }
  }
  if tTop>=0
  {
    tF=instance_create(cx+8,tTop,oEvgFloorFlame)
    tF.delay=floor(abs(cx+8-x)/16)*2
    tF.burnTime=infernoLen-tF.delay
    tF.atkPower=3
  }
}
