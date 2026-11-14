//Logic Test: the globals named in Mods\LogicTest\snap.txt (a name a line; name[i] an array's element) as they are now,
//for restore to put back (ltRestore: roomdump.py has each room come into from the same state). A name the game hasn't
//got is left out
var tF,s,p,nm,ix,n;
global.ltSnapN=0
if !file_exists(global.ltDir+"snap.txt") {ltErr("snap: no snap.txt"); exit}
tF=file_text_open_read(global.ltDir+"snap.txt")
while !file_text_eof(tF)
{
  s=file_text_read_string(tF)
  file_text_readln(tF)
  s=string_replace_all(s,chr(13),"")
  if s="" {continue}
  p=string_pos("[",s)
  if p>0 {nm=string_copy(s,1,p-1); ix=real(string_digits(string_copy(s,p+1,string_length(s)-p)))}
  else {nm=s; ix=-1}
  if !variable_global_exists(nm) {continue}
  n=global.ltSnapN
  global.ltSnapName[n]=nm
  global.ltSnapIx[n]=ix
  if ix<0 {global.ltSnapVal[n]=variable_global_get(nm)}
  else {global.ltSnapVal[n]=variable_global_array_get(nm,ix)}
  global.ltSnapN+=1
}
file_text_close(tF)
