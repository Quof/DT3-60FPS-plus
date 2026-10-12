/*
input text change (added): a text with its input [tokens] (scrInputCode) turned into the keys they're set to, for the
keyboard ("press [Jump]" -> "press [J]"). Anything else in brackets stays as it is.
argument0: the text
*/
var s,o,i,L,ch,r,k,t;
s=argument0
if string_pos("[",s)=0 {return s}
o=""
i=1
L=string_length(s)
while i<=L
{
  ch=string_char_at(s,i)
  if ch="["
  {
    r=string_copy(s,i+1,L-i)
    k=string_pos("]",r)
    if k>0
    {
      t=scrInputTokenKeys(string_copy(r,1,k-1))
      if t!=""
      {
        o+=t
        i+=k+1
        continue
      }
    }
  }
  o+=ch
  i+=1
}
return o
