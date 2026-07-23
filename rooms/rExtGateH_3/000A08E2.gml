GID_SET(428270, self.id)
noteType=8
noteToRead="Claire,

You will not talk to
your father about this.
About what happened here.

You think I can take
this lightly.
You will stop locking
your door.
You will NOT avoid
punishment for this!

Get downstairs, Claire!"

if global.gateHProg>=19 {instance_destroy()}
else if global.gateHProg<=17 {y+=256}
