GID_SET(420748, self.id)
image_xscale=-1
boxSize=2
if global.gameProgress<=4960
  stringToShow="Don't worry about us out here. It's you guys that'll have to face against CHAOS out there."
else if global.gameProgress>=4970
  stringToShow="Looking around for a bit? No worries, the story doesn't advance without you."

if global.gameProgress<=4940 {instance_destroy()}
