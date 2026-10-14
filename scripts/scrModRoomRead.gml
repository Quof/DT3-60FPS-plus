/*
mods change (added): reads a mod room's contents the first time it's entered (scrModRoomStart), so starting the game
doesn't read every room of every mod: its instances (instances.txt, and <instance name>.gml for an instance's creation
code, kept as text: scrModTextAdd), its tiles (layers.txt, with a <depth>.txt per tile layer) and its creation code
(code.gml). What's read goes in the room's global.modRoomInfo list (scrModLoadRooms has the layout) and is kept for
later visits.
argument0: the room's global.modRoomInfo list
*/
var tInfo,m,tName,tRd,tF,tLine,tP,tObj,tCode,tCodeFile,tN,tTiles,tLayers,tDepth,tTF,tBlend,tXs,tYs,tLogLen,tLog,tBg,tNoBg;
tInfo=argument0
m=ds_list_find_value(tInfo,0)
tName=ds_list_find_value(tInfo,3)
tRd=global.modDir+global.modFolder[m]+"\rooms\"+tName+"\"
tLogLen=string_length(global.modLog)
//----- instances -----
tN=0
if file_exists(tRd+"instances.txt")
{
  tF=file_text_open_read(tRd+"instances.txt")
  while !file_text_eof(tF)
  {
    tLine=file_text_read_string(tF)
    file_text_readln(tF)
    if tLine="" {continue}
    tP=scrModSplit(tLine,",")
    if ds_list_size(tP)<4 {scrModLog("  ERROR: "+tName+": bad instance line: "+tLine); ds_list_destroy(tP); continue}
    tObj=scrModFind(ds_list_find_value(tP,0),"obj")
    if tObj<0 {scrModLog("  ERROR: "+tName+": no object "+ds_list_find_value(tP,0)); ds_list_destroy(tP); continue}
    ds_list_add(tInfo,tObj)
    ds_list_add(tInfo,real(ds_list_find_value(tP,1)))
    ds_list_add(tInfo,real(ds_list_find_value(tP,2)))
    ds_list_add(tInfo,scrModHex(ds_list_find_value(tP,3)))
    if ds_list_size(tP)>=9
    {
      ds_list_add(tInfo,real(ds_list_find_value(tP,5)))
      ds_list_add(tInfo,real(ds_list_find_value(tP,6)))
      ds_list_add(tInfo,real(ds_list_find_value(tP,7)))
      ds_list_add(tInfo,real(ds_list_find_value(tP,8)))
    }
    else {ds_list_add(tInfo,1); ds_list_add(tInfo,1); ds_list_add(tInfo,4294967295); ds_list_add(tInfo,0)}
    tCode=-1
    tCodeFile=tRd+ds_list_find_value(tP,3)+".gml"
    //if file_exists(tCodeFile) {tCode=scrModCompile(scrModFixCode(scrModReadFile(tCodeFile)),tName+" instance "+ds_list_find_value(tP,3))}
    if file_exists(tCodeFile) {tCode=scrModTextAdd(scrModReadFile(tCodeFile))} //mods change: kept as text (scrModTextAdd says why)
    ds_list_add(tInfo,tCode)
    tN+=1
    ds_list_destroy(tP)
  }
  file_text_close(tF)
}
ds_list_replace(tInfo,4,tN)
//----- tiles: background, left, top, width, height, x, y, depth, xscale, yscale, alpha (scrModRoomStart adds them) -----
tTiles=ds_list_create()
tNoBg=0
if file_exists(tRd+"layers.txt")
{
  tLayers=file_text_open_read(tRd+"layers.txt")
  while !file_text_eof(tLayers)
  {
    tDepth=file_text_read_string(tLayers)
    file_text_readln(tLayers)
    if tDepth="" {continue}
    if !file_exists(tRd+tDepth+".txt") {continue}
    tTF=file_text_open_read(tRd+tDepth+".txt")
    while !file_text_eof(tTF)
    {
      tLine=file_text_read_string(tTF)
      file_text_readln(tTF)
      if tLine="" {continue}
      tP=scrModSplit(tLine,",")
      if ds_list_size(tP)<7 {ds_list_destroy(tP); continue}
      tBg=scrModFind(ds_list_find_value(tP,0),"bg")
      if tBg<0 {tNoBg+=1; ds_list_destroy(tP); continue}
      tBlend=4294967295; tXs=1; tYs=1
      if ds_list_size(tP)>=10 {tXs=real(ds_list_find_value(tP,8)); tYs=real(ds_list_find_value(tP,9))}
      if ds_list_size(tP)>=11 {tBlend=real(ds_list_find_value(tP,10))}
      ds_list_add(tTiles,tBg)
      ds_list_add(tTiles,real(ds_list_find_value(tP,3)))
      ds_list_add(tTiles,real(ds_list_find_value(tP,4)))
      ds_list_add(tTiles,real(ds_list_find_value(tP,5)))
      ds_list_add(tTiles,real(ds_list_find_value(tP,6)))
      ds_list_add(tTiles,real(ds_list_find_value(tP,1)))
      ds_list_add(tTiles,real(ds_list_find_value(tP,2)))
      ds_list_add(tTiles,real(tDepth))
      ds_list_add(tTiles,tXs)
      ds_list_add(tTiles,tYs)
      ds_list_add(tTiles,floor(tBlend/16777216)/255)
      ds_list_destroy(tP)
    }
    file_text_close(tTF)
  }
  file_text_close(tLayers)
}
if tNoBg>0 {scrModLog("  ERROR: "+tName+": "+string(tNoBg)+" tile(s) with a background that isn't there, left out")}
ds_list_replace(tInfo,13,tTiles)
//----- creation code -----
tCode=-1
//if file_exists(tRd+"code.gml") {tCode=scrModCompile(scrModFixCode(scrModReadFile(tRd+"code.gml")),tName+" room code")}
if file_exists(tRd+"code.gml") {tCode=scrModTextAdd(scrModReadFile(tRd+"code.gml"))} //mods change: kept as text (scrModTextAdd says why)
ds_list_replace(tInfo,2,tCode)
//(what went wrong, if anything, goes in Mods\mod_log.txt too)
if string_length(global.modLog)>tLogLen
{
  tLog=file_text_open_write(global.modDir+"mod_log.txt")
  file_text_write_string(tLog,global.modLog)
  file_text_close(tLog)
}
