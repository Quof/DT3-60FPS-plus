//Randomizer: the ways into rooms kept for a Teleport Trap (rndSnareHistAdd) as a string, for the save: "room,x,y;" each
//(the room's number, as the game's own save keeps rooms; rndSnareHistFromString reads it back)
var i,s;
s=""
for(i=0;i<global.rndSnareHistN;i+=1)
{
  s+=string(global.rndSnareHistR[i])+","+string(global.rndSnareHistX[i])+","+string(global.rndSnareHistY[i])+";"
}
return s
