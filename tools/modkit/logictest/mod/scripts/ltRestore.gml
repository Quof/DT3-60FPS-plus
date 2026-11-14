//Logic Test: the globals snap took, put back as they were then (restore)
var k;
if !variable_global_exists("ltSnapN") {exit}
for(k=0;k<global.ltSnapN;k+=1)
{
  if global.ltSnapIx[k]<0 {variable_global_set(global.ltSnapName[k],global.ltSnapVal[k])}
  else {variable_global_array_set(global.ltSnapName[k],global.ltSnapIx[k],global.ltSnapVal[k])}
}
