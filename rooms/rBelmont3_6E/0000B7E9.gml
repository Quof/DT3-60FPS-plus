x+=8;y+=8
sprite_index=sCV_DeathParts
image_speed=0
soundToPlay=global.snd_HeartPiece
stringToShow="You found [Death's Heart]."
fadingTime=70
boxSize=1

gameProgCheck=string_char_at(global.gameGate3Prog,1)
if gameProgCheck="4"
  instance_destroy()
