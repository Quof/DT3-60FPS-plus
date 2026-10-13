//Randomizer: Central City - South's heart container. The game makes it there only in Nightmare mode, once the Trial
//Master's 7th trial is done; in a randomizer game it's a location in either mode, there once that trial is done (the
//roomStart hook, and oRndWatcher for the moment the trial ends)
var L,t;
if room!=rCCity_SGrove or global.bNightmareMode=1 or global.bBossGallery=1 {exit}
if string_char_at(global.trialMasterQuest,7)!="1" {exit}
L=rndLocFind(14,7)
if L<0 {exit}
if rndIsGot(L) {exit}
with (oHeartContainer) {if objectNum=7 {exit}}
t=instance_create(352,136,oHeartContainer)
t.objectNum=7
