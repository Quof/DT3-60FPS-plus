/*
mods change (added): reads a mod's room patches (patches\<room>\patch.txt, with its code files next to it) and its hooks
(hooks\<hook>.gml). A patch line names objects and backgrounds as the room editor does and gives code as a file name
(- for none); see scrModRoomPatch for what each line does. Lines starting with # are comments. These lines change the
room itself, here, as the mods load:
  caption|text                                    its caption (all the rest of the line)
  roomsize|width|height
  roombg|n|visible|foreground|background|x|y|htiled|vtiled|hspeed|vspeed    background n (room_set_background)
  roomcolor|colour|draw                           its background colour (as room.txt has it: red+green*256+blue*65536)
                                                  and whether it's drawn
  roomcodeset|code                                its creation code: this replaces it, and runs once the rest of the
                                                  patch is done (scrModRoomPatch), so the instances it adds are there
argument0: the mod (its place in the mod list)
*/
var m,tDir,tLeg,tMode,tRooms,i,tRoom,tRm,tPd,tF,tLine,tP,tKind,tOut,tObj,tCode,tL,tHooks,tH,tIdx;
m=argument0
tDir=global.modDir+global.modFolder[m]+"\"
tLeg=global.modLegacy[m]
if tLeg=1 {tMode=1} else {tMode=0}

tRooms=scrModScan(tDir+"patches\","")
for(i=0;i<ds_list_size(tRooms);i+=1)
{
  tRoom=ds_list_find_value(tRooms,i)
  tRm=scrModFind(tRoom,"room")
  if tRm<0 {scrModLog("  ERROR: patch for a room that doesn't exist: "+tRoom); continue}
  tPd=tDir+"patches\"+tRoom+"\"
  if !file_exists(tPd+"patch.txt") {continue}
  if ds_map_exists(global.modPatch,tRm) {tL=ds_map_find_value(global.modPatch,tRm)}
  else {tL=ds_list_create(); ds_map_add(global.modPatch,tRm,tL)}
  tF=file_text_open_read(tPd+"patch.txt")
  while !file_text_eof(tF)
  {
    tLine=file_text_read_string(tF)
    file_text_readln(tF)
    if tLine="" or string_char_at(tLine,1)="#" {continue}
    tP=scrModSplit(tLine,"|")
    tKind=ds_list_find_value(tP,0)
    tOut=""
    if tKind="roomcode"
    {
      tCode=scrModPatchCode(tPd,ds_list_find_value(tP,1),tRoom)
      tOut="roomcode|"+string(tCode)+"|"+string(tMode)
    }
    //----- mods change (added): lines that change the room itself, now -----
    else if tKind="caption"
    {
      room_set_caption(tRm,string_copy(tLine,9,string_length(tLine)))
    }
    else if tKind="roomsize" and ds_list_size(tP)>=3
    {
      room_set_width(tRm,real(ds_list_find_value(tP,1)))
      room_set_height(tRm,real(ds_list_find_value(tP,2)))
    }
    else if tKind="roombg" and ds_list_size(tP)>=11
    {
      room_set_background(tRm,real(ds_list_find_value(tP,1)),real(ds_list_find_value(tP,2)),real(ds_list_find_value(tP,3)),
        scrModFind(ds_list_find_value(tP,4),"bg"),real(ds_list_find_value(tP,5)),real(ds_list_find_value(tP,6)),
        real(ds_list_find_value(tP,7)),real(ds_list_find_value(tP,8)),real(ds_list_find_value(tP,9)),real(ds_list_find_value(tP,10)),1)
    }
    else if tKind="roomcolor" and ds_list_size(tP)>=3
    {
      room_set_background_color(tRm,real(ds_list_find_value(tP,1)),real(ds_list_find_value(tP,2)))
    }
    else if tKind="roomcodeset"
    {
      tCode=scrModPatchCode(tPd,ds_list_find_value(tP,1),tRoom)
      if tRm=room {scrModLog("  ERROR: "+tRoom+" patch: can't replace the creation code of the room the game is in")}
      else
      {
        room_set_code(tRm,"")
        tOut="roomcodeset|"+string(tCode)+"|"+string(tMode)
      }
    }
    else if tKind="tileadd" and ds_list_size(tP)>=9
    {
      tObj=scrModFind(ds_list_find_value(tP,1),"bg")
      if tObj<0 {scrModLog("  ERROR: "+tRoom+" patch: no background "+ds_list_find_value(tP,1))}
      else {tOut="tileadd|"+string(tObj)+string_copy(tLine,string_length(ds_list_find_value(tP,0)+"|"+ds_list_find_value(tP,1))+1,string_length(tLine))}
    }
    else if tKind="tileremove"
    {
      tOut=tLine
    }
    else if ds_list_size(tP)>=4
    {
      tObj=scrModFind(ds_list_find_value(tP,1),"obj")
      if tObj<0 {scrModLog("  ERROR: "+tRoom+" patch: no object "+ds_list_find_value(tP,1))}
      else
      {
        tOut=tKind+"|"+string(tObj)+"|"+ds_list_find_value(tP,2)+"|"+ds_list_find_value(tP,3)
        if tKind="add" and ds_list_size(tP)>=6
        {
          tCode=scrModPatchCode(tPd,ds_list_find_value(tP,5),tRoom)
          tOut+="|"+ds_list_find_value(tP,4)+"|"+string(tCode)+"|"+string(tMode)
        }
        //else if tKind="code" and ds_list_size(tP)>=5
        else if (tKind="code" or tKind="precode") and ds_list_size(tP)>=5 //mods change: precode too (scrModRoomPatch)
        {
          tCode=scrModPatchCode(tPd,ds_list_find_value(tP,4),tRoom)
          tOut+="|"+string(tCode)+"|"+string(tMode)
        }
        else if (tKind="move" and ds_list_size(tP)>=6) {tOut+="|"+ds_list_find_value(tP,4)+"|"+ds_list_find_value(tP,5)}
        else if (tKind="gid" and ds_list_size(tP)>=5) {tOut+="|"+ds_list_find_value(tP,4)}
        else if tKind!="remove" {scrModLog("  ERROR: "+tRoom+" patch: bad line: "+tLine); tOut=""}
      }
    }
    else {scrModLog("  ERROR: "+tRoom+" patch: bad line: "+tLine)}
    if tOut!="" {ds_list_add(tL,tOut)}
    ds_list_destroy(tP)
  }
  file_text_close(tF)
}
ds_list_destroy(tRooms)

//----- hooks -----
//(the comment line put first makes code_compile give every hook both arguments: it counts the ones a piece of code uses
//by looking for argument0, argument1... in order, and a hook that only uses argument1 would otherwise get neither)
tHooks=scrModScan(tDir+"hooks\",".gml")
for(i=0;i<ds_list_size(tHooks);i+=1)
{
  tH=ds_list_find_value(tHooks,i)
  tIdx=scrModCompile("//argument0 argument1"+chr(13)+chr(10)+scrModFixCode(scrModReadFile(tDir+"hooks\"+tH+".gml")),"hook "+tH)
  if tIdx<0 {continue}
  global.modCodeMode[tIdx]=tMode
  if ds_map_exists(global.modHook,tH) {tL=ds_map_find_value(global.modHook,tH)}
  else {tL=ds_list_create(); ds_map_add(global.modHook,tH,tL)}
  ds_list_add(tL,tIdx)
}
ds_list_destroy(tHooks)
