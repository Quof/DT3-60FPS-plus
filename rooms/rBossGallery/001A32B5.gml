newMapX=352
newMapY=416
toRoom=rExtGateD_6
type=26
bossName="Elpizo"
award[0]=85
award[1]=50
award[2]=23
award[3]=14; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,4)
if tCheckGameProgress!="9" {instance_destroy()}
