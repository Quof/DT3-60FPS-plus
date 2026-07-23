/*
Creates the Screen Text object
use: createScreenText(x,y,time,font,align,msg,shadow_type,blend,follow,type)

argument0: x position
argument1: y position
argument2: textTime    - Time on screen, -1 if infinite
argument3: textFont    - Font to use
argument4: textAlign   - Text alignment
argument5: screenText  - Text to draw
argument6: dropType    - Dropshadow type
argument7: image_blend - Inner text color
argument8: followType  - 0: World Absolute, 1: Screen Local
argument9: textType
-- 0: Normal
-- 1: Marquee
*/

var tTX,tTY,tTTime,tTFont,tTAlign,tTText,tTDrop,tTColor,tTFollow,tTType;
tTX=argument0
tTY=argument1
tTTime=argument2
tTFont=argument3
tTAlign=argument4
tTText=argument5
tTDrop=argument6
tTColor=argument7
tTFollow=argument8
tTType=argument9

newMessage=instance_create(tTX,tTY,oScreenText)
newMessage.textTime=tTTime
newMessage.textFont=tTFont
newMessage.textAlign=tTAlign
newMessage.screenText=tTText
newMessage.dropStyle=tTDrop
newMessage.image_blend=tTColor
newMessage.followType=tTFollow
newMessage.textType=tTType
