//Randomizer: a save's marks (a character each, argument0) kept by an earlier build's list, put in this build's order:
//argument1, "1" each of this build's that the old list hadn't (unmarked, "0"), "0" each it had, in the old list's order
var tOld,tSkip,tOut,i,j,n;
tOld=argument0
tSkip=argument1
tOut=""
j=1
n=string_length(tSkip)
for(i=1;i<=n;i+=1)
{
  if string_char_at(tSkip,i)="1" {tOut+="0"}
  else
  {
    if j<=string_length(tOld) {tOut+=string_char_at(tOld,j)} else {tOut+="0"}
    j+=1
  }
}
return tOut
