//Randomizer: the player came into Access Gate argument0's rooms from outside it without its Program Chip (the roomStart
//hook, Chip Randomizer on): they're turned back at once, out the way they came in, and told what the gate needs
//(rndLockMsg, at the next room's start). With Entrance Rando (its tables loaded): the door they came through, the end
//whose way in this is, and its partner's way back in (where going back through it puts them); without, the gate's own
//way out (rndGateOut*: in front of its Access Gate, the only way in); else Central City - North, where the run starts
var g,d,e,p,b,tRoom,tX,tY,tName;
g=argument0
tRoom=rCCity_NorthA
tX=608
tY=320
if global.rndERMode>0
{
  if variable_global_exists("rndELoaded")
  {
    if global.rndELoaded=1
    {
      tName=room_get_name(room)
      for(d=0;d<global.rndEDN;d+=1)
      {
        e=global.rndEDBack[d]
        if global.rndEEX[e]=global.newMapX and global.rndEEY[e]=global.newMapY
        {
          if global.rndERName[global.rndEERoom[e]]=tName
          {
            p=global.rndERPart[d]
            if p<0 {p=global.rndEDPair[d]}
            b=global.rndEDBack[p]
            tRoom=scrModFind(global.rndERName[global.rndEERoom[b]],"room")
            tX=global.rndEEX[b]
            tY=global.rndEEY[b]
            break
          }
        }
      }
    }
  }
}
else
{
  tRoom=global.rndGateOutRoom[g]
  tX=global.rndGateOutX[g]
  tY=global.rndGateOutY[g]
}
if tRoom<0 {tRoom=rCCity_NorthA; tX=608; tY=320}
global.rndLockMsg=g
global.newMapX=tX
global.newMapY=tY
transition_kind=0
rndHLEnter(tRoom) //(a Highlands room is made as before the CHAOS Warship's attack)
room_goto(tRoom)
