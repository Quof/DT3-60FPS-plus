//Randomizer: the rows waiting under a requirement tried again (argument0: its number), now there's more of it. The
//lists are swapped for empty ones first: a row still lacking something is filed again as it's tried; an entry of an
//older filing, or of a row gone through, is skipped
var ix,lst,lg,n,j,inst,gen;
ix=argument0
lst=global.rndRWait[ix]
n=ds_list_size(lst)
if n=0 {exit}
lg=global.rndRWaitG[ix]
global.rndRWait[ix]=ds_list_create()
global.rndRWaitG[ix]=ds_list_create()
for(j=0;j<n;j+=1)
{
  inst=ds_list_find_value(lst,j)
  gen=ds_list_find_value(lg,j)
  if ds_grid_get(global.rndRGQ,inst mod global.rndEGsN,inst div global.rndEGsN)=gen {rndERTry(inst)}
}
ds_list_destroy(lst)
ds_list_destroy(lg)
