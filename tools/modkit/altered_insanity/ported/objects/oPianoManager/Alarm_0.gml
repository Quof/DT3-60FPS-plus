if global.cousinoer5Progress = 6
{
    //song of healing
    if string_pos(currentNoteString, noteStringOne) != 1
    {
        currentNoteString = ""
        with oNoteSignal
            {
                instance_destroy()
            }
    }
    else
    {
        if currentNoteString = noteStringOne
        {
            //msgCreate(0,0,"?????","You win",6,2,oMessagePerson,0)
            //newMessage.fadingTime=60
            global.cousinoer5Progress = 11
        }
        if string_length(currentNoteString) = 6
        {
            instance_create(648,64,oNoteSignal)
        }
    }
}
else
{
    currentNoteString = ""
}
/*
if global.cousinoer5Progress = 11
{
    //foam born
    if string_pos(currentNoteString, noteStringTwo) = 0
    {
        currentNoteString = ""
    }
    else
    {
        if currentNoteString = noteStringTwo
        {
            msgCreate(0,0,"?????","You win",6,2,oMessagePerson,0)
            newMessage.fadingTime=60
            global.cousinoer5Progress = 22
        }
    }
}
*/
