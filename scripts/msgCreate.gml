/*
Initializes the creation of a message box for cutscenes. (usually)
use: msgCreate(x,y,char,msg,color,size,type,wait)

argument0: window x Position
argument1: window y Position
argument2: character talking
argument3: message
argument4: window color
argument5: window size
argument6: message type (usually "oMessageCutscene")
argument7: if 1: Set wait for input to true (used for cutscenes only)

Note: If argument 0 or 1 = 0, then they will default to 32,48
Note: If argument 5 = 1, then it will be set to the center of the screen
*/
var tNWinX,tNWinY,tNChar,tNMessage,tNType,tNSize,tNWait;
tNWinX=argument0
tNWinY=argument1
tNChar=argument2
tNMessage=argument3
tNCol=argument4
tNSize=argument5
tNType=argument6
tNWait=argument7

if tNWinX=0 {tNWinX=32}
if tNWinY=0 {tNWinY=48}

newMessage=instance_create(tNWinX,tNWinY,tNType)
newMessage.message=tNMessage
newMessage.talker=tNChar
newMessage.wColor=tNCol
newMessage.wSize=tNSize

if tNWait=1
  bWaitForInput=true
