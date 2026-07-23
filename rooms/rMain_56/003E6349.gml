GID_SET(308182, self.id)
sprite_index=sBubblun_Idle
image_speed=0.05
talker="Bubblun"
if global.gameProgress<=3350
{
  stringToShow="He's in the dungeons under the city. I don't know what's down there, just save him."
  boxSize=2
}
else if global.gameProgress>=3360
{
  stringToShow="John has shown me the games I'm from... They're kinda weird. You guys come up with some goofy stuff."
  boxSize=2
}

if global.gameProgress>=3870 {instance_destroy()}
