newMapX=400
newMapY=304
toRoom=rExtGateC_5
type=16
bossName="Blackmore"
award[0]=85
award[1]=55
award[2]=38
award[3]=12; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,3)
if tCheckGameProgress!="9" {instance_destroy()}
