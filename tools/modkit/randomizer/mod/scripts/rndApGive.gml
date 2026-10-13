//Randomizer, Archipelago: gives a received item (argument0: its line in items.txt, "<item id>|<from this world 0/1>|
//<sender's name>"; argument1: 1 to show its message, which says who sent it unless it's from this world). It counts as
//received (global.rndApRecv) whatever it is
var id,k,p;
global.rndApRecv+=1
if rndApSplit(argument0)<3 {exit}
id=real(global.rndApPart[0])-global.rndApBase
k=id div 10000
p=id mod 10000
if k<1 or k>24 {exit}
if argument1=0 or global.rndApPart[1]="1" {rndGiveKP(k,p); exit}
global.rndMsgQuiet=1
rndGiveKP(k,p)
global.rndMsgQuiet=0
rndMsg("Received "+rndItemNameKP(k,p)+"#from "+global.rndApPart[2]+"!",2)
