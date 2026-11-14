//Logic Test: what the player has (argument0: item names, space separated), in place of what they had: the Randomizer's
//abilities (global.rndOwn, turned on as rndAbilApply does when a save is loaded), Air Upgrades, keys, and the Program
//Chips with Chip Randomizer (without it, the player has all six as in any game). A name with =N: that many of it (a set:
//its items found, so link=2 is the Master Sword and the Bow; hjb=2 the Super High Jump Boots); without, one
var tL,i,s,p,tName,tVal,tAll,tOut;
if !variable_global_exists("rndOwn") {ltErr("items: the Randomizer mod isn't on"); exit}
for(i=0;i<17;i+=1) {global.rndOwn[i]=0}
global.rndKeyOwn=string_repeat("0",string_length(global.rndKeyOwn))
global.pKeys=0
if variable_global_exists("rndChipMode") {if global.rndChipMode=1 {global.rndChipOwn=string_repeat("0",global.rndChipN)}}
global.pBreathMax=600
tAll=0
tOut=""
tL=scrModSplit(string_lower(argument0)," ")
for(i=0;i<ds_list_size(tL);i+=1)
{
  s=ds_list_find_value(tL,i)
  if s!=""
  {
    p=string_pos("=",s)
    if p>0 {tName=string_copy(s,1,p-1); tVal=real(string_digits(string_copy(s,p+1,string_length(s)-p)))}
    else {tName=s; tVal=1}
    switch (tName)
    {
      case "none": break
      case "jump": global.rndOwn[0]=1; break
      case "dash": global.rndOwn[1]=1; break
      case "airdash": global.rndOwn[2]=1; break
      case "double": global.rndOwn[3]=1; break
      case "hjb": global.rndOwn[4]=min(2,tVal); break
      case "mario": global.rndOwn[5]=1; break
      case "link": global.rndOwn[6]=min(3,tVal); break
      case "belmont": global.rndOwn[7]=min(3,tVal); break
      case "mega": global.rndOwn[8]=min(4,tVal); break
      case "samus": global.rndOwn[9]=min(7,tVal); break
      case "jgame": global.rndOwn[10]=min(2,tVal); break
      case "cgame": global.rndOwn[11]=min(2,tVal); break
      case "varia": global.rndOwn[12]=1; break
      case "nmsword": global.rndOwn[13]=1; break
      case "nmcharge": global.rndOwn[14]=1; break
      case "nmdagger": global.rndOwn[15]=1; break
      case "nmbomb": global.rndOwn[16]=1; break
      case "air": global.pBreathMax=600+30*tVal; break
      case "chip":
        if tVal>=1 and tVal<=global.rndChipN {global.rndChipOwn=string_delete(global.rndChipOwn,tVal,1); global.rndChipOwn=string_insert("1",global.rndChipOwn,tVal)}
        else {tOut+=" "+s}
        break
      case "key":
        if tVal>=1 and tVal<=string_length(global.rndKeyOwn) {global.rndKeyOwn=string_delete(global.rndKeyOwn,tVal,1); global.rndKeyOwn=string_insert("1",global.rndKeyOwn,tVal); global.pKeys+=1}
        else {tOut+=" "+s}
        break
      case "all": tAll=1; break
      default: tOut+=" "+s; break
    }
  }
}
ds_list_destroy(tL)
if tOut!="" {ltErr("items: names that aren't known:"+tOut); exit}
if tAll=1
{
  global.rndOwn[0]=1; global.rndOwn[1]=1; global.rndOwn[2]=1; global.rndOwn[3]=1; global.rndOwn[4]=2; global.rndOwn[5]=1
  global.rndOwn[6]=3; global.rndOwn[7]=3; global.rndOwn[8]=4; global.rndOwn[9]=7; global.rndOwn[10]=2; global.rndOwn[11]=2
  global.rndOwn[12]=1
}
global.programChips=0
for(i=1;i<=string_length(global.rndChipOwn);i+=1) {if string_char_at(global.rndChipOwn,i)="1" {global.programChips+=1}}
global.pCurrBreath=global.pBreathMax
ltRnd("rndAbilApply")
s=""
for(i=0;i<17;i+=1) {s+=string(global.rndOwn[i])}
ltOut("items "+s+" air "+string(global.pBreathMax)+" keys "+global.rndKeyOwn+" chips "+global.rndChipOwn)
