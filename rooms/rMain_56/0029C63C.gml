GID_SET(308183, self.id)
sprite_index=sLovelun_Idle
image_speed=0.05
talker="Lovelun"
if global.gameProgress<=3350
{
  stringToShow="If it wasn't for the engineer, we wouldn't be here, nor would we be able to think like we do."
  boxSize=2
}
else if global.gameProgress>=3360
{
  stringToShow="Thank you so much for bringing John back! Bubby was about to go into the city himself, but I was scared. I knew he would have gotten hurt."
  boxSize=3
}

if global.gameProgress>=3870 {instance_destroy()}
