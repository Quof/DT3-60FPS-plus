newMapX=560
newMapY=288
toRoom=rExtGateB_6
type=9
bossName="Final Nightmare"
award[0]=165
award[1]=130
award[2]=95
award[3]=48; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,2)
if tCheckGameProgress!="9" {instance_destroy()}
