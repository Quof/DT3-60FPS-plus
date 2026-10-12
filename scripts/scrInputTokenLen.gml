/*
input text change (added): the length of the input [token] (scrInputCode) starting at a position in a text, or 0 if there
isn't one there. Text typed out a letter at a time adds a whole token at once, so it never shows half of one.
argument0: the text
argument1: position
*/
var s,i,r,k;
s=argument0
i=argument1
if string_char_at(s,i)!="[" {return 0}
r=string_copy(s,i+1,string_length(s)-i)
k=string_pos("]",r)
if k=0 {return 0}
if scrInputTokenKeys(string_copy(r,1,k-1))="" {return 0}
return k+1
