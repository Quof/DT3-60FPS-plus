/*
Inserts zeros (0) into a value, example 0001 for a value of 1.
use: numZeroInsert(value,width)

argument0: value to use
argument1: total width required
*/

var strIN;
var strST;

strIN=string(argument0)
if argument1>string_length(strIN)
{
  strST=string_repeat("0",argument1-string_length(strIN))
}
else
{
  strST=""
}
strST+=strIN

return strST;
