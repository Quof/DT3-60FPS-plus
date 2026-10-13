/*
mods change (added): readies a mod's code for compiling. GameMaker can't add scripts while the game runs, so a mod's
scripts are compiled code (scrModCompile) called through scrModCall: every call of one of them, name( ... ), becomes
scrModCall(slot, ... ). A name that's only the end of a longer name, or comes after a '.', is left alone.
argument0: code
*/
var tCode,i,tName,tOut,tRest,tP,tPrev,tLen,c,j,tNext;
tCode=argument0
for(i=0;i<global.modScrCount;i+=1)
{
  tName=global.modScrName[i]
  if string_pos(tName+"(",tCode)=0 {continue}
  tOut=""
  tRest=tCode
  tLen=string_length(tName)+1
  tP=string_pos(tName+"(",tRest)
  while tP>0
  {
    //the character before the name
    if tP>1 {tPrev=string_char_at(tRest,tP-1)}
    else {tPrev=string_char_at(tOut,string_length(tOut))}
    tOut+=string_copy(tRest,1,tP-1)
    tRest=string_delete(tRest,1,tP-1+tLen)
    if tPrev="" {c=32}
    else {c=ord(tPrev)}
    if (c>=65 and c<=90) or (c>=97 and c<=122) or (c>=48 and c<=57) or c=95 or c=46
    {
      tOut+=tName+"("
    }
    else
    {
      //no arguments: name() (spaces allowed between the brackets)
      j=1
      tNext=string_char_at(tRest,j)
      while tNext=" " or tNext=chr(9) or tNext=chr(13) or tNext=chr(10) {j+=1; tNext=string_char_at(tRest,j)}
      if tNext=")" {tOut+="scrModCall("+string(i)}
      else {tOut+="scrModCall("+string(i)+","}
    }
    tP=string_pos(tName+"(",tRest)
  }
  tCode=tOut+tRest
}
return tCode
