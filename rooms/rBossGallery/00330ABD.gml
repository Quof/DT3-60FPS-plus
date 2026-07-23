newMapX=320
newMapY=288
toRoom=rExtGateG_5
type=47
bossName="Sephiroth"
award[0]=90
award[1]=45
award[2]=16
award[3]=11; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,7)
if tCheckGameProgress!="9" {instance_destroy()}
