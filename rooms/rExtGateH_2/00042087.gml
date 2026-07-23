GID_SET(428282, self.id)
noteType=0
noteToRead="Only when all the
desk lamps in the house
are on will you be able
to return to your room.

The lights at the
stairwell, they are
your clue to the lamps.

          -?????"

if global.gateHProg<=6 {y+=256}
else if global.gateHProg>=8 {instance_destroy()}
