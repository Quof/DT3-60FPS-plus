//Logic Test: a run starts (oLTRunner found cmd.txt). Its lines are read and the file taken away, so it runs once;
//out.txt is started afresh and done.txt taken away (ltEnd makes it again). The run's commands start this frame
var tF,s,i;
if global.ltCmd>=0 {ds_list_destroy(global.ltCmd)}
global.ltCmd=ds_list_create()
tF=file_text_open_read(global.ltDir+"cmd.txt")
while !file_text_eof(tF)
{
  s=file_text_read_string(tF)
  file_text_readln(tF)
  ds_list_add(global.ltCmd,s)
}
file_text_close(tF)
file_delete(global.ltDir+"cmd.txt")
if file_exists(global.ltDir+"done.txt") {file_delete(global.ltDir+"done.txt")}
tF=file_text_open_write(global.ltDir+"out.txt")
file_text_close(tF)
global.ltOutBuf=""
global.ltPC=0
global.ltFrame=0
global.ltWaitF=0
global.ltWaitKind=0
global.ltNewGame=0
global.ltTrace=0
global.ltSpeed=1
global.ltGod=0
global.ltNoHit=0
global.ltPadWas=global.optGamePad
for(i=0;i<=16;i+=1) {global.ltHeld[i]=0}
global.ltGotWas=""
if variable_global_exists("rndGot") {global.ltGotWas=global.rndGot}
global.ltDeadWas=instance_exists(oGameOver)
global.ltRun=1
ltOut("start "+date_datetime_string(date_current_datetime())+" fps "+string(global.gameFrameRate)+" "+ltPos())
ltRunCmds()
