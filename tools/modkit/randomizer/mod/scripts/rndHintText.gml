//Randomizer: a vending machine's hint about location argument0: "Ye who seek <its item>, look to <where it is>."
//(rndHintName; rndLocPlace, as the multiworld's location names have it). A name's [ and ] (the message box's button
//tokens) are ( and ), its # (a new line) a #
var t;
t=rndHintName(argument0)
t=string_replace_all(string_replace_all(string_replace_all(t,"[","("),"]",")"),"#","\#")
return "Ye who seek "+t+", look to "+global.rndLocPlace[argument0]+"."
