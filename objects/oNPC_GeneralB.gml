#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-8,-46,8,-1)
messageTime=irandom(300)
currentString=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Automatically goes through text strings without player activation
if global.gamePaused=false
{
  messageTime+=1
  if messageTime>=messageDelay
  {
    stringToShow=myString[currentString]
    boxSize=myBoxSize[currentString]
    npcAutoTextBox()
    currentString+=1
    if currentString>=maxString {currentString=0}
    messageTime=irandom(60)
  }
}
