//Logic Test: the runner, at the end of every frame (after every other object's events). During a run: the frame's
//results, and the commands go on (ltStep). Otherwise it looks for a run's command file twice a second or so
if global.ltRun=1 {ltStep(); exit}
global.ltPollT-=1
if global.ltPollT<=0
{
  global.ltPollT=15
  if file_exists(global.ltDir+"cmd.txt") {ltBegin()}
}
