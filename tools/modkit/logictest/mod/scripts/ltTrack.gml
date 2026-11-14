//Logic Test: a frame of a track (track NAME FRAMES): every instance of the objects Mods\LogicTest\track.txt names (an
//object a line) where it is, written when it has moved since the last frame (or first seen): F frame id object x y.
//The last frame closes the file
var k,tF,tab;
if global.ltTrackLeft<=0 {exit}
tF=global.ltTrackF
tab=chr(9)
for(k=0;k<global.ltTrackN;k+=1)
{
  with (global.ltTrackObj[k])
  {
    if !variable_local_exists("ltTX") {ltTX=-99999; ltTY=-99999}
    if ltTX!=x or ltTY!=y
    {
      file_text_write_string(tF,"F"+tab+string(global.ltFrame)+tab+string(id)+tab+object_get_name(object_index)+tab+string(x)+tab+string(y))
      file_text_writeln(tF)
      ltTX=x; ltTY=y
    }
  }
}
global.ltTrackLeft-=1
if global.ltTrackLeft<=0 {file_text_close(tF)}
