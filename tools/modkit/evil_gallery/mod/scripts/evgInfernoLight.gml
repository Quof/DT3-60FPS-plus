//Evil Boss Gallery: a wave of Evil Bowser's inferno (in his instance): a flame (oEvgFloorFlame) on the highest brick or
//bottom block of each 16px column of the arena (576-863) in the strips of group argument0 (the floor in 32px strips
//from 576, every other one: 0 the first, 1 the second), glowing for argument1 ticks before it rises, then burning for
//infernoBurn
var cx,yy,tTop,tF;
for(cx=576;cx<864;cx+=16)
{
  if (floor((cx-576)/32) mod 2)=argument0
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
      tF.delay=argument1
      tF.burnTime=infernoBurn
      tF.atkPower=3
    }
  }
}
