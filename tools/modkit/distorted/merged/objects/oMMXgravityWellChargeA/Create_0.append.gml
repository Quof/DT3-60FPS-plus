//spsp ns
LEFT=18
RIGHT=19
pFacing=(oPlayer1.facing=RIGHT)-(oPlayer1.facing=LEFT) //1 when facing right, -1 when facing left
pFacing+=(pFacing==0) //default to right in case something goes wrong
