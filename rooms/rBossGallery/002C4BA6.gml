newMapX=272
newMapY=304
toRoom=rExtGateE_5
type=29
bossName="Shadow Form"
award[0]=100
award[1]=65
award[2]=21
award[3]=19; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,5)
if tCheckGameProgress!="9" {instance_destroy()}
