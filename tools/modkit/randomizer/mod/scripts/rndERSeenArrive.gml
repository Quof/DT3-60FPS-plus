//Randomizer: the Check Tracker's Entrance Tracker (Entrance Rando; the roomStart hook): the way in the player has come
//into this room by (the one at where they are put, global.newMapX/Y: rndEEOf) is visited from now on (rndERVisit), and
//the door they came through is found (rndERSeen, both its ends): an end whose way back in that is, its partner's exit
//(or, not joined, its own pair's) being in the room they came from (rndERPrevRoom). An exit there that isn't a door's
//end and leads to that way in (rndEXOf) is gone through (rndERExit). A warp's way in (the Teleport's, a trap's) is
//visited, no door found. The trackers' state has them (rndTrackWrite), the save keeps them
var r,e,d,s,j,k,n,p,q,t,m;
if !variable_global_exists("rndEEOf") {exit}
n=global.rndEDN
if string_length(global.rndERSeen)<n {global.rndERSeen+=string_repeat("0",n-string_length(global.rndERSeen))}
if string_length(global.rndERVisit)<global.rndEEN {global.rndERVisit+=string_repeat("0",global.rndEEN-string_length(global.rndERVisit))}
if string_length(global.rndERExit)<global.rndEXN {global.rndERExit+=string_repeat("0",global.rndEXN-string_length(global.rndERExit))}
r=-1
if ds_map_exists(global.rndERRoomOf,room_get_name(room)) {r=ds_map_find_value(global.rndERRoomOf,room_get_name(room))}
if r>=0
{
  k=string(r)+":"+string(round(global.newMapX))+","+string(round(global.newMapY))
  if ds_map_exists(global.rndEEOf,k)
  {
    e=ds_map_find_value(global.rndEEOf,k)
    if string_char_at(global.rndERVisit,e+1)!="1" {global.rndERVisit=rndSetChar(global.rndERVisit,e+1,"1"); global.rndTrackDirty=1}
    for(j=0;j<global.rndEEBackN[e];j+=1)
    {
      d=global.rndEEBack[e,j]
      s=global.rndERPart[d]
      if s<0 {s=global.rndEDPair[d]}
      if s>=0
      {
        if global.rndEXRoom[global.rndEDExit[s]]=global.rndERPrevRoom and (string_char_at(global.rndERSeen,d+1)!="1" or string_char_at(global.rndERSeen,s+1)!="1")
        {
          global.rndERSeen=rndSetChar(global.rndERSeen,d+1,"1")
          global.rndERSeen=rndSetChar(global.rndERSeen,s+1,"1")
          global.rndTrackDirty=1
        }
      }
    }
    //(the exits of the room they came from that aren't doors' ends, leading here: one of them was gone through)
    p=global.rndERPrevRoom
    if p>=0 and p!=r
    {
      for(j=0;j<global.rndEXOfN[p];j+=1)
      {
        q=global.rndEXOf[p,j]
        t=(global.rndEXDest[q]=e)
        for(m=0;m<global.rndEXSdN[q];m+=1) {if global.rndEXSd[q,m]=e {t=1}}
        if t=1 and string_char_at(global.rndERExit,q+1)!="1" {global.rndERExit=rndSetChar(global.rndERExit,q+1,"1"); global.rndTrackDirty=1}
      }
    }
  }
}
global.rndERPrevRoom=r
