//Randomizer: its variables, off (the init hook: the title screen, a new game, a save being loaded). Its data (rndData:
//the locations, items, shops and bosses) is set up once
var i,p,s;
if !variable_global_exists("rndLocN")
{
  rndData()
  //each location's requirements (rndData's strings: a digit for each of the first 12 progression items, then two for
  //keys) as numbers, and each item's progression item (-1: none)
  for(i=0;i<global.rndLocN;i+=1)
  {
    s=global.rndLocReq[i]
    for(p=0;p<12;p+=1) {global.rndReqV[i,p]=real(string_char_at(s,p+1))}
    global.rndReqV[i,12]=real(string_copy(s,13,2))
  }
  for(i=0;i<global.rndItemN;i+=1) {global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
  global.rndNextSeed=-1
}
global.rndVersion=1
global.rndActive=0
global.rndSeed=0
global.rndWon=0
global.rndWorldProg=5641 //past every story event (5640 is the Hexor fight's)
global.rndFight=-1
global.rndFightRetX=0
global.rndFightRetY=0
for(i=0;i<12;i+=1) {global.rndOwn[i]=0}
global.rndGot=string_repeat("0",global.rndLocN)
global.rndPlace=""
global.rndBossDone=string_repeat("0",global.rndBossN)
global.rndEShopStr=""
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
