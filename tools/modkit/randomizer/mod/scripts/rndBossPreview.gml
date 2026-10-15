//Randomizer: boss place argument0's preview, in the middle of its arena (rndBossMX/MY: where its fight holds the camera;
//none for a fight gone into by an exit or one that starts as its room is come into), while it isn't beaten (the
//roomStart hook): the boss fought there (rndBRFight) as a ghost of itself (rndBossPv: its look, bosspv.py). With Boss
//Rando, smoke instead till that fight has been seen (rndBossSeen: started once, rndBossStart), but where Boss Rando
//leaves the place's own boss (rndBossFixed)
var b,t;
b=argument0
if global.rndBossMX[b]<0 {exit}
t=instance_create(global.rndBossMX[b],global.rndBossMY[b],oRndBossPreview)
t.pvSpr=global.rndBossPv[global.rndBRFight[b]]
t.pvMode=0
if global.rndBRMode=1 and global.rndBossFixed[b]=0 and string_char_at(global.rndBossSeen,b+1)!="1" {t.pvMode=1}
if t.pvSpr<0 {t.pvMode=1}
