/*
input text change (added): 1 if a text has at least one input [token] (scrInputCode) in it.
argument0: the text
*/
var s,i,L,r,k;
s=argument0
L=string_length(s)
i=string_pos("[",s)
while i>0
{
  r=string_copy(s,i+1,L-i)
  k=string_pos("]",r)
  if k=0 {return 0}
  if scrInputTokenKeys(string_copy(r,1,k-1))!="" {return 1}
  s=r
  L=string_length(s)
  i=string_pos("[",s)
}
return 0
