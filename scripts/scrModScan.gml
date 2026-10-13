/*
mods change (added): the names in a mod folder as a new ds_list (the caller destroys it): the files with an extension
(without the extension), or the subfolders when the extension is "".
argument0: folder (ending in \)
argument1: extension, e.g. ".png", or ""
*/
var tL,tF,tExt,tLen;
tL=ds_list_create()
if !directory_exists(argument0) {return tL}
tExt=argument1
tLen=string_length(tExt)
if tExt="" {tF=file_find_first(argument0+"*",fa_directory)}
else {tF=file_find_first(argument0+"*"+tExt,0)}
while tF!=""
{
  if tExt=""
  {
    if tF!="." and tF!=".." {if directory_exists(argument0+tF) {ds_list_add(tL,tF)}}
  }
  else if string_lower(string_copy(tF,string_length(tF)-tLen+1,tLen))=string_lower(tExt)
  {
    ds_list_add(tL,string_copy(tF,1,string_length(tF)-tLen))
  }
  tF=file_find_next()
}
file_find_close()
ds_list_sort(tL,true)
return tL
