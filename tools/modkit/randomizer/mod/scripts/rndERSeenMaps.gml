//Randomizer: the Check Tracker's Entrance Tracker's tables (rndERSeenArrive), from the door data (rndERLoad): each
//room's number in it by its name (rndERRoomOf), each way in by its room and place, "room:x,y" (rndEEOf), the doors'
//ends whose way back in each way in is (rndEEBackN, rndEEBack: an end's way back in is where its partner's exit has the
//player come in), and each room's exits that aren't a door's end (rndEXOfN, rndEXOf)
var i,k,e,r;
if !variable_global_exists("rndERRoomOf") {global.rndERRoomOf=ds_map_create(); global.rndEEOf=ds_map_create()}
ds_map_clear(global.rndERRoomOf)
ds_map_clear(global.rndEEOf)
for(i=0;i<global.rndERN;i+=1) {if !ds_map_exists(global.rndERRoomOf,global.rndERName[i]) {ds_map_add(global.rndERRoomOf,global.rndERName[i],i)}}
for(i=0;i<global.rndEEN;i+=1)
{
  global.rndEEBackN[i]=0
  k=string(global.rndEERoom[i])+":"+string(global.rndEEX[i])+","+string(global.rndEEY[i])
  if !ds_map_exists(global.rndEEOf,k) {ds_map_add(global.rndEEOf,k,i)}
}
for(i=0;i<global.rndEDN;i+=1)
{
  e=global.rndEDBack[i]
  global.rndEEBack[e,global.rndEEBackN[e]]=i
  global.rndEEBackN[e]+=1
}
for(i=0;i<global.rndERN;i+=1) {global.rndEXOfN[i]=0}
for(i=0;i<global.rndEXN;i+=1)
{
  if global.rndEXEnd[i]<0
  {
    r=global.rndEXRoom[i]
    global.rndEXOf[r,global.rndEXOfN[r]]=i
    global.rndEXOfN[r]+=1
  }
}
