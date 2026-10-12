/*
input text change (added): what a [token] shows with the keyboard in use, brackets included ("[J]"), or "" if it isn't
an input token. "[Up+Action C]" gives "[Up]+[L]"; "[Left Keys]" gives "[Left] or [A]".
argument0: the text between the brackets
*/
var n,c,p;
n=argument0
p=string_pos("+",n)
if p>0
{
  var tA,tB;
  tA=scrInputTokenKeys(string_copy(n,1,p-1))
  tB=scrInputTokenKeys(string_copy(n,p+1,string_length(n)-p))
  if tA="" or tB="" {return ""}
  return tA+"+"+tB
}
c=scrInputCode(n)
if c=-1 {return ""}
if c>=201 {return "["+scrInputKeyName(c-200)+"] or ["+scrInputKeyName(c-100)+"]"}
return "["+scrInputKeyName(c)+"]"
