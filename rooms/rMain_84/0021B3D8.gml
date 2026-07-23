boxSize=2
if global.gameProgress<=4960
  stringToShow="This castle is on the far east side of the Magical Woods. It's next to an area called the 'Magical Treeless Pass'."
else if global.gameProgress>=4970
  stringToShow="You found the castle? Not sure what you're doing over here then."

if global.gameProgress<=4940 {instance_destroy()}
