if active = true
{
    playSound(sound,0,1,0);
    active = false;
    with oPianoManager
    {
        currentNoteString += other.noteString
        //msgCreate(0,0,"?????",currentNoteString,6,2,oMessagePerson,0)
        //newMessage.fadingTime=60
        alarm[0] = 1
        if other.noteString = "B2"
        alarm[1] = 2
    }
    
}
