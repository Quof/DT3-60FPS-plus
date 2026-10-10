/*
fps title only change (added): the FPS option (Options > Graphics) can only be changed from the title screen. Trying it
anywhere else (oPauseMenu, where it's greyed out) plays the error sound and shows this message.
*/
playSound(global.snd_Error,0,1,1)
msgCreate(120,120,"","FPS can only be changed from the title screen due to framerate-dependent physics bugs.",7,2,oMessagePerson,0)
newMessage.fadingTime=55
