if room=rDiscoA or room=rDiscoB or room=rDiscoC or room=rDiscoI      //spsp ns
{
    if oPlayer1.kJump>stored {invact=1-invact}
    stored=oPlayer1.kJump
    if invact {colorInverter(0,room_width,room_height)}
}
