/*
mods change (added): 1 if the text is a valid name in code (a letter or _, then letters, digits or _), else 0.
argument0: text
*/
var i,c,n;
n=string_length(argument0)
if n=0 {return 0}
for(i=1;i<=n;i+=1)
{
  c=ord(string_char_at(argument0,i))
  if !((c>=65 and c<=90) or (c>=97 and c<=122) or c=95 or (i>1 and c>=48 and c<=57)) {return 0}
}
return 1
