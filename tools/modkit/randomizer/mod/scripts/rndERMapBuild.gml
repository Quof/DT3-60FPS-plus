//Randomizer: the entrance randomizer's doors in the game (rndERApplyExit), from its shuffle (global.rndERPart, with its
//tables loaded: rndERLoad): each end joined anew, its exit (by its room and where it's placed, "room:x,y") -> where it
//now leads: its partner's way back in (room, x, y). Returns how many
var d,p,tX,e,k,r,r2,n;
if !variable_global_exists("rndERMapR")
{
  global.rndERMapR=ds_map_create()
  global.rndERMapX=ds_map_create()
  global.rndERMapY=ds_map_create()
}
ds_map_clear(global.rndERMapR)
ds_map_clear(global.rndERMapX)
ds_map_clear(global.rndERMapY)
n=0
for(d=0;d<global.rndEDN;d+=1)
{
  p=global.rndERPart[d]
  if p>=0
  {
    tX=global.rndEDExit[d]
    e=global.rndEDBack[p]
    r=scrModFind(global.rndERName[global.rndEXRoom[tX]],"room")
    r2=scrModFind(global.rndERName[global.rndEERoom[e]],"room")
    if r>=0 and r2>=0
    {
      k=string(r)+":"+string(global.rndEXX[tX])+","+string(global.rndEXY[tX])
      if !ds_map_exists(global.rndERMapR,k)
      {
        ds_map_add(global.rndERMapR,k,r2)
        ds_map_add(global.rndERMapX,k,global.rndEEX[e])
        ds_map_add(global.rndERMapY,k,global.rndEEY[e])
        n+=1
      }
    }
  }
}
return n
