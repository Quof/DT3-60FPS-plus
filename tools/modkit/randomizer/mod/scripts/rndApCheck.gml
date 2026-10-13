//Randomizer, Archipelago: a location checked (argument0: its number, marked got already): its id added to checks.txt
//for the client (the file written whole if it isn't there)
var f;
if !file_exists(global.rndApPath+"checks.txt") {rndApWriteChecks(); exit}
f=file_text_open_append(global.rndApPath+"checks.txt")
file_text_write_string(f,string(rndApLocId(argument0)))
file_text_writeln(f)
file_text_close(f)
