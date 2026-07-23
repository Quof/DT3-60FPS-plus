newMapX=160
newMapY=432
toRoom=rExtGateF_6
type=38
bossName="Nightmare"
award[0]=75
award[1]=45
award[2]=21
award[3]=13; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,6)
if tCheckGameProgress!="9" {instance_destroy()}
