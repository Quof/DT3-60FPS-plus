/*
mods change (added): reads a file of key=value lines (a room's room.txt, an object's object.ini) into a new ds_map (the
caller destroys it). Lines without '=' (such as an ini file's [section]) are skipped, and spaces around the key and the
value are left out.
argument0: file name
*/
var tMap,tF,tLine,tP,tK,tV;
tMap=ds_map_create()
if !file_exists(argument0) {return tMap}
tF=file_text_open_read(argument0)
while !file_text_eof(tF)
{
  tLine=file_text_read_string(tF)
  file_text_readln(tF)
  tP=string_pos("=",tLine)
  if tP>1
  {
    tK=string_replace_all(string_copy(tLine,1,tP-1)," ","")
    tV=string_copy(tLine,tP+1,string_length(tLine)-tP)
    while string_char_at(tV,1)=" " {tV=string_delete(tV,1,1)}
    while string_length(tV)>0 and string_char_at(tV,string_length(tV))=" " {tV=string_delete(tV,string_length(tV),1)}
    if tK="" {continue}
    if ds_map_exists(tMap,tK) {ds_map_replace(tMap,tK,tV)}
    else {ds_map_add(tMap,tK,tV)}
  }
}
file_text_close(tF)
return tMap
