/*
mods change (added): a text file's contents (lines joined with line breaks), or "" if it isn't there.
argument0: file name
*/
var tF,tS,tFirst;
if !file_exists(argument0) {return ""}
tF=file_text_open_read(argument0)
tS=""
tFirst=1
while !file_text_eof(tF)
{
  if tFirst=0 {tS+=chr(13)+chr(10)}
  tS+=file_text_read_string(tF)
  file_text_readln(tF)
  tFirst=0
}
file_text_close(tF)
return tS
