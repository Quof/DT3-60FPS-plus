//Randomizer: an item message, as the game's own pickups show them (argument0: the text, # for new lines; argument1: the
//window's size, 1 for one line, 2 for two)
if argument1<=1 {msgCreate(170,100,"",argument0,6,1,oMessagePerson,0)}
else {msgCreate(140,80,"",argument0,6,2,oMessagePerson,0)}
newMessage.fadingTime=70+20*(argument1-1)
