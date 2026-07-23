boxSize=2
if global.gameProgress<=900
  stringToShow="I'll try and find out as much as I can about the control center for you."
else if global.gameProgress>=910 and global.gameProgress<=980
  stringToShow="If you can destroy all the bots in that first room, you should be able to drop the barrier to get in."
else if global.gameProgress>=990 and global.gameProgress<=1510
  stringToShow="I'm really worried about all that strange activity with the Vault. The Darkness set it up to never be opened, it had a reason for that."
else if global.gameProgress>=1520 and global.gameProgress<=1980
  stringToShow="X went out there in a hurry, but he didn't say why."
else if global.gameProgress>=1990 and global.gameProgress<=2540
  stringToShow="I wonder who else out there might lend you two a hand like X and the others have done."
else if global.gameProgress>=2550 and global.gameProgress<=3860
{
  boxSize=3
  stringToShow="After you and Jeremy stopped the Artist, that engineer guy started helping people adjust to life here. A lot of the establishments you see here are due to his help."
}
else if global.gameProgress>=3870
  stringToShow="I never knew that CHAOS would become such a menace."

image_xscale=-1
if global.gameProgress>=3920 {instance_destroy()}
