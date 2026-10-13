/*
gm82snd change (added): reads a sound file's format the way SuperSound saw it, for SS_LoadSound: the sample rate, the
channels and the bytes a second (SS_GetSoundBytesPerSecond, which playSound and scrMusicFreq work the playback rate out
from). WAV: its fmt chunk. Ogg Vorbis: its identification header, at 2 bytes a sample (SuperSound decoded Ogg to
16-bit). Sets global.ssFmtRate, global.ssFmtChannels and global.ssFmtBps and returns 1, or sets them to 0 and returns 0
if the file isn't one of those.
argument0: file name
*/
var tF,tSize,tPos,tId,tLen,tCount,i;
global.ssFmtRate=0
global.ssFmtChannels=0
global.ssFmtBps=0
if !file_exists(argument0) {return 0}
tF=file_bin_open(argument0,0)
tSize=file_bin_size(tF)
tId=""
if tSize>=12 {for(i=0;i<4;i+=1) {tId+=chr(file_bin_read_byte(tF))}}
if tId="RIFF" //---------- WAV: "RIFF", size, "WAVE", then chunks (id, size, data) ----------
{
  tPos=12
  tCount=0
  while tPos+20<=tSize and tCount<64
  {
    file_bin_seek(tF,tPos)
    tId=""
    for(i=0;i<4;i+=1) {tId+=chr(file_bin_read_byte(tF))}
    tLen=0
    for(i=0;i<4;i+=1) {tLen+=file_bin_read_byte(tF)*power(256,i)}
    if tId="fmt " //format tag (2 bytes), channels (2), sample rate (4), bytes a second (4)
    {
      file_bin_read_byte(tF); file_bin_read_byte(tF)
      global.ssFmtChannels=file_bin_read_byte(tF)+file_bin_read_byte(tF)*256
      for(i=0;i<4;i+=1) {global.ssFmtRate+=file_bin_read_byte(tF)*power(256,i)}
      for(i=0;i<4;i+=1) {global.ssFmtBps+=file_bin_read_byte(tF)*power(256,i)}
      break
    }
    tPos+=8+tLen+(tLen mod 2)
    tCount+=1
  }
}
else if tId="OggS" //---------- Ogg Vorbis: the first page's header, then its packet ----------
{
  if tSize>=27
  {
    file_bin_seek(tF,26)
    tPos=27+file_bin_read_byte(tF) //after the page's segment table
    if tPos+16<=tSize
    {
      file_bin_seek(tF,tPos)
      if file_bin_read_byte(tF)=1 //identification header: 1, "vorbis", version (4 bytes), channels (1), sample rate (4)
      {
        tId=""
        for(i=0;i<6;i+=1) {tId+=chr(file_bin_read_byte(tF))}
        if tId="vorbis"
        {
          for(i=0;i<4;i+=1) {file_bin_read_byte(tF)}
          global.ssFmtChannels=file_bin_read_byte(tF)
          for(i=0;i<4;i+=1) {global.ssFmtRate+=file_bin_read_byte(tF)*power(256,i)}
          global.ssFmtBps=global.ssFmtRate*global.ssFmtChannels*2
        }
      }
    }
  }
}
file_bin_close(tF)
if global.ssFmtRate<=0 or global.ssFmtChannels<=0 or global.ssFmtBps<=0
{
  global.ssFmtRate=0
  global.ssFmtChannels=0
  global.ssFmtBps=0
  return 0
}
return 1
