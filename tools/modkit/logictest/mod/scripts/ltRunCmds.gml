//Logic Test: the run's commands from the next one on, till one takes time (global.ltWaitF) or there are no more (the
//run is over: ltEnd)
var s;
while global.ltRun=1 and global.ltWaitF<=0
{
  if global.ltPC>=ds_list_size(global.ltCmd) {ltEnd(); exit}
  s=ds_list_find_value(global.ltCmd,global.ltPC)
  global.ltPC+=1
  ltExec(s)
}
