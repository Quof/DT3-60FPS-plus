/*
Warmaster II: true on the one frame the current attack state's timer (stT, in 30fps ticks) reaches argument0.
stPrev is stT before this frame's step, so this is true once at any frame rate.
argument0: the time in the state (ticks)
*/
return (stPrev<argument0 and stT>=argument0)
