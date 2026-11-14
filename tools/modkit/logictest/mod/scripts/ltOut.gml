//Logic Test: a line of the run's results (argument0), written to out.txt when the run is over or there's a lot of it
global.ltOutBuf+=argument0+chr(13)+chr(10)
if string_length(global.ltOutBuf)>16000 {ltFlush()}
