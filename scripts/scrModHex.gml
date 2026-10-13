/*
mods change (added): the number a hexadecimal text stands for (a room instance's name in instances.txt, which is its
original instance id), or 0.
argument0: text, e.g. "00072216"
*/
var i,c,v,n;
v=0
n=string_length(argument0)
for(i=1;i<=n;i+=1)
{
  c=ord(string_upper(string_char_at(argument0,i)))
  if c>=48 and c<=57 {v=v*16+c-48}
  else if c>=65 and c<=70 {v=v*16+c-55}
  else {return 0}
}
return v
