//Randomizer: the reach goes on from what's queued (rndERExpand); then the events that now happen (an event's room or
//area got into, and what else it takes; a way only for or only without Instrument Randomization as global.rndIRMode
//is) and the spots got to each let the rows waiting for them try again; till nothing new happens
var v,k,w,hit,j,tL,tSkip;
tSkip=2
if global.rndIRMode=1 {tSkip=1}
while true
{
  while !ds_queue_empty(global.rndRQueue) {rndERExpand(ds_queue_dequeue(global.rndRQueue))}
  for(v=0;v<global.rndEVN;v+=1)
  {
    k=global.rndEEvBase+v
    if global.rndGHave[k]<1
    {
      for(w=0;w<global.rndEVWayN[v];w+=1)
      {
        if global.rndEVKind[v,w]=1 {hit=global.rndRRoomIn[global.rndEVWhat[v,w]]}
        else if global.rndEVKind[v,w]=2 {hit=global.rndRAreaIn[global.rndEVWhat[v,w]]}
        else {hit=(global.rndRPlaceN>=global.rndEVWhat[v,w])} //(a share of the checks: that many places got to)
        if global.rndEVMode[v,w]=tSkip {hit=0}
        if hit=1
        {
          ds_list_clear(global.rndRLkX)
          if rndERLack(global.rndEVAltF[v,w],global.rndEVAltC[v,w],global.rndRLkX)=1
          {
            global.rndGHave[k]=1
            ds_list_add(global.rndREvNew,k)
            break
          }
        }
      }
    }
  }
  if ds_list_size(global.rndREvNew)=0 {break}
  tL=global.rndREvNew
  global.rndREvNew=ds_list_create()
  for(j=0;j<ds_list_size(tL);j+=1) {rndERRetry(ds_list_find_value(tL,j))}
  ds_list_destroy(tL)
}
