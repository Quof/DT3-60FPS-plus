//Randomizer: a way into a room the player has come in by (argument0: the room, argument1, argument2: where they came
//in), kept for a Teleport Trap (rndSnareTeleport): each one once, the newest 400 (the oldest goes)
var i,tX,tY;
tX=round(argument1)
tY=round(argument2)
for(i=0;i<global.rndSnareHistN;i+=1)
{
  if global.rndSnareHistR[i]=argument0 and global.rndSnareHistX[i]=tX and global.rndSnareHistY[i]=tY {exit}
}
if global.rndSnareHistN>=400
{
  for(i=1;i<global.rndSnareHistN;i+=1)
  {
    global.rndSnareHistR[i-1]=global.rndSnareHistR[i]
    global.rndSnareHistX[i-1]=global.rndSnareHistX[i]
    global.rndSnareHistY[i-1]=global.rndSnareHistY[i]
  }
  global.rndSnareHistN-=1
}
global.rndSnareHistR[global.rndSnareHistN]=argument0
global.rndSnareHistX[global.rndSnareHistN]=tX
global.rndSnareHistY[global.rndSnareHistN]=tY
global.rndSnareHistN+=1
