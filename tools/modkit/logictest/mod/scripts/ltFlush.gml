//Logic Test: the results so far added to out.txt
var tF;
if global.ltOutBuf="" {exit}
tF=file_text_open_append(global.ltDir+"out.txt")
file_text_write_string(tF,global.ltOutBuf)
file_text_close(tF)
global.ltOutBuf=""
