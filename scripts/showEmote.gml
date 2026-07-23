/*
Displays an emote.
usage: showEmote(obj,xx,yy,type)

argument0: object to follow
argument1: x adjustment
argument2: y adjustment
argument3: emote type
*/
var tNewEmote,tObj,tXX,tYY,tType;
tObj=argument0
tXX=argument1
tYY=argument2
tType=argument3

tNewEmote=instance_create(tXX,tYY,oCharEmote)
tNewEmote.sprite_index=tType
tNewEmote.followID=tObj
if tType=sEmMad {tNewEmote.image_speed=0.33}
else if tType=sEmThinking {tNewEmote.image_speed=0.15}
