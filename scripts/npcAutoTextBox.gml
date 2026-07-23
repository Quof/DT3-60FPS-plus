/*
This script is used for NPC characters.
It will create a text box from the associated character and automatically fade without going out of their range.
*/

var tNewMessage,tBoxOffsetX,tBoxOffsetY;
if boxSize=0
{
  tBoxOffsetX=70
  tBoxOffsetY=26
}
else if boxSize=1
{
  tBoxOffsetX=100
  tBoxOffsetY=40
}
else if boxSize=2
{
  tBoxOffsetX=130
  tBoxOffsetY=54
}
else if boxSize=3
{
  tBoxOffsetX=160
  tBoxOffsetY=68
}

tNewMessage=instance_create(x-tBoxOffsetX,y-16-sprite_height-tBoxOffsetY,oMessageNPCAutoChat)
tNewMessage.talker=talker
tNewMessage.message=stringToShow
tNewMessage.fadingTime=65+(boxSize*15)
tNewMessage.wColor=myColor
tNewMessage.boxSize=boxSize
tNewMessage.idCheck=id
tNewMessage.xOffset=tBoxOffsetX
tNewMessage.yOffset=16+sprite_height+tBoxOffsetY
