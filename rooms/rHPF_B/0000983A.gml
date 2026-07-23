sprite_index=sAntiBeta_Idle
talker="Defense Bot Beta"
if global.gameProgress<=3950
{
  stringToShow="All security doors should be open for you."
  boxSize=1
}
else if global.gameProgress>=3960 and global.gameProgress<=3969
{
  stringToShow="Apologies for the security door. The terminal back there can be used to open it."
  boxSize=2
}
else if global.gameProgress>=3970
{
  stringToShow="Once again we, the Defense Bot team, apologize for the door."
  boxSize=2
}

if global.gameProgress>=3980 {instance_destroy()}
