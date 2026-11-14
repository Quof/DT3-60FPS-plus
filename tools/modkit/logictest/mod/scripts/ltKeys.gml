//Logic Test: the buttons a command holds (argument0: names joined by +, or none) into global.ltHeld, scrController's
//numbers (ltKeyCode); returns 0 if one isn't known
var tL,i,j,s,tOk;
for(i=0;i<=16;i+=1) {global.ltHeld[i]=0}
s=string_lower(argument0)
if s="none" or s="-" {return 1}
tL=scrModSplit(s,"+")
tOk=1
for(i=0;i<ds_list_size(tL);i+=1)
{
  j=ltKeyCode(ds_list_find_value(tL,i))
  if j<=0 {tOk=0}
  else {global.ltHeld[j]=1}
}
ds_list_destroy(tL)
return tOk
