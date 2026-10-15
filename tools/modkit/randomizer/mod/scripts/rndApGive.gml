//Randomizer, Archipelago: gives a received item (argument0: its line in items.txt, "<item id>|<from this world 0/1>|
//<sender's name>"; argument1: 1 to show its message, which says who sent it unless it's from this world). It counts as
//received (global.rndApRecv) whatever it is. (An instrument, kind 26, comes only with Instrument Randomization; a
//Program Chip, kind 27, only with Chip Randomizer)
//var id,k,p;
var tId,k,p; //bug fix (not a 60fps change): tId, not id: GameMaker's own instance id can't be a var, so the script didn't compile and the game left it out
global.rndApRecv+=1
if rndApSplit(argument0)<3 {exit}
//id=real(global.rndApPart[0])-global.rndApBase
//k=id div 10000
//p=id mod 10000
tId=real(global.rndApPart[0])-global.rndApBase //bug fix: tId (see the var line)
k=tId div 10000 //bug fix: tId
p=tId mod 10000 //bug fix: tId
if k<1 or k>27 {exit}
if argument1=0 or global.rndApPart[1]="1" {rndGiveKP(k,p); exit}
global.rndMsgQuiet=1
rndGiveKP(k,p)
global.rndMsgQuiet=0
rndMsg("Received "+rndItemNameKP(k,p)+"#from "+global.rndApPart[2]+"!",2)
